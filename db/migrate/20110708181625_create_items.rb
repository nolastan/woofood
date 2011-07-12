class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.string :group
      t.string :location
      t.decimal :calories
      t.decimal :fat_calories
      t.decimal :fat
      t.decimal :sat_fat
      t.decimal :trans_fat
      t.decimal :cholesterol
      t.decimal :sodium
      t.decimal :carb
      t.decimal :fiber
      t.decimal :sugar
      t.decimal :protein

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
