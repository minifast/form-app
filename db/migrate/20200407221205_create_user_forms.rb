class CreateUserForms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_forms do |t|
      t.string :formname

      t.timestamps
    end
  end
end
