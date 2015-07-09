module NavTabHelper

  def nav_tab_tag(active_tab, tab_id, &block)
    if active_tab == tab_id
      set_class_to =  "active"
    else
      set_class_to = nil
    end
    content_tag :li, capture(&block), class: set_class_to

  end

  def nav_pane_tag(active_tab, tab_id, &block)
    if active_tab == tab_id
      set_class_to = "tab-pane active"
    else
      set_class_to = "tab-pane"
    end
    content_tag :div, capture(&block), class: set_class_to, id: tab_id
  end

end