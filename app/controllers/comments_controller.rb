class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comments_params)

    # コメントの保存に成功した場合、プロトタイプの詳細にリダイレクト
    # コメントの保存に失敗した場合、プロトタイプの詳細をrenderで表示
    if @comment.save

      redirect_to prototype_path(@comment.prototype.id)
      
    else
      @prototype = @comment.prototype
      # @comment = Comment.new
      @comments = @prototype.comments
      render "prototypes/show"
    end

   
  end

  private
  def comments_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end


end
