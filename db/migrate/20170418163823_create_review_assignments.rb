class CreateReviewAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :review_assignments do |t|
      t.references :user, foreign_key: true
      t.references :story, foreign_key: true
      t.boolean :review_complete

      t.timestamps
    end
  end
end
