class Author < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :hints, through: :posts
  has_many :leaders
  has_many :unique_hints

  def percentage
    Author.where('score < ?', self.score) / Author.count
  end

  def unique_hints
    self.hints.group('title').count
  end

  def total_words
    posts.sum(:word_count)
  end

  def total_errors
    sum = 0
    posts.each do |post|
      sum += post.posthints.count
    end
    sum
  end

  def overall_error_rate
    if (total_words > 0)
      return ( (self.total_errors.to_f / total_words) * 100 ).round(2)
    end
      return 100
    
  end

  def style_errors
    self.hints.where('group_id = ?', 1).count
  end

  def style_error_rate
    ((style_errors.to_f / total_words) * 100).round(2)
  end

  def punctuation_errors
    self.hints.where('group_id = ?', 2).count
  end

  def punctuation_error_rate
    ((punctuation_errors.to_f / total_words) * 100).round(2)
  end

  def spelling_errors
    sum = 0
    posts.each do |post|
      post.posthints.each do |ph|
        sum += 1 if ph.hint.group_id == 3
      end
    end
    sum
  end

  def spelling_error_rate
    ((spelling_errors.to_f / total_words) * 100).round(2)
  end

  def sentence_structure_errors
    sum = 0
    posts.each do |post|
      post.posthints.each do |ph|
        sum += 1 if ph.hint.group_id == 4
      end
    end
    sum
  end

  def sentence_structure_error_rate
    ((sentence_structure_errors.to_f / total_words) * 100).round(2)
  end

  def grammar_errors
    sum = 0
    posts.each do |post|
      post.posthints.each do |ph|
        sum += 1 if ph.hint.group_id == 7
      end
    end
    sum
  end

  def grammar_error_rate
    ((grammar_errors.to_f / total_words) * 100).round(2)
  end

  def self.find_leaders
    style_leader = Leader.where(category: "Style").first
    punctuation_leader = Leader.where(category: "Punctuation").first
    sentence_structure_leader = Leader.where(category: "Structure").first
    grammar_leader = Leader.where(category: "Grammar").first


    # overall_leader = Leader.where(category: "Overall").first
    # overall_leader.author_id = 1
    # overall_leader.score = Author.first.overall_error_rate

    Author.all.each do |author|
      if author.style_error_rate <= style_leader.score && author.total_words > 100
        style_leader.author_id = author.id
        style_leader.score = author.style_error_rate
        style_leader.save
      end
      if author.punctuation_error_rate <= punctuation_leader.score && author.total_words > 100
        punctuation_leader.author_id = author.id
        punctuation_leader.score = author.punctuation_error_rate
        punctuation_leader.save
      end
      # if author.spelling_error_rate < spelling_leader.score && author.total_words > 100
      #   spelling_leader.author_id = author.id
      #   spelling_leader.score = author.spelling_error_rate
      #   spelling_leader.save
      # end
      if author.sentence_structure_error_rate <= sentence_structure_leader.score && author.total_words > 100
        sentence_structure_leader.author_id = author.id
        sentence_structure_leader.score = author.sentence_structure_error_rate
        sentence_structure_leader.save
      end
      if author.grammar_error_rate <= grammar_leader.score && author.total_words > 100
        grammar_leader.author_id = author.id
        grammar_leader.score = author.grammar_error_rate
        grammar_leader.save
      end
      # if author.overall_error_rate < overall_leader.score && author.total_words > 100
      #   overall_leader.author_id = author.id
      #   overall_leader.score = author.overall_error_rate
      #   overall_leader.save
      # end

    end
  end

end
