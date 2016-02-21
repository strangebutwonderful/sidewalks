# Simple scripts
namespace :populate do
  desc "Create fake noises for use in development"
  task noises: :environment do
    FactoryGirl.create_list(:noise, 10)
    FactoryGirl.create_list(:noise_in_san_francisco, 10)
  end
end

task populate: ["populate:noises"]
