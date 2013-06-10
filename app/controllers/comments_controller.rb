class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post,    only: [:show, :new, :create, :edit, :update, :destroy, :index]

  # GET /comments
  # GET /comments.json
  def index
    if @post
      @comments = @post.comments
    else
      @comments = Comment.all
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    if @post
      @comment = @post.comments.build
    else
      @comment = Comment.new
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    if @post
      @comment = @post.comments.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      if @post
        @comment = @post.comments.find(params[:id])
      else
        @comment = Comment.find(params[:id])
      end
    end

    def set_post
      @post = Post.find(params[:post_id]) if params[:post_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :author, :body)
    end
end
