# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.create( email: "admin@mentormatch.com",
                          password: "password")
admin_user.admin = true
admin_user.confirm!


user_student = User.create( email: "student@mentormatch.com",
                            password: "password")

student_user = Student.new(personal_first_name: "Harper",
                              personal_last_name: "Christopherson",
                              user_id: user_student)

student_user.save!
user_student.confirm!

user_mentor = User.create( email: "mentor@mentormatch.com",
                            password: "password")

mentor_user = Mentor.new(personal_first_name: "Risk",
                              personal_last_name: "Whistler",
                              user: user_mentor)

mentor_user.save!
user_mentor.confirm!

