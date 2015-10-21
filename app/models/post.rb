class Post < ActiveRecord::Base
  belongs_to :author
  has_many :posthints, dependent: :destroy
  has_many :hints, through: :posthints, as: :errors

  # Virtual Assosciations

  def self.get_featured_posts
    posts = Post.last(20)
    featured = {}
    featured["style"] = best_style(posts)
    featured["punctuation"] = best_punctuation(posts)
    featured["spelling"] = best_spelling(posts)
    featured["sentence_structure"] = best_sentence_structure(posts)
    featured["grammar"] = best_grammar(posts)
    featured
  end

  def best_style(p)
    posts = p
    posts.sort! {|a, b| (a.style_errors.to_f / a.word_count) <=> (b.style_errors.to_f / b.word_count) }
    posts[0]
  end

  def best_punctuation(p)
    posts = p
    posts.sort! {|a, b| (a.punctuation_errors.to_f / a.word_count) <=> (b.punctuation_errors.to_f / b.word_count) }
    posts[0]
  end

  def best_spelling(p)
    posts = p
    posts.sort! {|a, b| (a.spelling_errors.to_f / a.word_count) <=> (b.spelling_errors.to_f / b.word_count) }
    posts[0]
  end

  def best_sentence_structure(p)
    posts = p
    posts.sort! {|a, b| (a.sentence_structure_errors.to_f / a.word_count) <=> (b.sentence_structure_errors.to_f / b.word_count) }
    posts[0]
  end

  def best_grammar(p)
    posts = p
    posts.sort! {|a, b| (a.grammar_errors.to_f / a.word_count) <=> (b.grammar_errors.to_f / b.word_count) }
    posts[0]
  end

  def errors_per_1000_words
    (hints.count.to_f / word_count).round(3) * 1000
  end

  def style_errors
    self.hints.where(group_id: 1).count
  end

  def punctuation_errors
    self.hints.where(group_id: 2).count
  end

  def spelling_errors
    self.hints.where(group_id: 3).count
  end

  def sentence_structure_errors
    self.hints.where(group_id: 4).count
  end

  def plagarism_errors
    self.hints.where(group_id: 5).count
  end

  def enhancement_errors
    self.hints.where(group_id: 6).count
  end

  def grammar_errors
    self.hints.where(group_id: 7).count
  end

end
