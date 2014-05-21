class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :content
      t.timestamp :due

      t.timestamps
    end
  end
end
