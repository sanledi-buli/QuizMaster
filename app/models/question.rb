class Question < ActiveRecord::Base
  validates :content, presence: true
  validates :answer, presence: true

  def answer_is_valid? answer
    answer_to_plain == answer.strip || answer_number_is_valid?(answer.strip) || answer_contains_number_is_valid?(answer.strip)
  end

  private

  def answer_to_plain
    ActionController::Base.helpers.strip_tags(answer)
  end

  def answer_is_number?
    true if Float(answer_to_plain) rescue false
  end

  def answer_number_value
    value = Float(answer_to_plain) rescue nil
    value % 1 == 0 ? value.to_i : value
  end

  def answer_number_is_valid? answer
    answer_is_number? && answer_number_value.humanize == answer
  end

  def answer_contains_number_is_valid? answer
    answer_plain = answer_to_plain
    answer_array_old = answer_plain.split(' ')
    answer_array_new = []
    answer_array_old.each{
      |value|
      if answer.include?(value) && answer_plain.index(value) == answer.index(value)
        answer_array_new << value
        next
      end
      begin
        float_value = Float(value)
        float_value % 1 == 0 ? answer_array_new << float_value.to_i.humanize : answer_array_new << float_value.humanize
      rescue
        answer_array_new << value
      end

    }
    answer == answer_array_new.join(' ')
  end

end
