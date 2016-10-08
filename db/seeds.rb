15.times do |n|
  title = "category_#{n+1}"
  Category.create!(title: title, quantity_question: Settings.quanlity_question)
end

30.times do |n|
  content = "Word_#{n+1}"
  Word.create!(content: content, category_id: 15)

  4.times do |m|
    content = "Answer_#{m+1}"
    Answer.create!(content: content,
      is_correct: m == 1 ? 1 : 0, word_id: n)
  end
end

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name, email: email, password: password,
    password_confirmation: password)
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
