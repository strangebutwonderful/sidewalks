module ApplicationHelper

  def application_meta_tags
    [
      tag('meta', :name => 'app-environment', :content => Rails.env),
      tag('meta', :name => 'app-config-mapbox-id', :content => ENV['MAPBOX_ID'])  
    ].join("\n").html_safe
  end

end
