class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.datetime :closes_at

      t.datetime :opened_at
      t.datetime :closed_at

      t.string :label
      t.string :short_label
      t.string :creator
      t.string :btc_public_address
      t.string :btc_open_txid
      t.string :btc_close_txid

      t.integer :match_type

      t.text :url
      t.text :match_javascript
      t.text :match_regex

      t.integer :execution_return
      t.text :execution_title
      t.attachment :execution_screenshot

      t.boolean :include_jquery
      t.boolean :is_opened
      t.boolean :is_closed
      t.boolean :is_funded

      t.timestamps
    end
  end
end
