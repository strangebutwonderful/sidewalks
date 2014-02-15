# Simple scripts 
namespace :populate do
  
  task :noises => :environment do
    unless Rails.env.production?
      FactoryGirl.create_list(:noise, 10)
      FactoryGirl.create_list(:noise_with_coordinates, 10)
    end
  end

  task :all => [:noises]

end