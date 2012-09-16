module Uplodar
  module ApplicationHelper

    def title(page_title, show_title = true)
      @show_title = show_title
      @content_for_title = page_title.to_s
    end

    def show_title?
      @show_title
    end

    def stylesheet(*args)
      content_for(:head) { stylesheet_link_tag(*args) }
    end

    def javascript(*args)
      content_for(:head) { javascript_include_tag(*args) }
    end

    def entry_icon(entry_type)
      case entry_type
      when 'directory'
        "icon-folder-open"
      else
        "icon-file"
      end
    end
  end
end
