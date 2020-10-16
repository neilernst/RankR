ActiveAdmin.register Rank do

  permit_params :rating, :comment

  filter :assignment, collection: -> {
    Assignment.all.map { |assignment| [assignment.name, assignment.id] }
  }
  filter :ranker
  filter :receiver
  filter :rating, as: :select, collection: Rank.ratings

  index do
    selectable_column
    column "Assignment" do |rank|
      rank.assignment&.name.humanize 
    end
    column "Ranker" do |rank|
      rank.ranker&.name 
    end
    column "Receiver" do |rank|
      rank.receiver&.name 
    end
    column "Rating" do |rank|
      rank.rating&.humanize
    end
    column "Comment" do |rank|
      rank.comment&.humanize
    end
    column :actions do |student|
      links = []
      links << link_to('Show', admin_rank_path(student))
      links << link_to('Edit', edit_admin_rank_path(student))
      links << link_to('Delete', admin_rank_path(student), method: :delete, confirm: 'Are you sure?')
      links.join(' ').html_safe
    end
  end
  
end
