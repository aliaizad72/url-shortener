class ChangeTimeToDateTime < ActiveRecord::Migration[8.0]
  def change
    change_column :visits, :request_time, :string
  end
end
