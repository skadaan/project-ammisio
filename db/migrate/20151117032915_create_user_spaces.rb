class CreateUserSpaces < ActiveRecord::Migration
  def change
    create_table :user_spaces do |t|
      t.belongs_to :space, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
