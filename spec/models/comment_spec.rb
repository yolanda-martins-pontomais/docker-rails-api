require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = build(:comment, article: build(:article) )
  end

  it "returns the correct status" do
    expect(@comment.status).to be_in(['public', 'private', 'archived'])
  end

  it "is valid because it has all required values" do
    expect(@comment).to be_valid
  end

  it "is invalid because it doesn't have all required values" do
    comment = build(:comment, status: nil)
    expect(comment).to_not be_valid
  end
end