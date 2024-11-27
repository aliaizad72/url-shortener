class AddIpToVisit < ActiveRecord::Migration[8.0]
  def change
    add_column :visits, :ip, :string
  end
end
