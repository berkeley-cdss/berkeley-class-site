# frozen_string_literal: true

require 'time'

# TODO: We should be able to define a class that returns
# A class so these all share code.
module Jekyll
  # Add discussion classes to a resource on the website calendar.
  class DiscussionTag < Liquid::Tag
    def initialize(tag_name, number, tokens)
      super
      @number = number.strip
    end

    def render(_context)
      "**Discussion #{@number}**{: .label .label-disc }"
    end
  end

  # Used to render when a homework assignment is first released
  class HomeworkReleaseTag < Liquid::Tag
    def initialize(tag_name, number, tokens)
      super
      @number = number.strip
    end

    def render(_context)
      "**Homework #{@number}**{: .label .label-hw-rel }"
    end
  end

  # Add tags for a lecture, and link to the appropriate page.
  class LectureTag < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      # Split the input into a number and a title
      parts = input.strip.split(/\s+/, 2)
      @number = parts[0]
      @number_updated = @number.rjust(2, '0')
      # @slug = parts[1]
    end

    def render(context)
      lectures = context['site']['lectures']
      lecture = lectures.find { |l| l.basename_without_ext == @number_updated }
      return 'No lecture found' unless lecture # in case the lecture isn't found

      lecture_title = lecture['title']
      lecture_url = lecture.url
      # Directly grab the date string from the lecture data
      date_parts = lecture['date'].to_s.split('-')
      year = date_parts[0].to_i
      month = date_parts[1].to_i
      day = date_parts[2].to_i
      if lecture['time'].nil?
        hour = 0
        minute = 0
      else
        hour = lecture['time'] / 60 # lecture['time'] is expressed in minutes (i.e. 10:40 is 640)
        minute = lecture['time'] % 60
      end
      # Construct the date manually
      lecture_time = Time.new(year, month, day, hour, minute)
      Jekyll.logger.info "DEBUG", "Time is #{lecture_time}"

      current_time = Time.now
      Jekyll.logger.info "DEBUG", "Current Time is #{current_time}"

      # Always render an anchor so client-side JS can toggle links in real time.
      # Attach a machine-readable ISO timestamp in `data-release`.
      release_iso = lecture_time.utc.iso8601
      # Use the lecture's URL (Jekyll document.url) and include the data-release attribute.
      "**Lecture #{@number}**{: .label .label-lec } <a href=\"..#{lecture_url}\" data-release=\"#{release_iso}\">#{lecture_title}</a>"
      
    end
  end

  # Used for when a project is released (outline style label)
  class ProjectReleaseTag < Liquid::Tag
    def initialize(tag_name, number, tokens)
      super
      @number = number.strip
    end

    def text
      return "Project #{@number}" if @number.to_i.to_s == @number

      "#{@number} Project"
    end

    def render(_context)
      "**#{text}**{: .label .label-proj-rel }"
    end
  end

  # Used on the calendar when the homework is due (solid-style label)
  class HomeworkDueTag < Liquid::Tag
    def initialize(tag_name, number, tokens)
      super
      @number = number.strip
    end

    def render(_context)
      "**Homework #{@number}**{: .label .label-hw-due }"
    end
  end

  # Used for the due date entry for a project (solid-style label)
  class ProjectDueTag < Liquid::Tag
    def initialize(tag_name, number, tokens)
      super
      @number = number.strip
    end

    def text
      return "Project #{@number}" if @number.to_i.to_s == @number

      "#{@number} Project"
    end

    def render(_context)
      "**#{text}**{: .label .label-proj-due }"
    end
  end
end

Liquid::Template.register_tag('disc', Jekyll::DiscussionTag)
Liquid::Template.register_tag('hw_rel', Jekyll::HomeworkReleaseTag)
Liquid::Template.register_tag('hw_due', Jekyll::HomeworkDueTag)
Liquid::Template.register_tag('lec', Jekyll::LectureTag)
Liquid::Template.register_tag('proj_rel', Jekyll::ProjectReleaseTag)
Liquid::Template.register_tag('proj_due', Jekyll::ProjectDueTag)
