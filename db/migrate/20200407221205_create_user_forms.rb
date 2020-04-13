class CreateUserForms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_forms do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
