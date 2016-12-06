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
    @head_title = "ベトナム女性登録数#{User.count}名！！ホーチミン/ハノイで夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛い女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    @page_type = "website"
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

  def shop_karaoke
    @head_title = "ベトナムのカラオケ#{Shop.where(job_type: 'karaoke').count}件を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def shop_karaoke_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのカラオケ「#{shop.name}」を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def shop_bar
    @head_title = "ベトナムのガールズバー#{Shop.where(job_type: 'bar').count}件を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いガールズバーの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def shop_bar_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのガールズバー「#{shop.name}」を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def shop_massage
    @head_title = "ベトナムのマッサージ屋#{Shop.where(job_type: 'massage').count}件を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いマッサージの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def shop_massage_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのマッサージ「#{shop.name}」を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  
  
  def cast_karaoke
    @head_title = "ベトナムのカラオケで働く女性#{User.where(job_type: 'karaoke').count}名を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、観光、キレカワ、kirekawa"
    @head_description = "ベトナム、ホーチミン/ハノイのカラオケで働く#{User.where(job_type: "karaoke").count}人の可愛い女の子の中から、あなたのお気に入りの美女を見つけて夜遊びしませんか？カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    @site_title = "ベトナム・ホーチミン/ハノイで夜遊び！！カラオケの女の子数No.1「キレカワ」"
    render action: :index
  end

  def cast_karaoke_detail
    user = User.find_by(id: params[:id])
    @head_title = "ベトナムのカラオケで働く女性#{user.name}さんを紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、観光、キレカワ、kirekawa"
    @head_description = "ベトナム、ホーチミン/ハノイのカラオケで働く#{User.where(job_type: "karaoke").count}人の可愛い女の子の中から、あなたのお気に入りの美女を見つけて夜遊びしませんか？カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    @site_title = "ベトナム・ホーチミン/ハノイで夜遊び！！カラオケの女の子数No.1「キレカワ」"
    render action: :index

  end

  def cast_bar
    @head_title = "ベトナムのガールズバーで働く女性#{User.where(job_type: 'bar').count}名を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、バー、観光、キレカワ、kirekawa"
    @head_description = "ベトナム、ホーチミン/ハノイのガールズバーで働く#{User.where(job_type: "bar").count}人の可愛い女の子の中から、あなたのお気に入りの美女を見つけて夜遊びしませんか？カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def cast_bar_detail

  end

  def cast_massage
    @head_title = "ベトナムのマッサージ屋で働く女性#{User.where(job_type: 'massage').count}名を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、マッサージ、観光、キレカワ、kirekawa"
    @head_description = "ベトナム、ホーチミン/ハノイのマッサージで働く#{User.where(job_type: "massage").count}人の可愛い女の子の中から、あなたのお気に入りの美女を見つけて夜遊びしませんか？カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def cast_massage_detail

  end

  def cast_sexy
    @head_title = "ベトナムのセクシーな仕事をする女性#{User.where(job_type: 'sexy').count}名を紹介！！ホーチミン/ハノイで女の子と夜遊びできるサイト | 見つかる出会える女の子数No.1「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイの#{User.where(job_type: "sexy").count}人の可愛い女の子の中から、あなたのお気に入りの美女を見つけて夜遊びしませんか？カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
    render action: :index
  end

  def cast_sexy_detail

  end

  def comsept
    @head_title = "キレカワとは? | キレカワ"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム、ホーチミン/ハノイのセクシーな子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バーの女の子を探すキレカワってなに？"
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
