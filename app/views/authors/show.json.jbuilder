

json.(@author, :id, :blog_url, :full_name, :author_pic, :username, :score, :created_at, :updated_at)
json.rating @rating
json.author do

  json.hintstable @hintstable
  json.grammar do
   json.enhancement @author.hints.where('group_id=2').count
   json.grammar @author.hints.where('group_id=4').count
   json.spelling @author.hints.where('group_id=7').count
   json.style @author.hints.where('group_id=6').count
   json.sentenceStructure @author.hints.where('group_id=3').count
   json.plagiarism @author.hints.where('group_id=1').count
   json.punctuation @author.hints.where('group_id=5').count
  end
  json.totalerrors @author.hints.count
  json.totalposts @author.posts.count
  json.totalwords @author.posts.sum(:word_count)
  json.errorsarticle (@author.hints.count.to_f/@author.posts.count).round(2)
  json.errorwords (@author.hints.count.to_f/@author.posts.sum(:word_count)*100).round(2)
end





