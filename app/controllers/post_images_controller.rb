class PostImagesController < ApplicationController
  
  def new
    @post_image = PostImage.new
  end
  
  def create
    # フォームから送信されたデータを受け取り、PostImageモデルに保存する
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end
  
  def index
    @post_images = PostImage.page(params[:page])
  end
  
  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  
  def destroy
    post_image = PostImage.find(params[:id]) #削除するPostImageレコードを取得
    post_image.destroy                       #削除
    redirect_to post_images_path                 #PostImageの一覧ページへのパス
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
  
end
