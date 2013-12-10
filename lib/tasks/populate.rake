# Simple scripts 
namespace :populate do
  
  task :noises => :environment do
    FactoryGirl.create_list(:noise, 10)
    FactoryGirl.create_list(:noise_with_coordinates, 10)
  end

  task :all => [:noises]

end