require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do

  after(:each) do
    Question.delete_all
  end

  before(:each) do
    session.delete(:question_id)
  end

  describe 'GET #index' do
    it 'should render to index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should return first question for first time' do
      first_question = FactoryGirl.create(:question, content: 'When you came ?', answer: 'tomorrow')
      get :index
      expect(assigns(:question)).to eq(first_question)
    end

    let(:question) { FactoryGirl.create(:question) }

    it 'should return next question for futher' do
      second_question = FactoryGirl.create(:question, content: 'Who you are ?', answer: 'valak')
      post :create, id: question, question: FactoryGirl.attributes_for(:question)
      get :index
      expect(assigns(:question)).to eq(second_question)
    end
  end

  describe 'POST #create' do
    let(:question) { FactoryGirl.create(:question) }

    it 'should has flash incorrect if answer is incorrect' do
      post :create, id: question, question: FactoryGirl.attributes_for(:question, answer: 'foo bar')
      expect(flash[:danger]).to eq('Incorrect')
    end

    it 'should clear session question_id if question already finished' do
      post :create, id: question, question: FactoryGirl.attributes_for(:question, answer: 'bar')
      expect(session[:question_id]).to eq(nil)
    end
  end
end
