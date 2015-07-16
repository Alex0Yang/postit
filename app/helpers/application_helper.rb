module ApplicationHelper
  def fix_url(url)
    url = url.start_with?("http://") ? url : "http://#{url}"
  end

  def fix_date(date)
    date.strftime("%D %r")
  end

  def current_user_post?(post)
    current_user.id == post.user_id
  end
end
