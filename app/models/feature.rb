# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  enabled    :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

class Feature < ActiveRecord::Base
  extend Flip::Declarable

  # strategy Flip::CookieStrategy
  strategy Flip::DatabaseStrategy
  strategy Flip::DeclarationStrategy
  default false

  # Declare your features here, e.g:
  #
  # feature :world_domination,
  #   default: true,
  #   description: "Take over the world."

  feature :rake_import_twitter,
          default: true,
          description: 'Import tweets via a rake task'

  feature :rake_import_twitter_accounts,
          default: true,
          description: 'Import twitter users via a rake task'

  # Helper functions, mapping to Flip gem

  def self.on?(feature_key)
    Flip.on? feature_key
  end

  def self.on!(feature_key)
    Feature.switch!(feature_key, true)
  end

  def self.off!(feature_key)
    Feature.switch!(feature_key, false)
  end

  def self.switch!(feature_key, enable)
    Flip::FeatureSet.instance.strategy('database').switch!(feature_key, enable)
  end
end
