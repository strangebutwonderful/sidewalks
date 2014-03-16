module ApplicationHelper

  def title?
    content_for?(:title)
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def application_meta_tags
    [
      tag('meta', :name => 'app-environment', :content => Rails.env),
      tag('meta', :name => 'app-config-mapbox-id', :content => ENV['MAPBOX_ID'])  
    ].join("\n").html_safe
  end

end
