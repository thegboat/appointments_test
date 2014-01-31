require 'csv'

class IntialSchema < ActiveRecord::Migration
  def change

    create_table :appointments do |t|
      t.string    :first_name, :null => false
      t.string    :last_name, :null => false
      t.string  :start_time, :null => false
      t.string  :end_time, :null => false
      t.text      :comments
    end

    add_index :appointments, :start_time
    add_index :appointments, :end_time
    add_index :appointments, [:last_name, :first_name]
    add_index :appointments, :first_name

  end

end
