class Group::PagesController < Group::BaseController
  def templates
    path = ''
    path = '/' + params[:path1] if params[:path1].present?
    path = path + '/' + params[:path2] if params[:path2].present?
    path = path + '/' + params[:name]
    begin
      render template: "group/tpl#{path}", layout: false
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
    redirect_to action: "login" and return unless group_signed_in?
  end

  def login
    # redirect_to action: 'index'
    if group_signed_in?
      redirect_to action: 'index'
    end
  end

end