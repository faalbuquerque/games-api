class Api::V1::GamesController < Api::V1::ApiController
  def index
    @games = Game.all
    render json: { games: @games.as_json(except: %i[created_at updated_at]) }
  end

  def show
    @game = Game.find(params[:id])
    render json: { game: @game.as_json(except: %i[created_at updated_at]) },
           status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Dado inexiste' }, status: :not_found
  end

  def create
    @game = Game.new(game_params)
    @game.save!
    render json: { game: @game.as_json(except: %i[created_at updated_at]) },
           status: :created
  rescue ActionController::ParameterMissing
    render json: { message: 'Dados inválidos' }, status: :precondition_failed
  rescue ActiveRecord::RecordInvalid
    render json: { message: @game.errors.full_messages },
           status: :unprocessable_entity
  end

  def update
    @game = Game.find(params[:id])
    @game.update!(game_params)
    render json: { game: @game.as_json(except: %i[created_at updated_at]) },
           status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { message: @game.errors.full_messages },
           status: :unprocessable_entity
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy!

    render json: { message: 'Game apagado' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Dado inexiste' }, status: :not_found
  end

  private

  def game_params
    params.require(:game).permit(:name, :description, :genre, :grade)
  end
end
