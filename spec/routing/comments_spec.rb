require "rails_helper"

RSpec.describe "routes for Comments", type: :routing do
  it "routes to index" do
    expect(get("/articles/1/comments")).to route_to("comments#index", :article_id => "1")
  end

  it "routes to show" do
    expect(get("/articles/1/comments/1")).to route_to("comments#show", :article_id => "1", :id => "1")
  end

  it "routes to create" do
    expect(post("/articles/1/comments")).to route_to("comments#create", :article_id => "1")
  end

  it "routes to destroy" do
    expect(delete("/articles/1/comments/1")).to route_to("comments#destroy", :article_id => "1", :id => "1")
  end
end