module TourMaven
  module ApplicationHelper
    def options_for_enum(enum_options, selected = nil)
      options = enum_options.each { |k,v| [k, v] }

      options_for_select(options, selected)
    end
  end
end
