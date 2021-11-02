# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 管理者作成
User.find_or_create_by(email: "admin@example.com") do |user|
  user.email = "admin@example.com"
  user.name = "Example Admin"
  user.password =              "adminexample"
  user.password_confirmation = "adminexample"
  user.admin = true
end
User.find_or_create_by(email: ENV["ADMIN_EMAIL"]) do |user|
  user.email = ENV["ADMIN_EMAIL"]
  user.name = ENV["ADMIN_NAME"]
  user.password =            ENV["ADMIN_PASSWORD"]
  user.password_confirmation = ENV["ADMIN_PASSWORD"]
  user.admin = true
end
# @quizzes = [
#   {
#     user_id: user.id,
#     content: "「作麼生」とかいてなんと読む#{i}",
#     explanation: "「そもさん」とは、主に禅問答の際にかける言葉で、問題を出題する側が用いる表現。「さあどうだ」といった意味合いである。「そもさん」に対し、問題を出題される側は、「せっぱ（説破）」と応えるのが一般的である。",
#     status: 1,
#     choices:[
#       {quiz_id: i,content: "さもさん", is_answer: false},
#       {quiz_id: i,content: "たもさん", is_answer: false},
#       {quiz_id: i,content: "そもさん", is_answer: true},
#       {quiz_id: i,content: "すもさん", is_answer: false}
#     ]
#   }
# ]

# ダミーデータを20作成
user = User.find_by(email: ENV["ADMIN_EMAIL"])
explanation = "「そもさん」とは、主に禅問答の際にかける言葉で、問題を出題する側が用いる表現。「さあどうだ」といった意味合いである。「そもさん」に対し、問題を出題される側は、「せっぱ（説破）」と応えるのが一般的である。"
5.times do |n|
  Quiz.create!(
    user_id: user.id,
    content: "test#{n.to_s}",
    explanation: explanation,
    status: 1
  )
  quiz = Quiz.find_by(content: "test#{n.to_s}")
  4.times do |m|
    a = false
    a = true if m == 2
    Choice.create!(
        quiz_id: quiz.id,
        content: "choice#{m.to_s}",
        is_answer: a
      )
  end
end
