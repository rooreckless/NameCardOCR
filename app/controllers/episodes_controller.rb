class EpisodesController < ApplicationController
  def create
    puts params
    episode=Episode.new(episode_params)
    episode.save
    
    redirect_to card_path(params[:card_id])
  end
  def update
    puts "----episode#update---"
    @episode=Episode.find(params[:id])
    puts params
    binding.pry
    @episode.update(update_params)
    # redirect_to "/card/#{params[:card_id]}/episodes/#{params[:id]}"
    redirect_to card_episode_path(@episode.id)
  end
  def destroy
    episode=Episode.find(params[:id])
    puts "----episode#destory---"
    puts params
    # episode.destory
    redirect_to card_path(params[:card_id])
  end
  def show
    puts "----episode#show---"
    puts params
    @episode=Episode.find(params[:id])
    
  end
  private
  def episode_params 
    params.require(:episode).permit(:content, :when, :where).merge(card_id: params[:card_id].to_i)
  end
  def update_params 
    params.require(:episode).permit(:content, :when, :where).merge(card_id: params[:card_id].to_i)
  end
end
