class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
  	
    create_table :assignments do |t|
      t.references :course, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
