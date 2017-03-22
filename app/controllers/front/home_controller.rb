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
    @head_title = "ベトナム・ホーチミン初！！夜のお店で働く女の子・店舗の紹介をする夜遊び情報サイト「キレカワ」| あなた好みの美女と夜遊びするなら「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミン初！！カラオケ、バー、ラウンジ、マッサージやスパなどの、夜遊びの情報サイトです。現在、登録店舗#{Shop.count}店舗、ベトナム女性#{User.count}名が登録されています。観光や旅行に来られた際にはガイドも承ってます。あなた好みの美女と夜遊びするならキレカワ"
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
      @head_title = "ベトナム・ホーチミン初！！夜のお店で働く女性#{User.count}名の素顔を公開！ホーチミンの夜遊びの情報サイト | あなた好みの美女と夜遊びするなら「キレカワ」マイページ"
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
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    page = params[:page]
    if page.present?
      @head_title = "全てのカラオケ店舗一覧(#{page}ページ目)　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
      @head_description = "キレカワに掲載中の全てのカラオケ店舗一覧の#{page}ページ目です。ベトナム、ホーチミンのカラオケ#{Shop.where(job_type: 'karaoke').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！あなた好みのカラオケ店がを見つけて夜遊びしてみませんか？"
    else
      @head_title = "全てのカラオケ店舗一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
      @head_description = "キレカワに掲載中の全てのカラオケ店舗一覧です。ベトナム、ホーチミンのカラオケ#{Shop.where(job_type: 'karaoke').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！あなた好みのカラオケ店がを見つけて夜遊びしてみませんか？"
    end
    render action: :index
  end

  def shop_karaoke_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のカラオケ店舗情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のカラオケ店舗詳細ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end
  def shop_karaoke_detail_system
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のカラオケ店料金情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のカラオケ店料金ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_karaoke_detail_cast
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のカラオケ店女の子情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のカラオケ店で働く女の子一覧ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_karaoke_detail_contact
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のカラオケ店に予約しよう　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のカラオケ店に予約ができます。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_karaoke_detail_reviews
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のカラオケ店の口コミ　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のカラオケ店の口コミ一覧ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_karaoke_detail_write_review
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のカラオケ店の口コミを書いてみませんか？　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のカラオケ店の口コミを書いてみませんか？ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end


  def shop_bar
    @head_title = "全てのガールズバー店舗一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "KireKawaに掲載中の全てのガールズバー店舗一覧です♪ベトナム、ホーチミンのガールズバー#{Shop.where(job_type: 'bar').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！あなた好みの店がを見つけて夜遊びしてみませんか？"
    render action: :index
  end

  def shop_bar_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のガールズバー料金情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のガールズバー料金ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end


  def shop_bar_detail_system
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のガールズバー女の子情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のガールズバーで働く女の子一覧ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
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
    @head_title = "【#{shop.name}】#{shop.name_kana}のガールズバーに予約しよう　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のガールズバーに予約ができます。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_bar_detail_reviews
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のガールズバーの口コミ　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のガールズバーの口コミ一覧ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_bar_detail_write_review
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のガールズバーの口コミを書いてみませんか？　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のガールズバーの口コミを書いてみませんか？ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end


  def shop_massage
    @head_title = "全てのマッサージ店舗一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "KireKawaに掲載中の全てのマッサージ店舗一覧です♪ベトナム、ホーチミンのマッサージ#{Shop.where(job_type: 'massage').count}件掲載中。キレカワに掲載しているお店は自信を持って紹介できます！あなた好みのマッサージ店を見つけて夜遊びしてみませんか？"
    render action: :index
  end

  def shop_massage_detail
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のマッサージ店舗情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のマッサージ店舗詳細ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
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
    @head_title = "【#{shop.name}】#{shop.name_kana}のマッサージ店料金情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のマッサージ店料金ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_massage_detail_contact
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のマッサージ店女の子情報　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のマッサージ店で働く女の子一覧ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_massage_detail_reviews
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のマッサージ店に予約しよう　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のマッサージ店に予約ができます。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end

  def shop_massage_detail_write_review
    shop = Shop.find_by(id: params[:id])
    @head_title = "【#{shop.name}】#{shop.name_kana}のマッサージ店の口コミ　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "【#{shop.name}】#{shop.name_kana}のマッサージ店の口コミ一覧ページです。ベトナム・ホーチミンの夜遊び情報サイトKireKawa(キレカワ)なら店舗情報はもちろん、お店の女の子やオトクなクーポン情報まで情報満載！アナタにピッタリのお店も見つかっちゃうかも・・・"
    render action: :index
  end



  def cast_karaoke
    @head_title = "カラオケで働く女の子情報一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのカラオケで働く女の子情報一覧ページです。#{User.where(job_type: "karaoke").count}名の中からお気に入りの女の子を見つけて、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_karaoke_detail
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "【#{user.name}】カラオケ店#{shop_name}の女の子詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】カラオケ店#{shop_name}の女の子詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"

    render action: :index
  end

  def cast_karaoke_detail_cast
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    @head_title = "【#{user.name}】カラオケ店#{shop_name}の女の子一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_description = "【#{user.name}】カラオケ店#{shop_name}の女の子一覧ページ。カラオケ店#{shop_name}の女の子と、ベトナムの夜を満喫しませんか？"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_karaoke_detail_contact
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "カラオケ店#{shop_name}【#{user.name}】にコンタクト　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "カラオケ店#{shop_name}【#{user.name}】へコンタクトページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】へコンタクトページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_karaoke_detail_reviews
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "カラオケ店#{shop_name}【#{user.name}】の口コミ一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "カラオケ店#{shop_name}【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_bar
    @head_title = "ガールズバーで働く女の子情報一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのガールズバーで働く女の子情報一覧ページです。#{User.where(job_type: "bar").count}名の中からお気に入りの女の子を見つけて、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_bar_detail
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "【#{user.name}】ガールズバー#{shop_name}の女の子詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】ガールズバー#{shop_name}の女の子詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_bar_detail_cast
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    @head_title = "【#{user.name}】ガールズバー#{shop_name}の女の子一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_description = "【#{user.name}】ガールズバー#{shop_name}の女の子一覧ページ。ガールズバー#{shop_name}の女の子と、ベトナムの夜を満喫しませんか？"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_bar_detail_contact
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "ガールズバー#{shop_name}【#{user.name}】にコンタクト　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "ガールズバー#{shop_name}で働く【#{user.name}】へコンタクトページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】へコンタクトページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_bar_detail_reviews
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "ガールズバー#{shop_name}【#{user.name}】の口コミ一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "ガールズバー#{shop_name}【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end


  def cast_massage
    @head_title = "マッサージ店で働く女の子情報一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのマッサージで働く女の子情報一覧ページです。#{User.where(job_type: "massage").count}名の中からお気に入りの女の子を見つけて、ベトナムの夜を満喫しませんか？"
    render action: :index
  end

  def cast_massage_detail
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "【#{user.name}】マッサージ店#{shop_name}の女の子詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】マッサージ店#{shop_name}の女の子詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_massage_detail_cast
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    @head_title = "【#{user.name}】マッサージ店#{shop_name}の女の子一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
    @head_description = "【#{user.name}】マッサージ店#{shop_name}の女の子一覧ページ。マッサージ店#{shop_name}の女の子と、ベトナムの夜を満喫しませんか？"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_massage_detail_contact
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "ガールズバー#{shop_name}【#{user.name}】にコンタクト　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "ガールズバー#{shop_name}で働く【#{user.name}】へコンタクトページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】へコンタクトページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_massage_detail_reviews
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "マッサージ店#{shop_name}【#{user.name}】の口コミ一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "マッサージ店#{shop_name}【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_guide
    page = params[:page]
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    if page.present?
      @head_title = "ガイドができる女の子情報一覧(#{page}ページ目)　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
      @head_description = "ベトナム・ホーチミンのガイドができる女の子情報一覧の#{page}ページ目です。#{User.where(can_guided: true).count}名の中からお気に入りの女の子を見つけて、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "ガイドができる女の子情報一覧　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
      @head_description = "ベトナム・ホーチミンのガイドができる女の子情報一覧ページです。#{User.where(can_guided: true).count}名の中からお気に入りの女の子を見つけて、ベトナムの夜を満喫しませんか？"
    end
    render action: :index
  end

  def cast_guide_detail
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "【#{user.name}】#{shop_name}のガイドができる女の子詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】#{shop_name}のガイドができる女の子詳細ページ。#{user.name}と、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "ガイドができる【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "ガイドができる【#{user.name}】の詳細ページ。#{user.name}にガイドを頼んで、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end


  def cast_guide_detail_contact
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "#{shop_name}で働く【#{user.name}】にガイドの依頼　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "#{shop_name}で働く【#{user.name}】にガイドの依頼ページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】へガイドの依頼ページ。#{user.name}にコンタクトを取って、ベトナムの夜を満喫しませんか？"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def cast_guide_detail_reviews
    user = User.find_by(id: params[:id])
    shop_name = user.shop ? user.shop.name : nil
    if shop_name
      @head_title = "#{shop_name}で働く【#{user.name}】のガイド口コミ一覧　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "#{shop_name}【#{user.name}】のガイド口コミ一覧ページ。#{user.name}の口コミが見れます"
    else
      @head_title = "【#{user.name}】の詳細　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "【#{user.name}】の口コミ一覧ページ。#{user.name}の口コミが見れます"
    end
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    render action: :index
  end

  def comsept
    @head_title = "キレカワとはホーチミンのカラオケ、ガールズバー、マッサージ、スパを紹介する、ホーチミンの夜遊び情報サイトです。"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "キレカワとは、ホーチミンの「カラオケラウンジ」、「ガールズバー」、「クラブ＆ナイトバー」、「マッサージ、スパ」のナイトスポットと夜遊びの情報サイトです。 ホーチミンの限られた滞在時間。お店選びに失敗はしたくありませんね。 当サイトでは、ホーチミン中心にあるおすすめ店を厳選し紹介します。"
    render action: :index
  end

  def contact

    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    info = params[:type]
    if info == 'post'
      @head_title = "広告掲載のお問い合わせ　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "広告掲載のお問い合わせ、質問、ガイド予約。まずはこちらからお問い合わせ。あなた好みの美女と夜遊びするなら「キレカワ」"
    elsif info == 'tie-up'
      @head_title = "タイアップのお問い合わせ　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "タイアップのお問い合わせ、質問、ガイド予約。まずはこちらからお問い合わせ。あなた好みの美女と夜遊びするなら「キレカワ」"
    else
      @head_title = "お問い合わせ　|　ホーチミンの夜遊びの情報サイト「キレカワ」"
      @head_description = "質問、ガイド予約。まずはこちらからお問い合わせ。あなた好みの美女と夜遊びするなら「キレカワ」"
    end

    render action: :index
  end

  def question
    @head_title = "ベトナムの風俗の種類って？　|　 ベトナム・ホーチミンの夜遊び情報サイトならKire Kawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナムの風俗の種類について。いろんな種類の夜遊びや、風俗があるので安心、安全に遊んでいただくために説明します。"
    render action: :index
  end
  def policy
    @head_title = "キレカワのプライバシーポリシー | ベトナム・ホーチミンの夜遊び情報ならKire Kawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム・ホーチミンの夜遊び情報サイトKire Kawa(キレカワ)のプライバシーポリシーについて。カラオケ、ガールズバー、マッサージなどを安心・安全に遊んでいただくために。"
    render action: :index
  end

  def terms
    @head_title = "キレカワの利用規約 | ベトナム・ホーチミンの夜遊び情報ならKire Kawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム・ホーチミンの夜遊び情報サイトKire Kawa(キレカワ)の利用規約について。カラオケ、ガールズバー、マッサージなどを安心・安全に遊んでいただくために。"
    render action: :index
  end

  def visitor
    @head_title = "キレカワの使い方 | ベトナム・ホーチミンの夜遊び情報ならKire Kawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "ベトナム・ホーチミンの夜遊び情報サイトKire Kawa(キレカワ)の使い方について。カラオケ、ガールズバー、マッサージなどを安心・安全に遊んでいただくために。"
    render action: :index
  end

  def sitemap
    @head_title = "キレカワサイトマップ。ホーチミンの夜遊びの情報サイト | あなた好みの美女と夜遊びするなら「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "キレカワをご覧いただきありがとうございます。サイトマップです。キレカワを使って安心・安全にホーチミンの夜遊びを楽しみたいあなたに"
    render action: :index
  end

  def visitor
    @head_title = "キレカワの使い方や使用法方の説明。ホーチミンの夜遊びの情報サイト | あなた好みの美女と夜遊びするなら「キレカワ」"
    @head_keyword = "ベトナム、ホーチミン、ハノイ、夜遊び、カラオケ、マッサージ、バー、観光"
    @head_description = "キレカワをご覧いただきありがとうございます。キレカワを使って安心・安全にホーチミンの夜遊びを楽しんでいただくために、使用法方やどんなことができるかを説明します。"
    render action: :index
  end
  def map
    @head_title = "地図から店舗を検索　|　ベトナム・ホーチミンの夜遊び情報ならKireKawa(キレカワ)"
    @head_keyword = "ベトナム、ホーチミン、夜遊び、カラオケ、ガールズバー、マッサージ、観光、ガイド"
    @head_description = "ベトナム・ホーチミンのお店を地図から検索。現在地から近いお店の一覧を調べることができます。"
    render action: :index
  end

end
