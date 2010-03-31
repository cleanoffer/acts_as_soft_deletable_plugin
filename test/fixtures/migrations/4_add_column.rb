class AddColumn < ActiveRecord::Migration
  class Thing < ActiveRecord::Base
    acts_as_soft_deletable
  end

  def self.up
    add_column :things, :sku, :string
  end
  
  def self.down
    remove_column :things, :sku
  end
end
