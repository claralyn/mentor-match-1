class Ranking < ActiveRecord::Base
  attr_accessible :mentor_id, :rank, :student_id

  belongs_to :mentor, dependent: :delete
  belongs_to :student, dependent: :delete
end
