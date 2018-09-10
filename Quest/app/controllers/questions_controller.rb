class QuestionsController < ApplicationController

    def index
        @questions = Question.all
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
      redirect_to new_session_path, notice: 'You must be logged in to add a question' if !current_user
      @question = Question.new
    end

    def edit
        @question = Question.find(params[:id])
    end
    
    def create
        @question = Question.new(question_params)

        if @question.save
            redirect_to @question
        else
            render 'new'
        end
    end

    def update
        @question = Question.find(params[:id])

        if @question.update(question_params)

            redirect_to @question
        else
            render 'edit'
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy

        redirect_to questions_path
    end

    def upvote 
        @question_upvote = Question.find(params[:id])
        @question_upvote.upvote_by current_user
        redirect_to questions_path
      end

  private
    def question_params
        params.require(:question).permit(:title, :body, :user_id, :username)
    end


end
