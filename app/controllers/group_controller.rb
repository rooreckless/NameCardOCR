class GroupController < ApplicationController
  def new
    if (current_user.owned_group_id != nil) and (current_user.group_id != nil)
      @group=Group.find_by(user_id: current_user.id)
    else
      @group=Group.new()
    end
    # binding.pry
  end
  def update
    # 自分がオーナーになっていて所属しているグループの名前やパスワードを変更する。
    if current_user.owned_group_id == current_user.group_id
      @group=Group.find(current_user.group_id)
      if @group.update(update_params)
        # グループのアップデートが完了した場合のリダイレクト先
        redirect_to new_group_path,notice: 'グループ編集しました。' and return
      else
        redirect_to new_group_path,alert: 'エラー グループの編集に失敗しました。' and return
      end
    else
      redirect_to new_group_path,alert: 'グループの編集に失敗しました。' and return
    end
  end
  def create
    # グループを作成するときにそのユーザが何かのグループのオーナーか、グループに所属しているなら新規作成は不可能
    if (current_user.owned_group_id != nil) or (current_user.group_id != nil)
      redirect_to root_path,notice: 'グループの作成には、グループのオーナでなく、グループに未所属でないとできません。' and return
    end
    group=Group.new(group_params)
    begin
      if group.save!
        current_user.update_attributes(group_id: group.id,owned_group_id: group.id)
        # グループを作ったなら、そのユーザはグループのオーナーになるし、グループに所属するためにupdate_attributesします。
        redirect_to root_path,notice: 'グループを作成しました。以降に登録する名刺はグループ内で確認できます。参加者する際、設定したパスワードが必要です。' and return
      else
        redirect_to new_group_path,alert: 'エラー グループの作成に失敗しました。' and return
      end
    rescue
      redirect_to new_group_path,alert: 'エラー グループの作成に失敗しました。' and return
    end
  end
  def belonggroup
    if current_user.group_id==nil
      # ログインユーザが所属しているグループがない場合に限られます。
      wantbelong_group=Group.find(belonging_params[:wantbelong_groupid].to_i)
      # 所属したいグループを検索
      if wantbelong_group.authenticate(belonging_params[:wantbelong_grouppassword])
        # グループ登録用パスワードが、一致している場合のみ有効
        if current_user.update(group_id: belonging_params[:wantbelong_groupid].to_i)
          # ログインユーザの所属グループカラムを更新できたならリダイレクトします。
          redirect_to root_path,notice: 'グループに参加しました。以降に登録する名刺はグループ内で確認できます。' and return
        else
          # updateメソッドがfalseの場合
          redirect_to new_group_path,alert: 'エラー グループに参加に失敗しました。' and return
        end
      else
        # authenticateメソッドでfalseの場合
        redirect_to new_group_path,alert: 'グループに参加できません。パスワードが一致していません。' and return
      end
    else
      redirect_to new_group_path,alert: 'グループに参加に失敗しました。' and return
    end
  end
  def resigngroup
    if current_user.group_id!=nil and current_user.owned_group_id==nil
      # ログインユーザが所属しているグループがあり、ログインユーザはグループオーナではない場合に限られます。
      wantbelong_group=nil
        if current_user.update(group_id: wantbelong_group)
          # ログインユーザの所属グループカラムを更新できたならリダイレクトします。
          redirect_to root_path,notice: 'グループを退会しました。' and return
        else
          redirect_to root_path,alert: 'エラー グループの退会に失敗しました。' and return
        end
    else
      redirect_to root_path,alert: 'グループの退会に失敗しました。' and return
    end
  end
  private 
  def group_params
    # params.require(:group).permit(:name, :password_digest).merge(user_id: current_user.id)
    params.require(:group).permit(:name, :password,:password_confirmation).merge(user_id: current_user.id)
  end
  def update_params
    params.require(:group).permit(:name, :password,:password_confirmation).merge(user_id: current_user.id)
  end
  def belonging_params
    params.require(:group).permit(:wantbelong_groupid,:wantbelong_grouppassword)
  end
end
