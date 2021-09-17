module PostsHelper
  def choose_new
    if action_name == 'new'
      confirm_posts_path
    end
  end
end