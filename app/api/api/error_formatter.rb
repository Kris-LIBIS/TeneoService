module Api
  module ErrorFormatter
    def self.call(message, backtrace, options, env)
      {response_type: 'error', repsonse: message}.to_json
    end
  end
end
