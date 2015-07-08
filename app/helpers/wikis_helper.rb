module WikisHelper

  def tags_to_links(tag_list)
    tag_list.map { |t| link_to t, tag_path(t) }.join(', ').html_safe
  end

end
