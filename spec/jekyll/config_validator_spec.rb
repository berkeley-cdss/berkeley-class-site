# frozen_string_literal: true

require 'spec_helper'
require_relative '../../_plugins/config_validator'

RSpec.describe Jekyll::ConfigValidator do
  let(:base_config) do
    {
      'baseurl' => '/sp26',
      'course_department' => 'dsus',
      'semester_start_date' => '2026-01-21',
      'semester_end_date' => '2026-05-09'
    }
  end

  it 'validates with required semester dates present' do
    validator = described_class.new(base_config)

    expect { validator.validate }.not_to raise_error
  end

  it 'requires semester_start_date and semester_end_date' do
    config = base_config.except('semester_start_date', 'semester_end_date')
    validator = described_class.new(config)

    expect { validator.validate }
      .to raise_error(ConfigValidationError, /semester_start_date is missing.*semester_end_date is missing/m)
  end

  it 'validates ISO-8601 semester dates' do
    validator = described_class.new(base_config.merge('semester_start_date' => 'spring-2026'))

    expect { validator.validate }
      .to raise_error(ConfigValidationError, /`semester_start_date` must be a valid ISO-8601 date string/)
  end

  it 'requires the start date to be on or before the end date' do
    validator = described_class.new(base_config.merge('semester_start_date' => '2026-06-01'))

    expect { validator.validate }
      .to raise_error(ConfigValidationError, /`semester_start_date` must be on or before `semester_end_date`/)
  end
end
