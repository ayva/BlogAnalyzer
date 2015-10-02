class Author < ActiveRecord::Base
include "GrammarCheck"

text = "Frst, make sure that your module is really needed in every class of your application. If it isn't it makes sense to only include it where it is need so as not to bloat the classes that don't need it anyways. If you really want the module everywhere, include look at the class hierarchy of your classes in the app. Do you want the module in all models? You could open ActiveRecord::Base and add add your module there."

check_errors(text)

end
