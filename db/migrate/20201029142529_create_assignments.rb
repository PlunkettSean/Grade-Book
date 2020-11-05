class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
  	drop_table :assignments
    create_table :assignments do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
