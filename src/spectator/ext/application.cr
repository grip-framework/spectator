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
