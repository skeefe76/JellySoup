class AddUserIdToStories < ActiveRecord::Migration[5.0]
  def up
    Story.delete_all
    remove_column :stories, :author
    add_column    :stories, :user_id, :integer
  end

  def down
    Story.delete_all
    remove_column :stories, :user_id
    add_column    :stories, :author, :string
  end
end
