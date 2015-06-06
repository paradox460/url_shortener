class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      # Text because there is no limit to how long a URL actually can be, even
      # though some dumber browsers may claim otherwise (IE)
      t.text :url

      t.integer :salt

      t.timestamps null: false
    end
  end
end
