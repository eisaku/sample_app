class SessionsController < ApplicationController

  # ログイン画面
  def new
  end

  # ログイン認証、session作成
  def create
    # 入力したemailでUserを検索
    user = User.find_by(email: params[:session][:email].downcase)
    # 検索したユーザのパスワードと入力したパスワードが一致した場合
    if user && user.authenticate(params[:session][:password])
      # ユーザーをサインイン
      #   User[:remember_token]を更新
      sign_in user
      # ユーザーページ (show) にリダイレクトする。
      redirect_to user
    else
      # エラーメッセージを表示し、サインインフォームを再描画する。
      flash.now[:error] = 'Invalid email/password combination' # 誤りあり!
      render 'new'
    end
  end

  # ログアウト、session削除
  def destroy
    sign_out
    redirect_to root_url
  end
end
