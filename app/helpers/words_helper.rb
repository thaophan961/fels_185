module WordsHelper
  def index f
    @index = f.options[:child_index] + 1
  end
end
