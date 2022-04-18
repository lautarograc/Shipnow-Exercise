Dependencies:
-----------------------------------------------

Ruby 3.1.0


--------

To run the code, CD into yourclonedrepo/example_console and run the file present there

```$ ruby example_console.rb ```

The console is interactive and has user-friendly instructions, so you shouldn't have trouble using it. To exit the console, just enter a blank input.

-------

Explanation for the project:

It's a simple [data tree](https://en.wikipedia.org/wiki/Tree_structure) representing hierarchical associations originating from an ancestry-less folder (referenced in the code with the name 'root'). Each child (being either a subfolder or a file) knows his immediate parent by saving the ID (or, for code-sake, the 'name') of the selected folder (saved as a working_directory instance) as an attribute, which then allows to loop around a hash-map returning matches by descendence.

-----

Limitations of the code and things to improve:

It's lacking one of the suggested functionalities; user authentication. Suggested implementation would be to just marshal a string for username and password into a txt file and perhaps apply some encryption to it (although it would be a serious challenge to add secure encrypting without using external gems like for example [openssl](https://rubygems.org/gems/openssl))

Exceptions and validations aren't contemplated for now (except for some very basic ones).

Specs haven't been added.

------