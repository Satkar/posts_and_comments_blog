class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_post

  # GET posts/:id/comments/1/edit
  def edit
  end

  # POST posts/:id/comments
  def create
    @comment = @post.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(id: @post.id), notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT posts/:id/comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(id: @post.id), notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE posts/:id/comments/1
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(id: @post.id), notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:message)
    end

    def find_post
      @post = Post.find(params[:post_id])
    end
end
