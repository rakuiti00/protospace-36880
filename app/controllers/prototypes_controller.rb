class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new,:edit,:destroy]
  before_action :move_to_index, only: [:edit]



  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create    
    @prototype = Prototype.new(prototype_params)
    if @prototype.save      
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])  
  end

  def update
    @prototype = Prototype.find(params[:id])  
    
    # 更新に成功したら、プロトタイプ詳細ページに戻る
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    #失敗したら情報そのままでedit画面
    else
      render :edit
    end

  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private 
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])  
    
    # ログインしているかつプロトタイプ投稿者以外の場合、編集ページへはアクセスできない
    unless user_signed_in? && current_user.id == @prototype.user.id
        redirect_to action: :index
    end
  
  end

end
