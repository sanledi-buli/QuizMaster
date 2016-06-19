module QuizzesHelper

  def load_view
    if !@question.nil?
      render 'form'
    else
      render 'empty'
    end
  end
end