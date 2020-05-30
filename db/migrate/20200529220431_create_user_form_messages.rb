class CreateUserFormMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_form_messages do |t|
      t.belongs_to :user_form, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :message, null: false

      t.timestamps null: false
    end
    add_index :user_form_messages, :created_at
  end
end
