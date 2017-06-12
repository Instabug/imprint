require 'securerandom'

module Imprint
  class Tracer
    TRACER_HEADER    = 'HTTP_IMPRINTID'
    TRACER_KEY       = 'IMPRINTID'
    TRACE_ID_DEFAULT = "-1"

    def self.set_trace_id(id, rack_env = {})
      Thread.current[TRACER_KEY] = id
      # setting to the rack_env, gives error tracking support in some systems
      rack_env[TRACER_KEY] = id
    end

    def self.get_trace_id
      if Thread.current.key?(TRACER_KEY)
        Thread.current[TRACER_KEY]
      else
        TRACE_ID_DEFAULT
      end
    end

    def self.get_pid
      "#{$$}"
    end

    def self.rand_trace_id
      SecureRandom.uuid
    end
  end
end

