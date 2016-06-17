class Question < ActiveRecord::Base
  validates :content, presence: true
  validates :answer, presence: true

  def answer_is_valid? answer
    normalize!(answer_to_plain) == normalize!(answer)
  end

  private

  def answer_to_plain
    ActionController::Base.helpers.strip_tags(answer)
  end

  def normalize! str
    str_arr = str.downcase.strip.squish.split(' ')
    str_arr.each_with_index{|v,i| str_arr[i] = number_native!(v).humanize if is_number?(v)}
    str_arr.join(' ')
  end

  def number_native! str
    float = Float(str)
    float%1 != 0 ? float : float.to_i
  end

  def is_number? str
    true if Float(str) rescue false
  end
end
