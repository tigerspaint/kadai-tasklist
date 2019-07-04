class TasksController < ApplicationController
  before_action :require_user_logged_in

  def index
    @tasks = Task.all
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
    redirect_to tasks_url
  end
  
  private
  
  def tasks_params
    params.require(:task).permit(:content, :status, :name, :email, :password, :password_confirmation)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
