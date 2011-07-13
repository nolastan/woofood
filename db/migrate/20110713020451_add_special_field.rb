class AddSpecialField < ActiveRecord::Migration
  def self.up
    add_column :items, :special, :bool
  end

  def self.down
    remove_column :items, :special
  end
end
