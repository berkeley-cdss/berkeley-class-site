# frozen_string_literal: true

# A UC Berkeley-specific validator for Jekyll sites
# This class validates the following options:
# 1) Ensures required attributes are present in the config file.
# 2) Ensures the baseurl is a consistent format based on the semester
# 3) Uses a `course_department` config to implement some shared styling/language.
# 4) Ensures the `color_scheme` is valid.
# Future config validations might make sense, like footer/a11y/etc. configuration,

# Implement additional validations by registering an entry in `KEY_VALIDATIONS`
# This is a key_name => function_name map.
# function_name should be defined in the ConfigValidator class, and is called with
# the key, value pair in the config.
# Note that Jekyll parses the YAML file such that the config keys are *strings* not symbols.

# See the inclusion_validator to add simple allow-list style validations

# A simple class for nicer error message formatting.
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
  # Jekyll::ConfigValidator class definition (see docs at the top of file)
  class ConfigValidator
    SEMESTER_REGEXP = /(wi|sp|su|fa)\d\d$/
    VALID_COURSE_DEPARTMENT = %w[eecs dsus stat].freeze
    VALID_COLOR_SCHEME = %w[light dark].freeze

    # To validate a key with an 'allow list':
    # Use the function :inclusion_validator
    # and definite VALID_KEY_NAME above
    KEY_VALIDATIONS = {
      url: :validate_clean_url,
      baseurl: :validate_semester_format,
      course_department: :inclusion_validator,
      color_scheme: :inclusion_validator
    }.freeze

    attr_accessor :config, :errors

    def initialize(config)
      @config = config
      @errors = []
    end

    def validate
      validate_keys!

      KEY_VALIDATIONS.each do |key, validator|
        send(validator, key, config[key.to_s]) if @config.key?(key.to_s)
      end

      raise ConfigValidationError, errors if errors.length.positive?

      puts 'Passed Berkeley YAML Config Validations'
    end

    def validate_keys!
      required_keys = %i[baseurl course_department]
      required_keys.each do |key|
        errors << "#{key} is missing from site config" unless @config.key?(key.to_s)
      end
    end

    private

    def validate_clean_url(_key, url)
      errors << '`url` should not end with a `/`' if url.end_with?('/')
      errors << '`url` should contain a protocol' unless url.match?(%r{https?://})
    end

    def validate_semester_format(_key, baseurl)
      # This is just for consistency of URL presentation.
      errors << '`baseurl` must start with a `/`.' unless baseurl.match?(%r{^/})
      # skip, just for the template.
      return if baseurl == '/berkeley-class-site'

      return if baseurl.match?(SEMESTER_REGEXP)

      errors << "`baseurl` must be a valid semester (faXX, spXX, suXX or wiXX), not #{baseurl}"
    end

    def inclusion_validator(key, value)
      allowed = self.class.const_get("VALID_#{key.upcase}")
      errors << "`#{key}` must be one of #{allowed} (not '#{value}')" unless allowed.include?(value)
    end
  end
end

Jekyll::Hooks.register [:site], :after_init do |site|
  next if ENV['JEKYLL_ENV'] == 'production'

  Jekyll::ConfigValidator.new(site.config).validate
end
