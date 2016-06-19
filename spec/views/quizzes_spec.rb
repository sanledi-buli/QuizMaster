require 'rails_helper'

RSpec.describe "quizzes/index", :type => :view do
  it "should renders _form partial if question not nil" do
    assign(:question, FactoryGirl.create(:question))
    render
    expect(view).to render_template(partial: '_form')
  end

  it "should renders _empty partial if question nil" do
    assign(:question, nil)
    render
    expect(view).to render_template(partial: '_empty')
  end
end