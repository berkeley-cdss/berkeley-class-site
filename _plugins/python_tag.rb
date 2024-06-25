# frozen_string_literal: true

module Jekyll
  BEGIN_SOLUTION = '# BEGIN SOLUTION'
  END_SOLUTION = '# END SOLUTION'

  # Custom Liquid tag for including Python files in _includes/
  # so that the solutions appear only when specified.
  #
  # Inherits from Jekyll's built-in include tag:
  # https://github.com/jekyll/jekyll/blob/master/lib/jekyll/tags/include.rb
  # TODO: create superclass and specify comment character(s) to generalize behavior to other languages
  class PythonTag < Jekyll::Tags::IncludeTag
    # Expected format of this tag:
    #   {% python file_name.py true %}
    #
    #   tag_name is "python"
    #   params   is " file_name.py show_solution_boolean "
    #
    # Example: {% python test.py true %}
    # Example: {% python test.py page.show_solutions %}
    #
    # NOTE: the file name is the path relative to the _includes/ directory
    def initialize(tag_name, params, tokens)
      parse_params(params)
      super(tag_name, @file_name, tokens)
    end

    def parse_params(params)
      file_name, show_solution = params.strip.split

      raise ArgumentError, "File name '#{file_name}' must end in .py" if file_name[-3..] != '.py'

      @file_name = file_name
      @show_solution = show_solution
    end

    def string_boolean?(value)
      %w[true false].include?(value)
    end

    def boolean?(value)
      [true, false].include?(value)
    end

    def to_boolean(value)
      raise ArgumentError, "value must be 'true' or 'false' not '#{value}' (type #{value.class})" unless string_boolean?(value)

      value == 'true'
    end

    # Parse the lines read from the .py file by IncludeTag
    # to strip/keep solutions
    def parse_file_lines(raw_lines)
      saw_begin = false
      saw_end = false
      parsed_lines = []

      raw_lines.each_with_index do |line, index|
        if line.include?(BEGIN_SOLUTION)
          raise PythonTagError, "Duplicate '#{BEGIN_SOLUTION}' at _includes/#{@file_name}:#{index + 1}" if saw_begin

          saw_begin = true
          saw_end = false
        elsif line.include?(END_SOLUTION)
          unless saw_begin
            raise PythonTagError,
                  "'#{END_SOLUTION}' without preceding '#{BEGIN_SOLUTION}' at _includes/#{@file_name}:#{index + 1}"
          end

          saw_begin = false
          saw_end = true
        elsif !saw_begin || (saw_begin && @show_solution)
          parsed_lines.push(line)
        end
      end

      raise PythonTagError, "'#{BEGIN_SOLUTION}' without matching '#{END_SOLUTION}'" if saw_begin && !saw_end

      parsed_lines.join("\n")
    end

    def render(context)
      # If the 2nd argument to the tag is a jekyll variable/front matter
      # (rather than boolean), attempt to retrieve it
      if string_boolean?(@show_solution)
        @show_solution = to_boolean(@show_solution)
      else
        jekyll_variable_value = context[@show_solution]

        raise ArgumentError, "Second argument to python tag must be a boolean, not '#{jekyll_variable_value}' (type #{jekyll_variable_value.class})" unless boolean?(jekyll_variable_value)

        @show_solution = jekyll_variable_value
      end

      raw_lines = super.split("\n")
      parse_file_lines(raw_lines)
    end
  end

  class PythonTagError < StandardError
  end
end

Liquid::Template.register_tag('python', Jekyll::PythonTag)
