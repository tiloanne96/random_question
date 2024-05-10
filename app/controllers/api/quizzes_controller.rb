module Api
  class QuizzesController < ApplicationController
    before_action :set_quizz, only: %i[ show update destroy ]
  
    # GET /quizzes
    def index
      authorize(Quizz)

      @quizzes = Quizz.all
  
      render json: @quizzes
    end
  
    # GET /quizzes/1
    def show
      authorize(Quizz)

      render json: @quizz
    end
  
    # POST /quizzes
    def create
      authorize(Quizz)

      @quizz = Quizz.new(quizz_params)
  
      if @quizz.save
        render json: @quizz, status: :created, location: @quizz
      else
        render json: @quizz.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /quizzes/1
    def update
      authorize(Quizz)

      if @quizz.update(quizz_params)
        render json: @quizz
      else
        render json: @quizz.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /quizzes/1
    def destroy
      authorize(Quizz)

      @quizz.destroy!
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_quizz
        @quizz = Quizz.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def quizz_params
        params.require(:quizz).permit(:title, :user_id)
      end
  end
end
