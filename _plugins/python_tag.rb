# frozen_string_literal: true

module Jekyll
  BEGIN_SOLUTION = '# BEGIN SOLUTION'
  END_SOLUTION = '# END SOLUTION'

  # Custom Liquid tag for including Python files in _includes/
  # so that the solutions appear only when specified.
  # Example format of .py file: _includes/test.py
  #
  # Inherits from Jekyll's built-in include tag:
  # https://github.com/jekyll/jekyll/blob/master/lib/jekyll/tags/include.rb
  # TODO: create superclass and specify comment character(s) to generalize behavior to other languages
  class PythonTag < Jekyll::Tags::IncludeTag
    def initialize(tag_name, params, tokens)
      parse_params(params)
      super(tag_name, @file_name, tokens)
    end

    def parse_params(params)
      file_name, show_solution = params.strip.split

      raise ArgumentError, "File name '#{file_name}' must end in .py" if file_name[-3..] != '.py'

      unless %w[true false].include?(show_solution)
        raise ArgumentError, "Second argument to python tag must be a boolean, not '#{show_solution}'"
      end

      show_solution = show_solution == 'true'

      @file_name = file_name
      @show_solution = show_solution
    end

    def render(context)
      raw_lines = super.split("\n")
      saw_begin = false
      saw_end = false
      parsed_lines = []

      raw_lines.each_with_index do |line, index|
        if line.include?(BEGIN_SOLUTION)
          raise PythonTagError, "Duplicate '#{BEGIN_SOLUTION}' at _includes/#{@file_name}:#{index + 1}" if saw_begin

          saw_begin = true
          saw_end = false
        elsif line.include?(END_SOLUTION)
          raise PythonTagError, "'#{END_SOLUTION}' without preceding '#{BEGIN_SOLUTION}' at _includes/#{@file_name}:#{index + 1}" unless saw_begin
          
          saw_begin = false
          saw_end = true
        elsif !saw_begin || (saw_begin && @show_solution)
          parsed_lines.push(line)
        end
      end

      raise PythonTagError, "'#{BEGIN_SOLUTION}' without matching '#{END_SOLUTION}'" if saw_begin && !saw_end

      parsed_lines.join("\n")
    end
  end

  class PythonTagError < StandardError
  end
end

Liquid::Template.register_tag('python', Jekyll::PythonTag)
