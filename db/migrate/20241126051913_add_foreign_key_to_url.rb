class AddForeignKeyToUrl < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :urls, :users
  end
end
