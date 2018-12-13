module Api
  class VersionConstraints
    def initialize(version: 'v1', default: false)
      @version = version
      @default = default
    end

    def matches?(req)
      @default || req.headers['Accept'] =~ regex
    end

    private

    def format_version
      if @version.instance_of?(Array)
        @version.join(',')
      else
        @version
      end
    end

    def regex
      /application\/vnd.libis-teneo.v[#{format_version}]\+json/
    end
  end
end