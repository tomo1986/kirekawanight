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
    @head_title = "ホーチミンの夜遊びの情報サイト「キレカワ」！！ベトナム・ホーチミンの女性#{User.count}名の素顔を公開！ | あなた好みの美女と夜遊びするなら「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケ、ガールズバー、マッサージやスパなどの、夜遊びの情報サイトです。現在、登録店舗#{Shop.count}店舗、ベトナム女性#{User.count}名が登録されています。観光や旅行に来られた際にはガイドも承ってます。あなた好みの美女と夜遊びするならキレカワ"
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

  def mypage
    if customer_signed_in?
      @head_title = "ベトナム・ホーチミンの女性#{User.count}名の素顔を公開！ホーチミンの夜遊びの情報サイト | あなた好みの美女と夜遊びするなら「キレカワ」マイページ"
      @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
      @head_description = "マイページではお気に入り登録した女の子を一覧で見ることができます。キレカワではベトナム・ホーチミンのカラオケ、ガールズバー、マッサージやスパなど、夜遊びの情報サイトです。現在、登録店舗#{Shop.count}店舗、ベトナム女性#{User.count}名が登録されています。"
      render action: :index
    else
      redirect_to root_path
    end
  end
  def mypage_show
    if customer_signed_in?
      @head_title = "ベトナム女性登録数#{User.count}名！ホーチミンの夜遊びの情報サイト |「キレカワ」マイページ詳細"
      @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
      @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワのマイページ詳細"
      render action: :index
    else
      redirect_to root_path
    end
  end

  def mypage_edit
    if customer_signed_in?
      @head_title = "ベトナム女性登録数#{User.count}名！！ホーチミン/ハノイで夜遊びできるサイト | 「キレカワ」会員情報変更ページ"
      @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
      @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワの会員情報編集ページ"
      render action: :index
    else
      redirect_to root_path
    end
  end

  def mypage_contacts
    if customer_signed_in?
      @head_title = "ベトナム女性登録数#{User.count}名！！ホーチミン/ハノイで夜遊びできるサイト | 「キレカワ」会員情報変更ページ"
      @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
      @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワの会員情報編集ページ"
      render action: :index
    else
      redirect_to root_path
    end
  end

  def mypage_reviews
    if customer_signed_in?
      @head_title = "ベトナム女性登録数#{User.count}名！！ホーチミン/ハノイで夜遊びできるサイト | 「キレカワ」会員情報変更ページ"
      @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
      @head_description = "ベトナム、ホーチミン/ハノイで綺麗、可愛いカラオケの女の子がきっと見つかり、夜遊びできるサイト。カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワの会員情報編集ページ"
      render action: :index
    else
      redirect_to root_path
    end
  end


  def shop_karaoke
    @head_title = "ベトナム・ホーチミンにあるカラオケ店#{Shop.where(job_type: 'karaoke').count}件を紹介！！ホーチミンの夜遊びの情報サイト |「キレカワ」カラオケ店一覧"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム、ホーチミンのカラオケ#{Shop.where(job_type: 'karaoke').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！あなた好みのカラオケ店がを見つけて夜遊びしてみませんか？"
    render action: :index
  end

  def shop_karaoke_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」を紹介！！ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」このお店のキャッチコピーは「#{shop.catch_copy}」。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end
  def shop_karaoke_detail_system
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」の料金表。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」このお店の料金表を見ることができます。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_karaoke_detail_cast
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」で働く#{shop.users.count}人の女の子一覧。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」では現在#{shop.users.count}人の女の子の素顔を公開！！また、キレカワからの予約で「#{shop.service}」の割引があります。ちょっとエッチな夜を過ごしませんか？"
    render action: :index
  end

  def shop_karaoke_detail_contact
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」で働く#{shop.users.count}人の女の子一覧。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」では現在#{shop.users.count}人の女の子が登録されいています。こちらのページから#{shop.name}の予約が可能です。早めに予約をしてホーチミンの夜を美女と過ごしませんか？"
    render action: :index
  end

  def shop_karaoke_detail_reviews
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」の口コミ数#{shop.reviews.count}件。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」では現在#{shop.reviews.count}件書かれています。！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_karaoke_detail_write_review
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」への口コミを書いてみませんか？。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるカラオケ店「#{shop.name}」に口コミを書いてみませんか？あなたの口コミでお店がもっとよくなる。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end


  def shop_bar
    @head_title = "ベトナム・ホーチミンにあるガールズバー#{Shop.where(job_type: 'bar').count}件を紹介！！ホーチミンの夜遊びの情報サイト | 「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるガールズバー#{Shop.where(job_type: 'bar').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！また、お店毎の色がありどこにいっても楽しめます！！あなた好みのお店をみつけるならキレカワ"
    render action: :index
  end

  def shop_bar_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるガールズバー「#{shop.name}」を紹介！！ホーチミンの夜遊びの情報サイト | 「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるガールズバー「#{shop.name}」を紹介！！このお店のキャッチコピーは「#{shop.catch_copy}」。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end


  def shop_bar_detail_system
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのガールズバー「#{shop.name}」の料金表。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム、ホーチミンにあるガールズバー「#{shop.name}」このお店の料金表を見ることができます。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_bar_detail_cast
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのガールズバー「#{shop.name}」で働く#{shop.users.count}人の女の子一覧。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム、ホーチミンにあるガールズバー「#{shop.name}」では現在#{shop.users.count}人の女の子が登録されいています。他にも何人もいますよ！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_bar_detail_contact
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのガールズバー「#{shop.name}」で働く#{shop.users.count}人の女の子一覧。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム、ホーチミンにあるガールズバー「#{shop.name}」では現在#{shop.users.count}人の女の子が登録されいています。他にも何人もいますよ！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_bar_detail_reviews
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのガールズバー「#{shop.name}」の口コミ数#{shop.reviews.count}件。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム、ホーチミンにあるガールズバー「#{shop.name}」では現在#{shop.reviews.count}件書かれています。！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_bar_detail_write_review
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナムのガールズバー「#{shop.name}」への口コミを書いてみませんか？。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム、ホーチミンにあるガールズバー「#{shop.name}」に口コミを書いてみませんか？あなたの口コミでお店がもっとよくなる。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end


  def shop_massage
    @head_title = "ベトナム・ホーチミンにあるマッサージ店#{Shop.where(job_type: 'karaoke').count}件を紹介！！ホーチミンの夜遊びの情報サイト |「キレカワ」カラオケ店一覧"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店#{Shop.where(job_type: 'karaoke').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！また、お店毎の色がありどこにいっても楽しめます！！あなた好みのお店をみつけるならキレカワ"
    render action: :index
  end

  def shop_massage_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」を紹介！！ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」このお店のキャッチコピーは「#{shop.catch_copy}」。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end
  def shop_massage_detail_system
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」の料金表。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」このお店の料金表を見ることができます。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_massage_detail_cast
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」で働く#{shop.users.count}人の女の子一覧。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」では現在#{shop.users.count}人の女の子が登録されいています。他にも何人もいますよ！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_massage_detail_contact
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」で働く#{shop.users.count}人の女の子一覧。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」では現在#{shop.users.count}人の女の子が登録されいています。他にも何人もいますよ！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_massage_detail_reviews
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」の口コミ数#{shop.reviews.count}件。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」では現在#{shop.reviews.count}件書かれています。！！また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end

  def shop_massage_detail_write_review
    shop = Shop.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」への口コミを書いてみませんか？。ホーチミンの夜遊びの情報サイト |「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンにあるマッサージ店「#{shop.name}」に口コミを書いてみませんか？あなたの口コミでお店がもっとよくなる。また、キレカワからの予約で「#{shop.service}」の割引があります。"
    render action: :index
  end




  
  
  def cast_karaoke
    @head_title = "ベトナム・ホーチミンのカラオケで働く女性#{User.where(job_type: 'karaoke').count}名を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケで働く女性#{User.where(job_type: "karaoke").count}名を紹介！！お気に入りの女性を見つけて、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_karaoke_detail
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのカラオケで働く女性「#{user.name}」さんを紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケで働く女性#{User.where(job_type: "karaoke").count}人の中から、#{user.name}さんの紹介ページです。#{user.name}さんと、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_karaoke_detail_cast
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのカラオケで働く女性「#{user.name}」さんと一緒に働いている女性を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケで働く女性#{user.name}さんと一緒に働いている女性を紹介します。#{user.name}さん達と、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_karaoke_detail_contact
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのカラオケで働く女性「#{user.name}」さんと連絡をとってみませんか？ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケで働く女性#{user.name}さんと連絡をとってみませんか？"
    render action: :index
  end

  def cast_karaoke_detail_reviews
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのカラオケで働く女性「#{user.name}」さんの口コミです。 |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケで働く女性#{user.name}さんの口コミ一覧ページです。あなたも口コミを書いてもっと素敵な女性になってもらいませんか？"
    render action: :index
  end

  def cast_bar
    @head_title = "ベトナム・ホーチミンのガールズバーで働く女性#{User.where(job_type: 'karaoke').count}名を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのガールズバーで働く女性#{User.where(job_type: "bar").count}名を紹介！！お気に入りの女性を見つけて、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_bar_detail
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのガールズバーで働く女性「#{user.name}」さんを紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのガールズバーで働く女性#{User.where(job_type: "bar").count}人の中から、#{user.name}さんの紹介ページです。#{user.name}さんと、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_bar_detail_cast
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのガールズバーで働く女性「#{user.name}」さんと一緒に働いている女性を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのガールズバーで働く女性#{user.name}さんと一緒に働いている女性を紹介します。#{user.name}さん達と、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_bar_detail_contact
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのガールズバーで働く女性「#{user.name}」さんと連絡をとってみませんか？ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのガールズバーで働く女性#{user.name}さんと連絡をとってみませんか？"
    render action: :index
  end

  def cast_bar_detail_reviews
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのガールズバーで働く女性「#{user.name}」さんの口コミです。 |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのガールズバーで働く女性#{user.name}さんの口コミ一覧ページです。あなたも口コミを書いてもっと素敵な女性になってもらいませんか？"
    render action: :index
  end


  def cast_massage
    @head_title = "ベトナム・ホーチミンのマッサージ店で働く女性#{User.where(job_type: 'massage').count}名を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのマッサージ店で働く女性#{User.where(job_type: "massage").count}名を紹介！！お気に入りの女性を見つけて、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_massage_detail
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのマッサージ店で働く女性「#{user.name}」さんを紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのマッサージ店で働く女性#{User.where(job_type: "massage").count}人の中から、#{user.name}さんの紹介ページです。#{user.name}さんと、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_massage_detail_cast
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのマッサージ店で働く女性「#{user.name}」さんと一緒に働いている女性を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのマッサージ店で働く女性#{user.name}さんと一緒に働いている女性を紹介します。#{user.name}さん達と、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_massage_detail_contact
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのマッサージ店で働く女性「#{user.name}」さんと連絡をとってみませんか？ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのマッサージ店で働く女性#{user.name}さんと連絡をとってみませんか？"
    render action: :index
  end

  def cast_massage_detail_reviews
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンのマッサージ店で働く女性「#{user.name}」さんの口コミです。 |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのマッサージ店で働く女性#{user.name}さんの口コミ一覧ページです。あなたも口コミを書いてもっと素敵な女性になってもらいませんか？"
    render action: :index
  end

  def cast_guide
    @head_title = "ベトナム・ホーチミンをガイドできる女性#{User.where(job_type: 'guide').count}名を紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンをガイドできる女性#{User.where(job_type: "guide").count}名を紹介！！お気に入りの女性を見つけて、ベトナムを満喫しませんか？"
    render action: :index
  end

  def cast_guide_detail
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンをガイドできる女性「#{user.name}」さんを紹介！！ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンをガイドできる女性#{User.where(job_type: "guide").count}人の中から、#{user.name}さんの紹介ページです。#{user.name}さんと、ベトナムの夜を満喫しませんか？"
    render action: :index
  end


  def cast_guide_detail_contact
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンをガイドできる女性「#{user.name}」さんと連絡をとってみませんか？ |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンをガイドできる女性#{user.name}さんと連絡をとって、ベトナムを案内してもらいませんか？絶対に楽しい旅行になること間違いなし！！"
    render action: :index
  end

  def cast_guide_detail_reviews
    user = User.find_by(id: params[:id])
    @head_title = "ベトナム・ホーチミンをガイドできる女性「#{user.name}」さんの口コミです。 |　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンをガイドできる女性#{user.name}さんの口コミ一覧ページです。あなたも口コミを書いてみませんか？"
    render action: :index
  end

  def comsept
    @head_title = "キレカワとはホーチミンのカラオケ、ガールズバー、マッサージ、スパの紹介と夜遊び専門の情報サイト | あなた好みの美女と夜遊びするなら「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "キレカワとは、ホーチミンの「カラオケラウンジ」、「ガールズバー」、「クラブ＆ナイトバー」、「マッサージ、スパ」のナイトスポットと夜遊びの情報サイトです。 ホーチミンの限られた滞在時間。お店選びに失敗はしたくありませんね。 当サイトでは、ホーチミン中心にあるおすすめ店を厳選し紹介します。"
    render action: :index
  end

  def contact

  end

  def reserve

  end

  def question

  end
  def visitor
    @head_title = "キレカワの使い方や使用法方の説明。ホーチミンの夜遊びの情報サイト | あなた好みの美女と夜遊びするなら「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "キレカワをご覧いただきありがとうございます。キレカワを使って安心・安全にホーチミンの夜遊びや風俗を楽しんでいただくために、使用法方やどんなことができるかを説明します。"
    render action: :index
  end

end
