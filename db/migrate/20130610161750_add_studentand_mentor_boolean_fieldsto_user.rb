class AddStudentandMentorBooleanFieldstoUser < ActiveRecord::Migration
  def up
    add_column :users, :mentor, :integer
    add_column :users, :student, :integer
  end

  def down
  end
end
