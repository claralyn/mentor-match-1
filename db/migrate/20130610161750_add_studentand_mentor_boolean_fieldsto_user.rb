class AddStudentandMentorBooleanFieldstoUser < ActiveRecord::Migration
  def up
    add_column :users, :mentor, :boolean, default: false
    add_column :users, :student, :boolean, default: false
  end

  def down
  end
end
