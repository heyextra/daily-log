class AddSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.belongs_to :user, null: false
      t.string :time_zone, null: false, default: "Eastern Time (US & Canada)"
      t.date :start_date
      t.integer :frequency, null: false, default: 2
      
      t.timestamps
    end

    User.find_each(&:create_settings!)
  end
end
