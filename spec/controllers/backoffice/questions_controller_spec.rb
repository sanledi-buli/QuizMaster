require 'rails_helper'
RSpec.describe Backoffice::QuestionsController, type: :controller do

  def create_question_with_options(options = {})
    create(:question, options)
  end

  let(:question) { FactoryGirl.create(:question) }

  after(:each) do
    Question.delete_all
  end

  describe 'GET #index' do
    it 'should populate an arrays of questions' do
      get :index
      expect(assigns(:questions)).to match_array([question])
    end

    it 'should render to index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'should render to new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'should create new question' do
      expect {
        post :create, question: FactoryGirl.attributes_for(:question)
      }.to change(Question, :count).by(1)
    end

    it 'should redirect to index' do
      post :create, question: FactoryGirl.attributes_for(:question)
      expect(response).to redirect_to action: 'index'
    end

    it 'should has flash success created' do
      post :create, question: FactoryGirl.attributes_for(:question)
      expect(flash[:notice]).to eq('Question was successfully created.')
    end

    it 'should not save the new question' do
      expect{
        post :create, question: {content: nil, answer: 'sss'}
      }.to_not change(Question,:count)
    end
    
    it 'should render to new method' do
      post :create, question: {content: nil, answer: 'sss'}
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'should render to edit template' do
      question = FactoryGirl.create(:question)
      get :edit, id: question
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @question = create_question_with_options({content: 'foo', answer: 'baz'})
    end

    it 'should same attributes' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question)
      expect(assigns(:question)).to eq(@question)
    end

    it 'should change content attribute' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: 'bar', answer: @question.answer)
      @question.reload
      expect(@question.content).to eq('bar')
      expect(@question.answer).to eq('baz')
    end

    it 'should change answer attribute' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: @question.content, answer: 'foo')
      @question.reload
      expect(@question.content).to eq('foo')
      expect(@question.answer).to eq('foo')
    end

    it 'should has flash success updated' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: 'bar', answer: 'foo')
      expect(flash[:notice]).to eq('Question was successfully updated.')
    end

    it 'should redirect to index' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: @question.content, answer: 'foo')
      expect(response).to redirect_to action: 'index'
    end

    it 'should not change content attribute' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: 'bar', answer: nil)
      @question.reload
      expect(@question.content).to eq('foo')
      expect(@question.answer).to eq('baz')
    end

    it 'should not change answer attribute' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: nil, answer: 'foo')
      @question.reload
      expect(@question.content).to eq('foo')
      expect(@question.answer).to eq('baz')
    end

    it 'should render edit template' do
      put :update, id: @question, question: FactoryGirl.attributes_for(:question, content: nil, answer: 'foo')
      expect(response).to render_template('edit')
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the question' do
      question = FactoryGirl.create(:question)
      expect{
        delete :destroy, id: question        
      }.to change(Question,:count).by(-1)
    end

    it 'should has flash success deleted' do
      question = FactoryGirl.create(:question)
      delete :destroy, id: question
      expect(flash[:notice]).to eq('Question was successfully deleted.')
    end

    it 'should redirect to index' do
      question = FactoryGirl.create(:question)
      delete :destroy, id: question
      expect(response).to redirect_to action: 'index'
    end
  end
end
