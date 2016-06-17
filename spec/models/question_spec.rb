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

  describe "validate quiz mode" do
    context "answer is correct" do
      it 'should correct if string equal' do
        question = FactoryGirl.create(:question, answer: 'foo bar')
        expect(question.answer_is_valid?('foo bar')).to eq(true)
      end

      it 'should correct if contains white space' do
        question = FactoryGirl.create(:question, answer: 'foo bar')
        expect(question.answer_is_valid?('  foo bar')).to eq(true)
      end

      it 'should correct if answer is capitalize' do
        question = FactoryGirl.create(:question, answer: 'foo bar baz')
        expect(question.answer_is_valid?('FOO bar BaZ')).to eq(true)
      end

      it 'should recognise the number as words if answer is a number' do
        question = FactoryGirl.create(:question, answer: '26')
        expect(question.answer_is_valid?('twenty six')).to eq(true)
      end

      it 'should recognise the number as words if answer contains a number' do
        question = FactoryGirl.create(:question, answer: 'foo bar 26 baz')
        expect(question.answer_is_valid?('foo bar twenty six baz')).to eq(true)
      end

      it 'should recognize the words as a number' do
        question = FactoryGirl.create(:question, answer: 'foo bar seven baz')
        expect(question.answer_is_valid?('foo bar 7 baz')).to eq(true)
      end

    end

    context 'answer is incorrect' do
      it 'should incorrect if string not equal' do
        question = FactoryGirl.create(:question, answer: 'foo bar')
        expect(question.answer_is_valid?('bar foo')).to eq(false)
      end
    end
  end
end
