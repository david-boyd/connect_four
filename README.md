# Project Title

Programming Challenge - Connect Four Game.

This is a basic console Connect Four game built in ruby using TDD.

######NOTE: The computer player is dumb, it simply picks a column at random.


### Installing

Before installing the application ensure you have ruby installed.
The application was tested with ruby-2.4.3 


To install the application, cd to the root directory:


If you have not installed bundler:
```
gem install bundler
```

once bundler is installed, run:

```
bundle install
```


## Usage 

To run the game, cd to the root directory:

```
ruby main.rb  
```

## Configuration options

By default the game is configured with: 
* 1 Human Player
* 1 Computer Player
* A 7 by 6 board

However this can be modified in main.rb

```
game = ConnectFour.build
```
can take columns and row as parameters
```
game = ConnectFour.build(COLUMN,ROWS)
```

It's also possible to add two human or two computer players, modify:
```
game.add_player(Human.new("0", prompt))
game.add_player(Computer.new("X", prompt))  
```

e.g for two computer players
```
game.add_player(Computer.new("0", prompt))
game.add_player(Computer.new("X", prompt))  
```