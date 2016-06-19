class QuizzesController < ApplicationController

  def index
    @question = nil
    if session.key?("question_id")
      @question = Question.where('id = ?', session[:question_id]).first
    else
      @question = Question.first
    end
    @question.answer = nil if !@question.nil?
  end

  def create
    question = Question.find params[:id]
    answer = params[:question][:answer]
    if question.answer_is_valid?(answer)
      set_next_question
    else
      session[:question_id] = question.id
      flash[:danger] = 'Incorrect'
    end
    redirect_to action: 'index'
  end

  private

  def set_next_question
    next_question = Question.where('id > ?', params[:id]).first
    if next_question.nil?
      session.delete(:question_id)
    else
      session[:question_id] = next_question.id
    end
  end

end
