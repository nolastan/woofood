class AddLastToItems < ActiveRecord::Migration
    def self.up
      add_column :items, :last, :date
    end

    def self.down
      remove_column :items, :last
    end
  end
