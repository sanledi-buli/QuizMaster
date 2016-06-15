require 'rails_helper'
RSpec.describe Question, type: :model do
  def build_question_with_options(options = {})
    build(:question, options)
  end

  let(:question) { FactoryGirl.create(:question) }

  after(:each) do
    Question.delete_all
  end
  
  describe "validate" do
    context "content validate" do
      it 'should not accept content if it is nil' do
        question = build_question_with_options({ content: nil })
        expect(question.valid?).to be_falsy
        expect(question.errors[:content]).to eq ["can't be blank"]
      end
    end
  end

  describe "validate" do
    context "answer validate" do
      it 'should not accept answer if it is nil' do
        question = build_question_with_options({ answer: nil })
        expect(question.valid?).to be_falsy
        expect(question.errors[:answer]).to eq ["can't be blank"]
      end
    end
  end
end
