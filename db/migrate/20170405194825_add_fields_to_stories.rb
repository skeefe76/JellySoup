class AddFieldsToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :version_date, :date
    change_column :stories, :manuscript, :text
  end
end
