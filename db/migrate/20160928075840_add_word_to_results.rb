class AddWordToResults < ActiveRecord::Migration
  def change
    add_reference :results, :word, index: true, foreign_key: true
  end
end
