class CommentsController < ApplicationController
    def index
      article = Article.find(params[:article_id])
      comment = article.comments.order('created_at DESC')

      render json: {status: 'SUCCESS', message:'Comentários carregados.', data:comment},status: :ok
    end

    def show
      article = Article.find(params[:article_id])
      comment = article.comments.find(params[:id])

      render json: {status: 'SUCCESS', message:'Comentário carregado.', data:comment},status: :ok
    end
    
    def create
      article = Article.find(params[:article_id])
      comment = article.comments.create(comment_params)

      render json: {status: 'SUCCESS', message:'Comentário criado com sucesso.', data:comment},status: :ok
    end

    def destroy
      article = Article.find(params[:article_id])
      comment = article.comments.find(params[:id])
      comment.destroy

      render json: {status: 'SUCCESS', message:'Comentário excluído com sucesso.', data:comment},status: :ok
    end
    
    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
      end
end
