class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls do |t|
      t.string :shortened
      t.string :target
      t.string :title

      t.timestamps
    end
  end
end
