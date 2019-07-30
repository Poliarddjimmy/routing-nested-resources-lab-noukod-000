class SongsController < ApplicationController

  def index
    if params[:artist_id]
      @songs = Song.where(artist_id: params[:artist_id])
      if @songs.empty?
        flash[:alert] = "Artist not found."
        @songs = Song.all.limit(200)
        redirect_to songs_path
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @song = Song.find_by(id: params[:id], artist_id: params[:artist_id])

      unless @song
        flash[:alert] = "Song not found."
        redirect_to artist_songs_path(Artist.find(params[:artist_id]))
        puts "testttttttttttttttttttttttt"
      end
    else
      @song = Song.find_by(id: params[:id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
