class Front::HomeController < ApplicationController
  layout "front/base"
  def templates
    path = ''
    path = '/' + params[:path1] if params[:path1].present?
    path = path + '/' + params[:path2] if params[:path2].present?
    path = path + '/' + params[:name]
    begin
      render template: "front/tpl#{path}", layout: false
    rescue Exception => exception
      if Rails.env == 'development'
        p exception.message
        render text: exception.message
      else
        render text: t('controllers.tpl.actions.index.template_not_found', :tpl_path => path)
      end
    end
  end

  def index
    @head_title = "ベトナム・ホーチミン/ハノイで夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛い女の子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
  end
  def login
    if customer_signed_in?
      redirect_to action: 'index'
    end
  end

  def logout
    sign_out current_customer if customer_signed_in?
    redirect_to root_path
  end

  def group_karaoke
    p "soeya"
    @head_title = "ベトナム・ホーチミン/ハノイでカラオケの女の子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def group_karaoke_detail

  end

  def group_bar
    @head_title = "ベトナム・ホーチミン/ハノイでガールズバーの女の子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いガールズバーの女の子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def group_bar_detail

  end

  def group_massage
    @head_title = "ベトナム・ホーチミン/ハノイでマッサージの女の子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いマッサージの女の子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def group_massage_detail

  end

  def cast_karaoke
    @head_title = "ベトナム・ホーチミン/ハノイでカラオケで働くお気に入りの子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイのカラオケで働く綺麗、可愛いあの子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def cast_karaoke_detail

  end

  def cast_bar
    @head_title = "ベトナム・ホーチミン/ハノイでガールズバーで働くお気に入りの子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイのガールズバーで働く綺麗、可愛いあの子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def cast_bar_detail

  end

  def cast_massage
    @head_title = "ベトナム・ホーチミン/ハノイでマッサージで働くお気に入りの子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイのマッサージで働く綺麗、可愛いお気に入りの子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def cast_massage_detail

  end

  def cast_sexy
    @head_title = "ベトナム・ホーチミン/ハノイでセクシーな子と夜遊び！！ | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイのセクシーな子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すなら、キレカワ"
    render action: :index
  end

  def cast_sexy_detail

  end

  def comsept
    @head_title = "キレカワとは? | キレカワ"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイのセクシーな子がきっと見つかる夜遊びサイト。カラオケ/マッサージ/バーの女の子を探すキレカワってなに？"
    render action: :index
  end

  def contact

  end

  def reserve

  end

  def question

  end
  def visitor

  end

end
