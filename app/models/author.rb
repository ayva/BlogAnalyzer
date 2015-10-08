class Author < ActiveRecord::Base
  has_many :posts
  has_many :hints, through: :posts
  has_many :leaders

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
    ( (self.total_errors.to_f / total_words) * 100 ).round(2)
  end

  def style_errors
    sum = 0
    posts.each do |post|
      post.posthints.each do |ph|
        sum += 1 if ph.hint.group_id == 1
      end
    end
    sum
  end

  def style_error_rate
    ((style_errors.to_f / total_words) * 100).round(2)
  end

  def punctuation_errors
    sum = 0
    posts.each do |post|
      post.posthints.each do |ph|
        sum += 1 if ph.hint.group_id == 2
      end
    end
    sum
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

  def find_leaders
    style_leader = Leader.where(category: "style").first
    style_leader.author_id = 1
    style_leader.score = Author.first.style_error_rate

    punctuation_leader = Leader.where(category: "punctuation").first
    punctuation_leader.author_id = 1
    punctuation_leader.score = Author.first.punctuation_error_rate

    spelling_leader = Leader.where(category: "spelling").first
    spelling_leader.author_id = 1
    spelling_leader.score = Author.first.spelling_error_rate

    sentence_structure_leader = Leader.where(category: "sentence_structure").first
    sentence_structure_leader.author_id = 1
    sentence_structure_leader.score = Author.first.sentence_structure_error_rate

    grammar_leader = Leader.where(category: "grammar").first
    grammar_leader.author_id = 1
    grammar_leader.score = Author.first.grammar_error_rate

    overall_leader = Leader.where(category: "overall").first
    overall_leader.author_id = 1
    overall_leader.score = Author.first.overall_error_rate

    Author.all.each do |author|
      if author.style_error_rate < style_leader.score && author.total_words > 100
        style_leader.author_id = author.id
        style_leader.score = author.style_error_rate
        style_leader.save
      end
      if author.punctuation_error_rate < punctuation_leader.score && author.total_words > 100
        punctuation_leader.author_id = author.id
        punctuation_leader.score = author.punctuation_error_rate
        punctuation_leader.save
      end
      if author.spelling_error_rate < spelling_leader.score && author.total_words > 100
        spelling_leader.author_id = author.id
        spelling_leader.score = author.spelling_error_rate
        spelling_leader.save
      end
      if author.sentence_structure_error_rate < sentence_structure_leader.score && author.total_words > 100
        sentence_structure_leader.author_id = author.id
        sentence_structure_leader.score = author.sentence_structure_error_rate
        sentence_structure_leader.save
      end
      if author.grammar_error_rate < grammar_leader.score && author.total_words > 100
        grammar_leader.author_id = author.id
        grammar_leader.score = author.grammar_error_rate
        grammar_leader.save
      end
      if author.overall_error_rate < overall_leader.score && author.total_words > 100
        overall_leader.author_id = author.id
        overall_leader.score = author.overall_error_rate
        overall_leader.save
      end

    end
  end

end
