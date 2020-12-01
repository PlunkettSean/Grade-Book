class CreateStudentGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :student_grades do |t|
      t.decimal :grade
      t.references :student, foreign_key: true
      t.references :assignment, foreign_key: true

      t.timestamps
    end
  end
end
