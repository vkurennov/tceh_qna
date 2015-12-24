class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question }
        format.js
        format.json do
          response = { answers_count: @question.answers.count, answer: @answer }
          PrivatePub.publish_to "/questions/#{@answer.question_id}/answers",
                                response: response
          render json: response
        end
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

  def check_user
    head :forbidden unless current_user.author_of?(@answer)
    # render nothing: true, status: :forbidden
  end
end
