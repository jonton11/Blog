class FavoritesController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  # before_action :authorize_create, only: :create
  # before_action :authorize_destroy, only: :destroy

  def create
    # Favorite
    favorite          = Favorite.new
    favorite.user     = current_user
    favorite.post     = post
    if favorite.save
      redirect_to post, notice: 'FAVORITED!'
    else
      redirect_to post, alert:  "You've already favorited this"
    end
  end

  def destroy
    # Unfavorite
    favorite.destroy
    redirect_to post_path(favorite.post_id), notice: 'Un-favorited'
  end

  private

  # def authorize_create
  # end
  #
  # def authorize_destroy
  # end

  def post
    @post ||= Post.find params[:post_id]
  end

  def favorite
    @favorite ||= Favorite.find params[:id]
  end
end
