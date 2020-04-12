class GroupController < ApplicationController
  def new
    if (current_user.owned_group_id != nil) and (current_user.belonging_group_id != nil)
      @group=Group.find_by(user_id: current_user.id)
    else
      @group=Group.new()
    end
  end
  def update
    # binding.pry
  end
  def create
    # グループを作成するときにそのユーザが何かのグループのオーナーか、グループに所属しているなら新規作成は不可能
    if (current_user.owned_group_id != nil) or (current_user.belonging_group_id != nil)
      redirect_to root_path and return
    end
    group=Group.new(group_params)
    if group.save!
      current_user.update_attributes(belonging_group_id: group.id,owned_group_id: group.id)
      # グループを作ったなら、そのユーザはグループのオーナーになるし、グループに所属するためにupdate_attributesします。
      redirect_to root_path and return
    else
      redirect_to new_group_path and return
    end
    
  end
  private 
  def group_params
    # params.require(:group).permit(:name, :password_digest).merge(user_id: current_user.id)
    params.require(:group).permit(:name, :password,:password_confirmation).merge(user_id: current_user.id)
  end
end
