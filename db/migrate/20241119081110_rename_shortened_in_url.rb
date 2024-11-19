class RenameShortenedInUrl < ActiveRecord::Migration[8.0]
  def change
    rename_column :urls, :shortened, :short
  end
end
