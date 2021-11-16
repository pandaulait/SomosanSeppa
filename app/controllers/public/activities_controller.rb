class Public::ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities.order(created_at: :desc)
  end

  def read
    current_user.activities.update_all(read: true)
    redirect_to activities_path
  end
end
