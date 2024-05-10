class Quizz < ApplicationRecord
  self.table_name = "quizzes"

  belongs_to :user
end
