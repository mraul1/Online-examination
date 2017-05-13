class ExamsController < ApplicationController
  #before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    @exam = Exam.find(params[:id])
    @questions = @exam.questions
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new()
    @exam.name = params[:name]
    @exam.name = params[:description]
    @exam.save!
    flash[:notice] = "#{@exam.name} was successfully created."
    redirect_to(exams_path)
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  # def update
  #     #respond_to do |format|
  #   @exam.update(exam_params) #if
  #   # flash[:notice] = "#{@exam.name} was successfully created."
  #   redirect_to(exams_path)
  #     #   format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
  #     #   format.json { render :show, status: :ok, location: @exam }
  #     # else
  #     #   format.html { render :edit }
  #     #   format.json { render json: @exam.errors, status: :unprocessable_entity }
  #     # end
  #   # end
  # end

  # DELETE /exams/1
  # DELETE /exams/1.json
 
  # def destroy
  #   @exam = Exam.find(params[:id])
  #   @exam.destroy
  #   flash[:notice] = "Exam '#{@exam.name}' deleted."
  #   redirect_to exam_path
  # end
  
  def submit_exam
    @exam = Exam.find(params[:exam_id])
    all_questions = @exam.questions.to_a.as_json
    @score = 0
    all_questions.each do |q_hash|
      q_id = q_hash['id']
      @score += params[q_id.to_s] == q_hash['answer'] ? 1 : 0 
      puts "asdasdadaaaasssssssssssssssssssssssssssssssssssssssssss"
      puts params[q_id]
      puts params[q_id]
    end
    redirect_to show_result_path(score: @score, exam_name: @exam.name)
  end
  
  def show_result
    @score = params[:score]
    @exam_name = params[:exam_name]
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_exam
    #  @exam = Exam.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def exam_params
    #   params.require(:exam).permit(:name,:description)
    # end
end
