class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.where(item_id: params[:item_id])
    @item = Item.find(params[:item_id])
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @order = Order.find(params[:format])
    @review = Review.new
    @user_reviews = []
    @reviews = Review.where(user_id: current_user)
    @reviews.each do |review|
      @user_reviews << review.item_id
    end
  end

  # POST /reviews
  # POST /reviews.json
  def create
    # @order = Order.find(params[:item_id])
    @review = Review.new(review_params)
        # @review.user = current_user
    # respond_to do |format|
    #   if @review.save
    #     format.html { redirect_to @review, notice: 'Review was successfully created.' }
    #     format.json { render :index, status: :created, location: @review }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @review.errors, status: :unprocessable_entity }
    #   end
    # end
    @review.item = Item.find(params[:item_id])
    @review.user = current_user
    @review.save
  end

  # GET /reviews/1/edit
  def edit
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :content, :item_id, :user_id)
    end
end
