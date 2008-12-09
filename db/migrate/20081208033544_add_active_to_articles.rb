class AddActiveToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :active, :boolean
    add_column :articles, :weight, :integer
  end

  def self.down
    remove_column :articles, :active
    remove_column :articles, :weight
  end
end
