ActiveAdmin.register Rank do

  filter :assignment, collection: -> {
    Assignment.all.map { |assignment| [assignment.name, assignment.id] }
  }
  filter :ranker
  filter :receiver
  filter :rating, as: :select, collection: Rank.ratings

  index do
    selectable_column
    column "Assignment" do |rank|
      rank.assignment.name.humanize 
    end
    column "Ranker" do |rank|
      rank.ranker.name 
    end
    column "Receiver" do |rank|
      rank.receiver.name 
    end
    column "Rating" do |rank|
      rank.rating.humanize
    end
    column "Comment" do |rank|
      rank.comment&.humanize
    end
  end
  
end
