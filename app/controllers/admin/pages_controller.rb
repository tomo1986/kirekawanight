class Admin::PagesController < Admin::BaseController
  def templates
    path = ''
    path = '/' + params[:path1] if params[:path1].present?
    path = path + '/' + params[:path2] if params[:path2].present?
    path = path + '/' + params[:name]
    begin
      render template: "admin/tpl#{path}", layout: false
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
    redirect_to action: "prints" if request.path == '/admin/invoices/prints'
    redirect_to action: "login" and return unless admin_signed_in?
  end

  def login
    # redirect_to action: 'index'
    if admin_signed_in?
      redirect_to action: 'index'
    end
  end

  def sign_in_on
    redirect_to action: "index" and return if admin_user_signed_in?
    # redirect_to action: 'index' and return if admin_user_signed_in?
    # set_meta_tags :title => 'login'
  end

  def change_pass_with_reset
    redirect_to action: "index" and return if params[:token].nil?

    admin_user = User.where(reset_password_token: params[:token]).first
    redirect_to action: "index" and return if admin_user.nil?

    sign_in('admin_user', admin_user)
    admin_user.update(reset_password_token: nil, reset_password_sent_at: nil)

    redirect_to action: "new_password"
  end

  def prints
  end

  def new_password
    redirect_to action: "sign_in" and return unless admin_user_signed_in?
  end

end