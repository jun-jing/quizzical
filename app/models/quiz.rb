class Quiz < ApplicationRecord
    scope :published, -> { where("published == true")}

    has_many :questions
    belongs_to :group
end
