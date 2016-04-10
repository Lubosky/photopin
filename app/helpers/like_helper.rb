module LikeHelper
  def get_likes(post)
    votes = post.votes_for.up.by_type(User)
    users = []
    unless votes.blank?
      votes.voters.each do |voter|
        users.push(link_to voter.username, 'javascript:void(0)', class: 'username')
      end
      users.to_sentence.html_safe + like_plural(votes)
    end
  end

  def is_liked?(post)
    return icon_tag 'heart' if current_user.voted_for? post
    icon_tag 'heart-empty'
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
