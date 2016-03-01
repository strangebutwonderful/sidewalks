require File.expand_path("../config/boot",        __FILE__)
require File.expand_path("../config/environment", __FILE__)
require "clockwork"

module Clockwork
  every 5.minutes, "Informants::Twitter::ImportNoisesJob" do
    Informants::Twitter::ImportNoisesJob.perform_later
  end

  every 1.day, "Informants::Twitter::ImportUsersJob", at: "3:30" do
    Informants::Twitter::ImportUsersJob.perform_later
  end
end
