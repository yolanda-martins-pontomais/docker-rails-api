require "rails_helper"

RSpec.describe "routes for Articles", type: :routing do
  it "routes to index" do
    expect(get("/articles")).to route_to("articles#index")
  end

  it "routes to show" do
    expect(get("/articles/1")).to route_to("articles#show", :id => "1")
  end

  it "routes to create" do
    expect(post("/articles")).to route_to("articles#create")
  end

  it "routes to update" do
    expect(put("/articles/1")).to route_to("articles#update", :id => "1")
  end

  it "routes to destroy" do
    expect(delete("/articles/1")).to route_to("articles#destroy", :id => "1")
  end
end