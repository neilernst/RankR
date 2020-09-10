class Rank < ApplicationRecord
    belongs_to :assignment
    belongs_to :ranker, foreign_key: :ranker_id, class_name: 'Student'
    belongs_to :receiver, foreign_key: :receiver_id, class_name: 'Student'
end
