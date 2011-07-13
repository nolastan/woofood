class FixLastType < ActiveRecord::Migration
    def self.up
      change_table :items do |t|
        t.change :last, :date
      end
    end

    def self.down
      change_table :items do |t|
        t.change :last, :string
      end
    end
  end