require 'sinatra'
require 'octokit'

client = Octokit::Client.new \
 
get '/' do

  erb :home

end

post '/' do

  @github_user = params[:github_user]

  #check that the user name is valid and show an message is raised to the user to try again.  Otherwise, get the repo data and find popular language.

  if check_user @github_user

      user = Octokit.user @github_user
      @languages = []
  #Get github user repo data
      @user_repos = user.rels[:repos].get.data

  #Extract the language assigned by github for the repo and push into array languages.

      @user_repos.map do |repo|
        @languages.push(repo.language)
      end

    #remove nil values from the languages array

      @languages.compact!

    # create an array called language_set which has all the unique values returned from github.

      @language_set = @languages.uniq 

    #find the most popular language of the user if a github user exists then
    #a message will be raised to the user that this user has not started coding
    #yet.

    if  @languages.length == 0

        @return_string = "#{@github_user}s has not created any repos !!"

    else

        @popular_language = find_popular_language(@language_set, @languages)

      @return_string = "#{@github_user.capitalize}s most popular language is #{@popular_language}."

    end

  else

  @return_string = "Sorry, that is no user with that github name at the moment.  Try again ?"

end

  erb :home
end


def check_user github_user

    user = Octokit.user github_user

    true

  rescue

    puts "this is an error"

    false

end


def find_popular_language(language_set, repo_languages)

    #initalise variables to be used in the loop

      popular_language = ""
      count = 0


      language_set.each do |language|

        if popular_language == ""
            popular_language = language
            count = repo_languages.count(language)
        else
          if repo_languages.count(language) > count
            popular_language = language
          end
        end
      end

      return popular_language

end
