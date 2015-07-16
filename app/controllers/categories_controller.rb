class CategoriesController < ApplicationController
  before_action :need_log_in, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Catetory was created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
