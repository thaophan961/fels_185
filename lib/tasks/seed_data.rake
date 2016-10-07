namespace :seed_data do
  desc "TODO"
  task create_user_admin: :environment do
    User.create!(name: "Admin", email: "admin@admin.com", password: "123123",
      is_admin: true)
  end

  desc "TODO"
  task create_category: :environment do
    30.times do |n|
      content = "Word_#{n+1}"
      Word.create!(content: content, category_id: 15)

      4.times do |m|
        content = "Answer_#{m+1}"
        Answer.create!(content: content,
          is_correct: m == 1 ? 1 : 0, word_id: n)
      end
    end
  end

  desc "TODO"
  task create_word: :environment do
    15.times do |n|
      title = "category_#{n+1}"
      Category.create!(title: title,
        quantity_question: Settings.quanlity_question)
    end
  end

end
