require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "returns success status" do
      get articles_path

      expect(response).to have_http_status(200)
    end

    it "returns the article title" do
      articles = create_list(:article, 4)
      get articles_path

      articles.each do | article |
        expect(response.body).to include(article.title)
      end
    end

    it "returns the correct message" do
      get articles_path
      expect(response.body).to match(/Artigos carregados./)
    end  
  end

  describe "GET /article" do
    before(:each) do
      @article_params = FactoryBot.attributes_for(:article)
      post articles_path, params: { article: @article_params}

      article_path = "/articles/#{Article.last.id}"
      get article_path
    end

    it "returns success status" do
      expect(response).to have_http_status(200)
    end

    it "returns the correct message" do
      expect(response.body).to match(/Artigo carregado./)
    end
  end

  describe "POST/ articles" do
    context "when it has valid parameters" do
      before(:each) do
        @article_params = FactoryBot.attributes_for(:article)
        post articles_path, params: { article: @article_params}
      end

      it "creates article with correct parameters" do
        expect(Article.last).to have_attributes(@article_params)
      end

      it "returns success status" do
        expect(response).to have_http_status(200)
      end

      it "returns the correct message" do
        expect(response.body).to match(/Artigo criado com sucesso./)
      end  
    end

    context "when it has no valid parameters" do
      before(:each) do
        @article_params = {title: "", body: "", status: ""}
        post articles_path, params: { article: @article_params}
      end

      it "doesn't create article" do
        expect(Article.last).not_to have_attributes(@article_params)
      end

      it "returns unprocessable entity status" do
        expect(response).to have_http_status(422)
      end

      it "returns the correct message" do
        expect(response.body).to match(/Não foi possível criar o artigo./)
      end  
    end
  end

  describe "PUT/ articles" do
    context "when article exists" do
      before(:each) do
        @article = create(:article)
        @article_params = FactoryBot.attributes_for(:article)
        put "/articles/#{@article.id}", params: { article: @article_params}
      end

      it "returns success status" do
        expect(response).to have_http_status(200)
      end

      it "updates article" do
        expect(Article.last).to have_attributes(@article_params)
      end

      it "returns the updated article" do
        json_response = JSON.parse(response.body)
        expect(@article.reload.updated_at).to_not be_nil
      end

      it "returns the correct message" do
        expect(response.body).to match(/Artigo editado com sucesso./)
      end  
    end

    context "when article exists but it has no valid parameters" do
      before(:each) do
        @article = create(:article)
        @article_params = {title: "", body: "", status: ""}
        put "/articles/#{@article.id}", params: { article: @article_params}
      end

      it "returns unprocessable entity status" do
        expect(response).to have_http_status(422)
      end
      
      it "returns the correct message" do
        expect(response.body).to match(/Não foi possível editar o artigo./)
      end
    end

    context "when article doesn't exist" do
      it "returns record not found" do
        expect {
          non_existent_article_id = 0
          article_params = FactoryBot.attributes_for(:article)
          put "/articles/#{non_existent_article_id}", params: { article: article_params}
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE/ articles" do
    context "when article exists" do
      before(:each) do
        @article = create(:article)
        delete "/articles/#{@article.id}"
      end

      it "returns success status" do
        expect(response).to have_http_status(200)
      end

      it "destroy record" do
        expect {@article.reload}.to raise_error ActiveRecord::RecordNotFound
      end

      it "returns the correct message" do
        expect(response.body).to match(/Artigo excluído com sucesso./)
      end  
    end

    context "when article doesn't exist" do
      it "returns record not found" do
        expect {
          non_existent_article_id = 0
          article_params = FactoryBot.attributes_for(:article)
          delete "/articles/#{non_existent_article_id}", params: { article: article_params}
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
