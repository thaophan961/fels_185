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
