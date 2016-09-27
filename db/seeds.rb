15.times do |n|
  title = "category_#{n+1}"
  Category.create!(title: title, quantity_question: Settings.quanlity_question)
end
