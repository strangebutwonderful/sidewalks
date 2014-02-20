module ApplicationHelper

  def application_meta_tags
    [
      application_environment_meta_tag 
    ].join("\n").html_safe
  end

  def application_environment_meta_tag
    tag('meta', :name => 'environment', :content => Rails.env)
  end

end
