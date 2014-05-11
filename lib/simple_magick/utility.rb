module SimpleMagick
  # Utility methods
  class Utility
    # @return [Boolean] true is Windows
    def self.windows?
      !!RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    end
  end
end