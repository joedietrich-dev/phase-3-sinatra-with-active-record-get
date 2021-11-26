class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/games/:game_id' do
    begin
      game = Game.find(params[:game_id])
    rescue
      game = []
    end
    game.to_json({ only: [:id, :title, :genre, :price], 
                   include: { reviews: { only: [:comment, :score], 
                                         include: { user: { only: [:name] }}
                                        }
                            }
                  })
  end

  get '/games' do
    Game.all.order(:title).to_json
  end

end
