class IntialSchema < ActiveRecord::Migration
  def change

    create_table :appointments do |t|
      t.integer   :contact_id, :null => false
      t.datetime  :start_time, :null => false
      t.datetime  :end_time, :null => false
      t.text      :comments
    end

    add_index :appointments, :start_time
    add_index :appointments, :end_time
    add_index :contact_id, :end_time

    create_table :contacts do |t|
      t.string    :first_name, :null => false
      t.string    :last_name, :null => false
    end

    add_index :contacts, [:last_name, :first_name]
    add_index :contacts, :first_name

  end
end
