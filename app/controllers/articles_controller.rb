class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully submitted."
      redirect_to articles_path
    else
      flash.now[:error] = "Error: Article was not submitted. Please fill in both the title and body to submit an article."
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article was successfully updated."
    else
      flash.now[:error] = "An error prevented the article from being updated."
      render :edit
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy
      
    redirect_to articles_path, notice: "Article was successfully deleted."
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end


end
