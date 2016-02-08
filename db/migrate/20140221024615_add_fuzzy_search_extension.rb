class AddFuzzySearchExtension < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'
    execute 'CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;'
  end

  def down
    execute 'DROP EXTENSION pg_trgm;'
    execute 'DROP EXTENSION fuzzystrmatch;'
  end
end
