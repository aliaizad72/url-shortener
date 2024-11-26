class AddUserToUrls < ActiveRecord::Migration[8.0]
  def change
    add_reference :urls, :user
  end
end
