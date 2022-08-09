require 'rails_helper'

RSpec.describe Article, type: :model do
  it "returns the correct status" do
    article = Article.create(title: 'Artigo teste', body: 'Body do artigo teste', status: 'public')
    expect(article.status).to eq('public')
  end

  ######################################################################
  #utilizando a gem FFAKER:
  it "returns the correct status" do
    title = FFaker::BaconIpsum.phrase
    body = FFaker::BaconIpsum.phrase
    status = ['public', 'private', 'archived'].sample

    article = Article.create(title: title, body: body, status: status)
    expect(article.status).to eq(status)
  end

  #######################################################################
  #utilizando o FACTORYBOT:
  it "returns the correct status" do
    article = build(:article)

    expect(article.status).to be_in(['public', 'private', 'archived'])
  end

  #####################################################################
  
  it "is invalid if body length is lesser than 10" do
    article = build(:article, body: FFaker::BaconIpsum.word)
    expect(article.body.length).to_not be > 10
  end

  it "is valid if body length is greater than 10" do
    article = build(:article)
    expect(article.body.length).to be > 10
  end

  it "is valid because it has all required values" do
    article = build(:article)
    expect(article).to be_valid
  end

  it "is invalid because it doesn't have all required values" do
    title = FFaker::BaconIpsum.phrase
    body = FFaker::BaconIpsum.phrase

    article = Article.create(title: title, body: body)
    expect(article).to_not be_valid
  end
end
