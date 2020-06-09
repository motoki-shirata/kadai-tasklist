class TasksController < ApplicationController
	# before_action :set_message, only:[:show, :edit, :update, :destroy]
	before_action :require_user_logged_in
	before_action :correct_user, only: [:destroy, :edit, :show, :update]


	def index
		@tasks = current_user.tasks.order(id: :desc).page(params[:page])
	end

	def show
	# @task = Task.find(params[:id])
	end

	def new
		@task = Task.new
	end


	def create
		@task = current_user.tasks.build(task_params)
		if @task.save
			flash[:success] = 'タスクを登録しました。'
			redirect_to '/'
		else
			@tasks = current_user.tasks.order(id: :desc).page(params[:page])
			flash.now[:danger] = 'タスクの登録に失敗しました。'
			render 'tasks/new'
		end
	end

	def edit
		# @task = Task.find(params[:id])
	end

	def update
		# @task = Task.find(params[:id])

		if @task.update(task_params)
			flash[:success] = 'Taskは正常に更新されました'
			redirect_to @task
		else
			flash[:danger] = 'Taskは更新されませんでした'
			render action: :edit
		end
	end

	def destroy
		# @task = Task.find(params[:id])
		@task.destroy

		flash[:success] = 'Taskは正常に削除されました'
		redirect_to tasks_url
		# redirect_to だから最後に_urlつける
	end

	private

	# def set_message
	#   @task = Task.find(params[:id])
	# end

	def task_params
		# Taskモデルのフォームから得られるデータのうち、:contentのみを許容
		params.require(:task).permit(:content, :status)
	end

	def correct_user
		@task = current_user.tasks.find_by(id: params[:id])
		unless @task
			redirect_to '/'
		end
	end
end
