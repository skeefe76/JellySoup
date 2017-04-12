class StoriesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
  @story = Story.find(params[:id])
    if @story.update(story_params)
      redirect_to @story, notice: "Story successfully updated!"
    else
      render :edit
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to @story, notice: "Story successfully created!"
    else
      render :new
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_url, alert: "Story successfully deleted"
  end

  private

    def story_params
      params.require(:story).permit(:title, :manuscript, :version_date)
    end

end
