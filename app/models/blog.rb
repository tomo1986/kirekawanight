class Blog < ApplicationRecord

  def previous
    Blog.where("id < ?", self.id).last
  end

  def next
    Blog.where("id > ?", self.id).first
  end
  def auto_save_user(user)
      self.subject_id = user.id
      self.subject_type = 'User'
      self.article_ja = Blog.make_article_ja_for_user(user)
      self.title_ja = Blog.make_title_ja_for_user(user)
      self.head_title_ja = Blog.make_head_title_ja_for_user(user)
      self.head_keyword_ja = Blog.make_head_keyword_ja_for_user(user)
      self.head_description_ja = Blog.make_head_description_ja_for_user(user)
      self.save!

  end

  def self.make_title_ja_for_user(user)
    return "<h2>ベトナムのホーチミン/ハノイの美女を紹介！今回は#{user.change_lang_job_type_at_ja}で働く#{user.nick_name}さんの紹介</h2>"
  end

  def self.make_head_title_ja_for_user(user)
    return "ベトナムのホーチミン/ハノイで美女発見！#{user.change_lang_job_type_at_ja}で働く#{user.nick_name}さんを紹介 |  見つかる出会える女の子数No.1「キレカワ」"
  end

  def self.make_head_keyword_ja_for_user(user)
    return "ベトナム、ホーチミン、ハノイ、夜遊び、#{user.change_lang_job_type_at_ja}、ブログ、キレカワ、kirekawa"
  end

  def self.make_head_description_ja_for_user(user)
    return "ベトナムのホーチミン/ハノイで美女発見！#{user.change_lang_job_type_at_ja}で働く#{user.nick_name}さんを紹介。#{user.nick_name}さんに会いたくなったらキレカワで！カラオケ/マッサージ/バー/セクシー美女を探すなら、キレカワ"
  end

  def self.make_article_ja_for_user(user)
    article = "<p>こんにちわ、キレカワ事務局の鈴木です。<br>"
    article = article + "キレカワブログはベトナムの夜遊び(カラオケ、バー、マッサージ、セクシー女性)ベトナムの美女の紹介や出会い方などについて書きます。<br>"
    article = article + " 今日ブログは#{user.change_lang_job_type_at_ja}の仕事をしている、#{user.nick_name}さんを紹介します<br><br></p>"
    article = article + "<p>#{user.nick_name}さんは今#{user.age}歳で#{user.group.address}にある#{user.group.name}というお店で働いています<br>"
    article = article + "そんな#{user.nick_name}さんにアンケートに答えてくれましましたので、ぜひお読みください！！<br><br></p>"

    article = article + "<div class='col-md-12 detail clearfix'><div class='row'>"
    article = article+ "<div class='col-xs-12 col-sm-4 col-sm-offset-0 col-md-4 col-md-offset-0 col-lg-2 col-lg-offset-0 col-xl-2 col-xl-offset-0'>"
    article = article+ "<div class='col-row-left clearfix'>"
    article = article + "<img class='img' src='#{user.images[0].image.url}'>"
    article = article+"</div>"
    article = article+"</div>"
    article = article + "<div class='col-xs-12 col-sm-8 col-md-8 col-lg-10 col-xl-10'>"
    article = article + "<div class='col-row-right clearfix'>"
    article = article + "<dl class='profile clearfix'>"
    article = article + "<dt> 名前 </dt>"
    article = article + "<dd> #{user.name}(#{user.nick_name}) </dd>"
    article = article + "<dt> 誕生日 </dt>"
    article = article + "<dd> #{user.birthday.strftime('%Y年%m月%d日')}</dd>"
    article = article + "<dt> 血液型 </dt>"
    article = article + "<dd> #{user.blood_type}型</dd>"
    article = article + "<dt> 生まれた場所 </dt>"
    article = article + "<dd> #{user.birthplace}</dd>"
    article = article + "</dl>"
    article = article + "</div>"
    article = article + "</div>"
    article = article + "</div></div>"

    article = article + "<p>"
    article = article + "Q:#{user.nick_name}さんの性格を教えてください<br>"
    article = article + "A:#{user.ja_profile.character}<br><br>"

    # article = article + "Q:#{user.nick_name}さんの趣味は?<br>"
    # article = article + "A:#{user.ja_profile.hobby}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの特技は?<br>"
    # article = article + "A:#{user.ja_profile.skill}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの休日の過ごし方は?<br>"
    # article = article + "A:#{user.ja_profile.how_to_holiday}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの好きな映画は?<br>"
    # article = article + "A:#{user.ja_profile.like_movie}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの好きな料理は?<br>"
    # article = article + "A:#{user.ja_profile.like_food}<br><br>"
    #
    #
    # article = article + "Q:#{user.nick_name}さんのチャームポイントは?<br>"
    # article = article + "A:#{user.ja_profile.best_feature}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの「ドキッ」とする異性の仕草はなんですか?<br>"
    # article = article + "A:#{user.ja_profile.gesture}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんがもし一目惚れしたらどうアプローチする?<br>"
    # article = article + "A:#{user.ja_profile.how_to_approach}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんはこんな異性に惹かれる?<br>"
    # article = article + "A:#{user.ja_profile.attracted}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの今一番欲しいものは?<br>"
    # article = article + "A:#{user.ja_profile.want}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの今行きたいところは？<br>"
    # article = article + "A:#{user.ja_profile.go}<br><br>"
    #
    # article = article + "Q:#{user.nick_name}さんの夢は？<br>"
    # article = article + "A:#{user.ja_profile.dream}<br><br>"
    #
    # article = article + "Q:ここだけの話を教えてください<br>"
    # article = article + "A:#{user.ja_profile.secret_talk}<br><br>"

    article = article + "キレカワ事務局:#{user.nick_name}さんありがとうございました。<br><br>"

    article = article + "#{user.nick_name}さんにインタビューした内容です。<br>"
    article = article + "#{user.ja_profile.interview}<br><br>"
    article = article + "</p>"
    article = article + "<p>#{user.nick_name}さんをもっと知りたい方は「<a href='/casts/#{user.job_type}/#{user.id}'>こちら</a>」</p>"
    article = article + "<p>他の#{user.change_lang_job_type_at_ja}で働く美女を見たい方は「<a href='/casts/#{user.job_type}'>こちら</a>」</p>"
    return article
  end

  def to_jbuilder
    Jbuilder.new do |json|
      json.id self.id
      json.head_title_ja self.head_title_ja
      json.head_title_vn self.head_title_vn
      json.head_title_en self.head_title_en

      json.head_keyword_ja self.head_keyword_ja
      json.head_keyword_vn self.head_keyword_vn
      json.head_keyword_en self.head_keyword_en

      json.head_description_ja self.head_description_ja
      json.head_description_vn self.head_description_vn
      json.head_description_en self.head_description_en

      json.title_ja self.title_ja
      json.title_vn self.title_vn
      json.title_en self.title_en

      json.article_ja self.article_ja
      json.article_vn self.article_vn
      json.article_en self.article_en

    end
  end

  def self.to_jbuilders(blogs)
    Jbuilder.new do |json|
      json.array! blogs do |blog|
        json.id blog.id
        json.head_title_ja blog.head_title_ja
        json.head_title_vn blog.head_title_vn
        json.head_title_en blog.head_title_en

        json.head_keyword_ja blog.head_keyword_ja
        json.head_keyword_vn blog.head_keyword_vn
        json.head_keyword_en blog.head_keyword_en

        json.head_description_ja blog.head_description_ja
        json.head_description_vn blog.head_description_vn
        json.head_description_en blog.head_description_en

        json.title_ja blog.title_ja
        json.title_vn blog.title_vn
        json.title_en blog.title_en

        json.article_ja blog.article_ja
        json.article_vn blog.article_vn
        json.article_en blog.article_en
      end
    end
  end


end
