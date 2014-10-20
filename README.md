Github User Language Evaluator
==============================

This app allow the user to enter the user name of a github user and it will evaluate the most popular language of that user.

The user must enter a name and press the icon to activate the code.

The popular language of the user determined by checking each of the languages that have been assigned by github to each of the users repositories.

There are two exceptions:

1. When the username does not exit on github.
  A message is returned to the user that the username does not exist on github and that they could try again.
2. When username exists on github but they have no repositories.
   This exact case was not tested but simulated using a number instead of 0.  i.e. my user name is enumera and I currently have 13 repositories the correct message was raised when 13 was used instead of 0.

   Andrew Fyfe
