class RemoveColumn < ActiveRecord::Migration
  class Thing < ActiveRecord::Base
    acts_as_soft_deletable
  end

  def self.up
    remove_column :things, :sku
  end
  
  def self.down
    add_column :things, :sku, :string
  end
end
