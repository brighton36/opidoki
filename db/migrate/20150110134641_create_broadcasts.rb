class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.datetime :closes_at

      t.string :label
      t.string :short_label
      t.string :creator
      t.string :btc_public_address

      t.integer :match_type

      t.text :url
      t.text :match_javascript
      t.text :match_regex


      t.boolean :include_jquery
      t.boolean :is_opened
      t.boolean :is_closed
      t.boolean :is_funded

      t.timestamps
    end
  end
end
