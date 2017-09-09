module UsersHelper
  def get_gravatar_of(user, size: 200)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "user_icon")
  end

  def knowledges_par_words(user)
    words = user.words.count
    knowledges = user.words.with_knowledges.pluck(:id).count
    "#{knowledges} / #{words}"
  end

  def average_understanding(user)
    knowledges = user.words.select("words.id, knowledges.understanding").joins(:knowledges).order("knowledges.understanding DESC").uniq
    understandings = knowledges.map(&:understanding)
    average = (understandings.sum.to_f / understandings.size).round(1)
    average.nan? ? 0 : average
  end
end
