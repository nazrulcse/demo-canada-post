renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true)
markdown = Redcarpet::Markdown.new(renderer, extensions = {})