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
      all_links << (link_to link.title, link.url)
    end
    return all_links.join(', ').html_safe
  end

  def tags_to_links(tag_list)
    tag_list.map { |t| link_to t, tag_path(t) }.join(', ').html_safe
  end

  def nav_pane_tag(page, page_type, pane_id, &block)
    if page == page_type
      content_tag :div, capture(&block), class: "tab-pane active", id: pane_id
    else
      content_tag :div, capture(&block), class: "tab-pane", id: pane_id
    end
  end

end
