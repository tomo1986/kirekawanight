class Front::BlogsController < ApplicationController
  layout "front/blog"

  def index
    @head_title = "ベトナム・ホーチミン/ハノイで夜遊びブログ！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、観光、ブログ、キレカワ、kirekawa"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛い女の子がきっと見つかる夜遊びサイトのブログ。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    limit = params[:limit].to_i.abs > 0 ? params[:limit].to_i.abs : 10
    page = params[:page].to_i.abs > 0 ? params[:page].to_i.abs : 1
    @blogs = Blog.order("id desc").page(page).per(limit)
    @total = @blogs.count
  end

  def show
   @blog = Blog.find_by(id: params[:id])
   @head_title = @blog ? @blog.head_title_ja : "aaa"
   @head_keyword = @blog ? @blog.head_keyword_ja : "aaa"
   @head_description = @blog ? @blog.head_description_ja : "aaa"
   @previous_blog = @blog.previous
   @next_blog = @blog.next
  end
end
