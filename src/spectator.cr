module Grip
  abstract class Application
    def handlers : Array(HTTP::Handler)
      handlers = [
        @exception_handler,
        @pipeline_handler,
        @forward_handler,
        @websocket_handler,
        @http_handler,
      ] of HTTP::Handler

      custom.each do |handler|
        handlers.insert(handlers.size - 4, handler)
      end

      root.each do |handler|
        handlers.insert(handlers.size - 2, handler)
      end

      {% if flag?(:serveStatic) %}
        handlers.insert(1, @static_handler.not_nil!)
      {% end %}

      handlers
    end
  end
end

{% for method in %w(get post put head delete patch) %}
  def {{method.id}}(application : Grip::Application, path : String, headers : HTTP::Headers? = nil, body : String? = nil)
    io = IO::Memory.new
    request = HTTP::Request.new("{{method.id}}".upcase, path, headers, body)
    response = HTTP::Server::Response.new(io)

    context = HTTP::Server::Context.new(request, response)
    handlers = application.handlers

    0.upto(handlers.size - 2) { |i| handlers[i].next = handlers[i + 1] }

    process_request(context, handlers)
    response.close
    io.rewind

    HTTP::Client::Response.from_io(io, decompress: false)
  end
{% end %}

def process_request(context : HTTP::Server::Context, handlers : Array(HTTP::Handler))
  handler = handlers.first
  handler.call(context)
end