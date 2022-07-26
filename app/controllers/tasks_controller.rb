class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @tasks = pagy(Task.order(id: :desc), items:3)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.task.build(message_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(message_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  # Strong Parameter
  def message_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.microposts.find_by(id: params[:id])
    unless @task
      redirect_to tasks_url
    end
  end
  
end
