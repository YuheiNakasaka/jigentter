class AddColumnToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :img_data, :binary, limit: 5.megabyte
    add_column :tweets, :mine, :string
  end
end
