class Front::BlogsController < ApplicationController
  layout "front/blog"

  def index
    @head_title = "ベトナムの夜の街を案内！！ブログで見つけてね | 綺麗、可愛いをみつけるならkirekawで！！"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、エッチ、カラオケ、マッサージ"
    @head_description = "kfじゃsdlfjkぁjsdfかjsdflじゃsdぁjsdlfじゃsdjdふぁlksdjlふぁ"
    @blogs = Blog.all
  end

  def show
   @blog = Blog.find_by(id: params[:id])
   @head_title = @blog ? @blog.head_title_ja : "aaa"
   @head_keyword = @blog ? @blog.head_keyword_ja : "aaa"
   @head_description = @blog ? @blog.head_description_ja : "aaa"
  end
end
