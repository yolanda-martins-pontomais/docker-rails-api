require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before(:each) do
    @article_params = FactoryBot.attributes_for(:article)
    post articles_path, params: { article: @article_params}
    @article_id = Article.last.id
  end

  describe "GET /comments" do
    before(:each) do
      comments_path = "/articles/#{@article_id}/comments"
      get comments_path
    end

    it "returns success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the correct message" do
      expect(response.body).to match(/Comentários carregados./)
    end 
  end

  describe "GET/ comment" do
    before(:each) do
      comment = build(:comment)
      comment_params = FactoryBot.attributes_for(:comment)
      comments_path = "/articles/#{@article_id}/comments"
      post comments_path, params: { comment: comment_params}

      comment_path = "/articles/#{@article_id}/comments/#{Comment.last.id}"
      get comment_path
    end
    
    it "returns success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the correct message" do
      expect(response.body).to match(/Comentário carregado./)
    end
  end

  describe "POST/ comments" do
    before(:each) do
      @comment = build(:comment)
      comments_path = "/articles/#{@article_id}/comments"
      @comment_params = FactoryBot.attributes_for(:comment)
      post comments_path, params: { comment: @comment_params}
    end

    it "returns success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the correct message" do
      expect(response.body).to match(/Comentário criado com sucesso./)
    end

    it "creates comment with correct parameters" do
      expect(Comment.last).to have_attributes(@comment_params)
    end
  end

  describe "DELETE/ comments" do
    context "when comment exists" do
      before(:each) do
        comment = build(:comment)
        comments_path = "/articles/#{@article_id}/comments"
        comment_params = FactoryBot.attributes_for(:comment)
        post comments_path, params: { comment: comment_params}

        delete_comments_path = "/articles/#{@article_id}/comments/#{Comment.last.id}"
        
        delete delete_comments_path
      end

      it "returns success status" do
        expect(response).to have_http_status(200)
      end

      it "returns the correct message" do
        expect(response.body).to match(/Comentário excluído com sucesso./)
      end
    end  
  end
end
