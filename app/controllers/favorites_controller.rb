class FavoritesController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  # before_action :authorize_create, only: :create
  # before_action :authorize_destroy, only: :destroy

  # Favorite
  def create
    favorite          = Favorite.new
    favorite.user     = current_user
    favorite.post     = post

    respond_to do |format|
      if favorite.save
        @user_fav ||= post.fav_for(current_user)
        format.html { redirect_to post, notice: 'FAVORITED!' }
        format.js { render }
      else
        format.html { redirect_to post, alert:  'Already favorited' }
        format.js { render js: "alert('Can\ 't favorite, please refresh');" }
      end
    end
  end

  def destroy
    # Unfavorite
    favorite.destroy
    @user_fav = post.fav_for(current_user)
    respond_to do |format|
      format.html { redirect_to post_path(favorite.post_id), notice: 'Un-favorited' }
      format.js { render }
    end
  end

  private

  # def authorize_create
  # end
  #
  # def authorize_destroy
  # end

  def post
    @post ||= Post.friendly.find params[:post_id]
  end

  def favorite
    @favorite ||= Favorite.find params[:id]
  end
end
