class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  before_filter :categories, only: [:new, :edit, :index, :create]

  def index; redirect_to :action => 'new' ; end
  def edit
    @category = Category.find(params[:id])
    @category.attributes = params[:category]
    if request.post?
      respond_to do |format|
        format.html { save_category }
        format.js do
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
    end
  end

  def new
    @category = Category.new
    respond_to :html, :js
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      respond_to do |format|
        format.html { save_category }
        format.js do
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
    else
      render 'new'
    end
  end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  private

  def save_category
    if @category.save!
      flash[:notice] = _('Category was successfully saved.')
    else
      flash[:error] = _('Category could not be saved.')
    end
    redirect_to :action => 'new'
  end

  def categories
    @categories = Category.all
  end
end
