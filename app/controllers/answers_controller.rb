class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question }
        format.js
        format.json { render json: { answers_count: @question.answers.count, answer: @answer } }
      else
        format.html { render 'questions/show' }
        format.js
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
