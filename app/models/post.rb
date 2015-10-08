class Post < ActiveRecord::Base
  belongs_to :author
  has_many :posthints
  has_many :hints, through: :posthints, as: :errors

  # Virtual Assosciations

  def errors_per_100_words
    (hints.count.to_f / word_count).round(3) * 100
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
