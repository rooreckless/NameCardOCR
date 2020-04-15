class EpisodesController < ApplicationController
  def create
    episode=Episode.new(episode_params)
    episode.save
    redirect_to card_path(params[:card_id])
  end
  def update
    @episode=Episode.find(params[:id])
    if @episode.update(update_params)
      redirect_to card_episode_path(@episode.card_id,@episode.id),notice: 'エピソードを更新しました。'
    else
      redirect_to card_episode_path(@episode.card_id,@episode.id),notice: 'エピソードの更新に失敗しました。'
    end
  end
  def destroy
    episode=Episode.find(params[:id])
    if episode.destroy
      redirect_to card_path(params[:card_id]),notice: 'エピソードを削除しました。'
    else
      redirect_to card_path(params[:card_id]),allert: 'エピソードの削除に失敗しました。'
    end
    
  end
  def show
    @episode=Episode.find(params[:id])
    @cardid=@episode.card_id
    if params[:card_id].to_i != @episode.card_id
      #直接URLを打ち込んでカードidと一致していなくてもエピソードを読もうとするとリダイレクト
      redirect_to root_path and return
    end
  end
  private
  def episode_params 
    params.require(:episode).permit(:content, :when, :where).merge(card_id: params[:card_id].to_i).merge(user_id: current_user.id).merge(group_id: current_user.group_id)
  end
  def update_params 
    params.require(:episode).permit(:content, :when, :where).merge(card_id: params[:card_id].to_i).merge(user_id: current_user.id).merge(group_id: current_user.group_id)
  end
end
