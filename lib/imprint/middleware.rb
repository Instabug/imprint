module Imprint
  class Middleware

    def self.set_request_trace_id(rack_env)
      trace_id = rack_env[Imprint::Tracer::TRACER_HEADER]
      if trace_id.nil?
        trace_id = Imprint::Tracer.rand_trace_id
      end
      Imprint::Tracer.set_trace_id(trace_id, rack_env)
    end

    def initialize(app, _opts = {})
      @app = app
    end

    def call(env)
      ::Imprint::Middleware.set_request_trace_id(env)
      @app.call(env)
    end

  end
end
