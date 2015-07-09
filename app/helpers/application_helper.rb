module ApplicationHelper

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {
      fenced_code_blocks: true,
      underline: true,
      highlight: true,
      footnotes: true
    }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

  def links_list(links)
    all_links = []
    links.each do |link|
      next_link = (link_to link.title, link.url)
      if policy(link).edit?
        next_link += (link_to " *", edit_link_path(link))
      end
      all_links << next_link
    end
    return all_links.join(', ').html_safe
  end

  def tags_to_links(tag_list)
    tag_list.map { |t| link_to t, tag_path(t) }.join(', ').html_safe
  end

end
