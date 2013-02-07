module JSV
  class Report
    attr_reader :result

    def initialize(result)
      @result = result
    end

    def errors
      result['errors']
    end

    def has_errors?
      !errors.empty?
    end
  end
end
