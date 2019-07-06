class TasksController < ApplicationController
  before_action :require_user_logged_in
  # correct_userをshow, edit, update, destroyに適用する。
  # - correct_userを定義する
  # - before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit , :update, :destroy]

  def index
    # @tasks = Task.all
    # @tasks = Task.where(user_id: current_user.id)
    # 現在ログインしているUserが所有しているtaskのみ取得
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
    @task.user_id = session[:user_id]
    
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録できません'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(tasks_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tasks_params
    params.require(:task).permit(:content, :status, :name, :email, :password, :password_confirmation)
  end

  def set_task
    @task = Task.find(params[:id])
  end
  
  def correct_user
    #...
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
