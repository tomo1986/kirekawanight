class Blog < ApplicationRecord

  def previous
    Blog.where("id < ?", self.id).first
  end

  def next
    Blog.where("id > ?", self.id).first
  end
  def auto_save_user(user)
      self.subject_id = user.id
      self.article_ja = Blog.make_article_ja_for_user(user)
      self.title_ja = Blog.make_title_ja_for_user(user)
      self.save!

  end

  def self.make_title_ja_for_user(user)
    return "<h2>ベトナムホーチミンの#{user.job_type}の女の子紹介</h2>"
  end

  def self.make_article_ja_for_user(user)
    article = "<p>こんにちわ　kirekaw事務局の鈴木です。\n"
    article = article + "今日もベトナムのホーチミンの夜事情(カラオケ、バー、セクシーな女の子)、夜遊びについて書きます。\n"
    article = article + " 本日ご紹介する女の子は、ベトナムのホーチミンで#{user.job_type}の仕事をしている。#{user.name}さんを紹介します\n\n</p>"
    article = article + "<p>#{user.name}さん今#{user.age}歳でとても可愛い子です。\n"
    article = article + "あなたのチャームポイントはなんですか?と聞くと、\n"
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
