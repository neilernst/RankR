# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# team = Team.create(team_id: '202011', team_name: 'Team_1')

# for i in 1..5 do
#     team.students.create(
#         email: "student_#{i}@example.com", 
#         password: "student_#{i}", 
#         password_confirmation: "student_#{i}",
#         student_id: "V00000#{i}",
#         name: "Student_#{i}",
#         github_id: "github.com/student_#{i}" 
#     )
# end

CSV.foreach(Rails.root.join('db', 'data', 'adminusers.csv'), headers: true) do |row|
    AdminUser.create(email: row["email"], password: row["password"], password_confirmation: row["password_confirmation"])
end

puts("Admins created!")

CSV.foreach(Rails.root.join('db', 'data', 'teams.csv'), headers: true) do |row|
    Team.create(team_id: row["team_id"], team_name: row["team_name"])
end

puts("Teams created!")

CSV.foreach(Rails.root.join('db', 'data', 'assignments.csv'), headers: true) do |assignment_row|
    assignment = Assignment.create(year: assignment_row["year"], course: assignment_row["course"], 
        name: assignment_row["name"], status: assignment_row["status"])
end

puts("Assignments created!")

CSV.foreach(Rails.root.join('db', 'data', 'students.csv'), headers: true) do |row|
    password = SecureRandom.base64(8)
    team = Team.find_by(team_id: row["team_id"])
    raw, hashed = Devise.token_generator.generate(Student, :reset_password_token)
    student = team.students.create(
        email: row["email"], 
        password: password, 
        password_confirmation: password,
        student_id: row["student_id"],
        name: row["name"],
        github_id: row["github_id"],
        raw_password: password,
        reset_password_token: hashed,
        reset_password_sent_at: Time.now.utc,
        password_reset_token: raw 
    )
end

puts("Students created!")

Assignment.all.each do |assignment|
    Student.all.each do |student|
        AssignmentsStudent.create(assignment_id: assignment.id, student_id: student.id)
    end
end

puts("Student assignment enrollment complete!")
