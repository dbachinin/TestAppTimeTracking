class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_arrays
  add_flash_types :info, :success, :warning, :danger
  
  def set_arrays
    @task_type = [["Error", 0],["Cosmetic", 1],["Exception", 2], ["Teature", 3],["Task", 4], ["Usability", 5], ["Performance", 6]]
    @task_priority = [["Emergency", 0], ["Critical", 1], ["Serious", 2], ["Regular", 3], ["Low", 4]]
    @log = ["Open", "Submited", "In Review", "Fixed"]
  end
  def self_user?(user)
    if user.include?(current_user.id.as_json.values[0]) 
      true
    else
      false
    end
  end

  # GET /tasks
  # GET /tasks.json
  def index
    # @tasks = Task.all
    @user = current_user
    @project = Project.find(params[:project_uid])
    @users = @project.user_ids.map{|i| User.find(i) }
    @tasks = Task.where(project_id: @project.id)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @comments = Task.find(params[:id]).coments
    @user = current_user

    @project = Project.find(Task.find(params[:id]).project_id)
    @users = @project.user_ids.map{|i| User.find(i) }
    @teken_time_to_form = Time.parse(@task.teken_time.split[1])
    @estimate_time_to_form = Time.parse(@task.estimate_time.split[1])
  end

  def add_logs
    @user = current_user
    @logs = Task.find(params[:id]).logs    
  end
  # GET /tasks/new
  def new
    @user = current_user
    @project = Project.find_by(uid: params[:project_uid])
    @users = @project.user_ids.map{|i| User.find(i) }
    @task = Task.new

  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(@task.project_id)
    @users = @project.user_ids.map{|i| User.find(i) }
    @user = current_user
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @user = current_user
    @project = Project.find(params[:project_uid])
    @users = @project.user_ids.map{|i| User.find(i) }
    @task = Task.create(task_params)
    old_task = @task
    @task.coments.push(params[:task][:coment])
    @task.logs.push(params[:task][:log]||"Open")
    @task.creator = @user.id.as_json.values[0]
    time_start = params[:task].values[6] + ":" + params[:task].values[7]
    time = params[:task].values[12] + ":" + params[:task].values[13]
    @task.teken_time = Time.parse(params[:task][:teken_time] + "-" + time)
    # @task.estimate_time = Time.parse(params[:task][:estimate_time] + "-" + time_start)
    @task.date_range = (Date.parse(@task.estimate_time)..Date.parse(@task.teken_time))
    @task.user_id = params[:task][:user_id][1..-1]
    @task.project_id = @project.id.as_json.values[0]
    @task.estimate_time = Time.parse(params[:task][:estimate_time] + "-" + time_start)
    respond_to do |format|
      if @task.save
        TasksMailer.submitted(@task.user_id,@task,old_task).deliver_now
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
    old_task = Task.find(params[:id])
    @task.date_range = (Date.parse(@task.estimate_time)..Date.parse(@task.teken_time))
    params[:task][:user] ? @task.user_id = params[:task][:user].split : @task.user_id = params[:task][:user_id][1..-1]
    time_start = params[:task].values[12] + ":" + params[:task].values[13]
    time = params[:task].values[17] + ":" + params[:task].values[18]
    teken_time = Date.parse(params[:task][:teken_time]).to_s
    estimate_time = Date.parse(params[:task][:estimate_time]).to_s
    datetime1 = Time.parse(teken_time + "-" + time).to_s
    datetime2 = Time.parse(estimate_time + "-" + time_start).to_s
    @task.teken_time = ""
    @task.estimate_time = ""
    if params[:task][:log] == "Open" and @task.logs.last != old_task.logs.last
      @task.estimate_time = Time.now.to_s
    end
    if params[:task][:log] == "Fixed"
      @task.teken_time = Time.now.to_s
      @lead_time = ((@task.teken_time.to_time - @task.estimate_time.to_time) / 1.hours)
    end
    if @task.user_id.include?(current_user.id.as_json.values[0]) or current_user.admin
      @task.coments.push(params[:task][:coment]) if params[:task][:coment]
      @task.logs.push(params[:task][:log])
      @task.estimate_time = datetime2
      @task.teken_time = datetime1
      respond_to do |format|
        if @task.update(upd_task_params)
          TasksMailer.submitted(@task.user_id,@task,old_task).deliver_now
          format.html { redirect_to @task, info: 'Task was successfully updated.' }
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to @task, info: 'Sorry. You mast by owner of this task. Call you administrator'
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @user = current_user
    @project = Project.find(@task.project_id)
    # FileUtils.rm_f("avatars/#{@task.id}")
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      if Task.where(id: params[:id]).exists?
        @task = Task.find(params[:id])
      else
        redirect_to user_projects_path(current_user), info: "Task with id #{params[:id]} not created."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upd_task_params
      params.require(:task).permit(:user_id, :theme, :description, :date_range, :task_type, :task_priority, :coments, :creator, :project_id, :logs, :coment, :log)
    end    
    def task_params
      params.require(:task).permit(:user_id, :time_start, :time, :theme, :description, :date_range, :task_type, :task_priority, :estimate_time, :coments, :creator, :project_id, :logs, :teken_time, :coment, :log)
    end
end
