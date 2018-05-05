class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = Task.find(params[:id]).coments
  end

  def edit_coments
    @comments = Task.find(params[:id]).coments
  end

  def add_coments
    @task = Task.find(params[:id])
    @coments = @task.coments
    @coment = params[:task][:coment]
    @coments.push(@coment)
  end

  def add_logs
    @logs = Task.find(params[:id]).logs    
  end
  # GET /tasks/new
  def new
    @task = Task.new
    @user = current_user
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @coments = @task.coments
    @coments.push(params[:task][:coment])
    @logs = @task.logs
    @logs.push(params[:task][:log])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:theme, :description, :date_range, :task_type, :task_priority, :tame_estimate, :coments, :user_id, :creator, :project_id, :logs, :teken_time, :coment, :log)
    end
end
