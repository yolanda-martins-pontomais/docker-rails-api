class ArticlesController < ApplicationController
  def index
    articles = Article.order('created_at DESC');
    render json: {status: 'SUCCESS', message:'Artigos carregados.', data:articles},status: :ok
  end

  def show
    article = Article.find(params[:id])
    render json: {status: 'SUCCESS', message:'Artigo carregado.', data:article},status: :ok
  end

  def create
    article = Article.new(article_params)

    if article.save
      render json: {status: 'SUCCESS', message:'Artigo criado com sucesso.', data:article},status: :ok
    else
      render json: {status: 'ERROR', message:'Não foi possível criar o artigo.', data:article.errors},status: :unprocessable_entity
    end
  end

  def update
    article = Article.find(params[:id])

    if article.update(article_params)
      render json: {status: 'SUCCESS', message:'Artigo editado com sucesso.', data:article},status: :ok
    else
      render json: {status: 'ERROR', message:'Não foi possível editar o artigo.', data:article.errors},status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy

    render json: {status: 'SUCCESS', message:'Artigo excluído com sucesso.', data:article},status: :ok
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end  
end
