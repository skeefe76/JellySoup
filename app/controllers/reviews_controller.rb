class ReviewsController < ApplicationController

  before_action :require_signin
  before_action :set_story

  def index
    @reviews = @story.reviews
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
  @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to @story, notice: "Review successfully updated!"
    else
      render :edit
    end
  end

  def new
    @review = @story.reviews.new
  end

  def create
    @review = @story.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to story_reviews_path(@story),
                    notice: "Thanks for your review!"
    else
      render :new
    end
  end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      redirect_to @story, alert: "Review successfully deleted"
    end

private

  def review_params
    params.require(:review).permit(:comment)
  end

  def set_story
      @story = Story.find(params[:story_id])
  end
end
