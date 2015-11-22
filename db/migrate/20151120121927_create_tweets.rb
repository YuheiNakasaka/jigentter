class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :user_id, null: false
      t.string :text
      t.integer :tweet_identifier, :limit => 8

      t.timestamps null: false
    end
    add_index :tweets, :user_id
  end
end
