class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # ユーザーに関連するプロトタイプの一覧を取得
    @prototypes = @user.prototypes


  end
end
