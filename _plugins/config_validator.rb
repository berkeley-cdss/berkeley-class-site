# A UC Berkeley-specific validator for Jekyll site's.
class ConfigValidationError < StandardError
  attr_reader :errors

  def initialize(errors)
   super
   @errors = errors
  end

  def message
    "The config file contained validation errors:\n\t#{errors.join('\n\t')}\n\n"
  end
end


module Jekyll
  class ConfigValidator
    SEMESTER_REGEXP = /(wi|sp|su|fa)\d\d$/
    VALID_DEPTS = ['eecs', 'dsus', 'stat']
    KEY_VALIDATIONS = {
      baseurl: :validate_semester_format,
      course_department: :validate_department
    }

    attr_accessor :config, :errors
    def initialize(config)
      @config = config
      @errors = []
    end

    def validate
      validate_keys!

      KEY_VALIDATIONS.each do |key, validator|
        if @config.key?(key.to_s)
          self.send(validator, config[key.to_s])
        end
      end

      raise ConfigValidationError.new(errors) if errors.length > 0
      puts "Passed Berkeley YAML Config Validations"
    end

    def validate_keys!
      required_keys = [ :baseurl, :course_department ]
      required_keys.each do |key|
        errors << "#{key} is missing from site config" unless @config.key?(key.to_s)
      end
    end

    def validate_semester_format(baseurl)
      errors << "`baseurl` must start with a `/`." unless baseurl.match?(/^\//)
      # skip, just for the template.
      return if baseurl == '/berkeley-class-site'

      errors << "`baseurl` must be a valid semester (faXX, spXX, suXX or wiXX), not #{baseurl}" unless baseurl.match?(SEMESTER_REGEXP)
    end

    def validate_department(dept)
      errors << "`course_department` must be one of #{VALID_DEPTS} (not '#{dept}')" unless VALID_DEPTS.include?(dept)
    end
  end
end

Jekyll::Hooks.register [:site], :after_init do |site|
  break if ENV["JEKYLL_ENV"] == "production"

  Jekyll::ConfigValidator.new(site.config).validate
end
