require 'rails_helper'

describe 'Games API' do
  context 'get api/v1/games' do
    it 'successfully' do
      create(:game, name: 'Skyrim')
      create(:game, name: 'Minecraft')

      get '/api/v1/games'
      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(resp_hash['games'].first['name']).to eq('Skyrim')
      expect(resp_hash['games'].second['name']).to eq('Minecraft')
    end

    it 'failure' do
      get '/api/v1/games'

      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(resp_hash['games']).to be_empty
    end
  end

  context 'post api/v1/games' do
    it 'successfully - create game' do
      post '/api/v1/games', params:
                              {
                                game:
                                {
                                  name: 'Dark Souls',
                                  description: 'Um jogo legal',
                                  genre: 'RPG',
                                  grade: 10
                                }
                              }
      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')
      expect(resp_hash['game']['name']).to eq('Dark Souls')
      expect(resp_hash['game']['description']).to eq('Um jogo legal')
      expect(resp_hash['game']['genre']).to eq('RPG')
      expect(resp_hash['game']['grade']).to eq(10)
    end

    it 'failure - no data' do
      post '/api/v1/games'

      expect(response).to have_http_status(:precondition_failed)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('Dados inválidos')
    end

    it 'failure - data in blank' do
      post '/api/v1/games', params:
                              {
                                game:
                                {
                                  name: '',
                                  description: '',
                                  genre: '',
                                  grade: ''
                                }
                              }
      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to include('application/json')
      expect(resp_hash['message']).to include("Name can't be blank")
      expect(resp_hash['message']).to include("Description can't be blank")
      expect(resp_hash['message']).to include("Genre can't be blank")
      expect(resp_hash['message']).to include("Grade can't be blank")
    end
  end

  context 'put api/v1/games' do
    it 'successfully - update game' do
      ds = create(:game, name: 'DS', description: 'Um jogo', genre: 'rpg')

      put "/api/v1/games/#{ds.id}", params:
                                      {
                                        game:
                                        {
                                          name: 'Portal',
                                          description: 'Um jogo legal',
                                          genre: 'Puzzle',
                                          grade: 9
                                        }
                                      }
      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')
      expect(resp_hash['game']['name']).to_not eq('DS')
      expect(resp_hash['game']['description']).to_not eq('Um jogo')
      expect(resp_hash['game']['genre']).to_not eq('rpg')
      expect(resp_hash['game']['name']).to eq('Portal')
      expect(resp_hash['game']['description']).to eq('Um jogo legal')
      expect(resp_hash['game']['genre']).to eq('Puzzle')
      expect(resp_hash['game']['grade']).to eq(9)
    end

    it 'failure - update data in blank' do
      ds = create(:game, name: 'Dark Sous')

      put "/api/v1/games/#{ds.id}", params:
                                      {
                                        game:
                                        {
                                          name: '',
                                          description: '',
                                          genre: '',
                                          grade: ''
                                        }
                                      }

      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to include('application/json')
      expect(resp_hash['message']).to include("Name can't be blank")
      expect(resp_hash['message']).to include("Description can't be blank")
      expect(resp_hash['message']).to include("Genre can't be blank")
      expect(resp_hash['message']).to include("Grade can't be blank")
    end
  end

  context 'delete api/v1/games' do
    it 'successfully - delete game' do
      ds = create(:game, name: 'Dark Sous')

      delete "/api/v1/games/#{ds.id}"

      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(resp_hash).to_not include('Dark Souls')
      expect(resp_hash['message']).to include('Game apagado')
    end

    it 'failure - delete game deleted' do
      ds = create(:game, name: 'DS')

      delete "/api/v1/games/#{ds.id}"
      delete "/api/v1/games/#{ds.id}"

      resp_hash = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to include('application/json')
      expect(resp_hash).to_not include('DS')
      expect(resp_hash['message']).to include('Dado inexiste')
    end
  end
end
