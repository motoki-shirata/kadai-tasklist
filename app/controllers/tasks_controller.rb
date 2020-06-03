class TasksController < ApplicationController
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
		# 上で定義したtask_paramsを引数として新たにインスタンスを作成
		@task = Task.new(task_params)
		if @task.save
			#データベースに保存できたら
			flash[:success] = 'Taskが正常に登録されました'
			redirect_to @task
			#showアクションを実行、show.html.erbを表示
		else
			flash.now[:danger] = 'Taskが正常に登録されませんでした'
			render action: :new #newアクションを行わずにnew.html.erbを表示
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		
		if @task.update(task_params)
			flash[:success] = 'Taskは正常に更新されました'
			redirect_to @task
		else
			flash[:danger] = 'Taskは更新されませんでした'
			render action: :edit
		end
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		
		flash[:success] = 'Taskは正常に削除されました'
		redirect_to tasks_url
		# redirect_to だから最後に_urlつける
	end
	
  def task_params
  	# Taskモデルのフォームから得られるデータのうち、:content飲みを許容
    params.require(:task).permit(:content)
  end
	
end
