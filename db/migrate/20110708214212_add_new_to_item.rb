class AddNewToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :new, :bool
  end

  def self.down
    remove_column :items, :new
  end
end
