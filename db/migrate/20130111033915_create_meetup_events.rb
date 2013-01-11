class CreateMeetupEvents < ActiveRecord::Migration
  def change
    create_table :meetup_events do |t|
      t.string :identifier
      t.string :description

      t.timestamps
    end
  end
end
