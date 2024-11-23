class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.time :request_time
      t.string :city
      t.string :country
      t.belongs_to :url, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
