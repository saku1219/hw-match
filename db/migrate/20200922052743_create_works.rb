class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.integer     :type_id,     null: false
      t.string      :name,        null: false
      t.integer     :genre_id,    null: false
      t.datetime    :start_time,  null: false
      t.datetime    :end_time,    null: false
      t.text        :description, null: false
      t.references  :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
