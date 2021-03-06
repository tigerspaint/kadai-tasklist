class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    #@user = User.find(params[:id])
    ## 今のuser_idと選択しているuser_idが違う場合、root_urlに飛び、returnで返す
    #if @user != current_user
    #  redirect_to root_url and return
    #end
    #@tasks = @user.tasks.order(id: :desc).page(params[:page])
    #counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
