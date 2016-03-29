# DQN-MazeBase
Original DeepMind Deep Q-Network code integrated with Facebook MazeBase environment.

What?
-----
Takes DQN agent from [Deepmind-Atari-Deep-Q-Learner](https://github.com/kuz/DeepMind-Atari-Deep-Q-Learner) and MazeBase environment from [Facebook MazeBase](https://github.com/facebook/MazeBase). Instead of using [alewrap](https://github.com/deepmind/alewrap) to interface with the Atari environment, we create a wrapper (mbwrap) to interface with MazeBase.

Why?
----
Facebook's MazeBase allows for building simple, custom 2D games inside which you can train neural network models to perform tasks. In addition to various toy games, MazeBase also includes a variety of neural models, including convolutional network and memory network, but these are trained via policy gradient. By integrating DQN code with MazeBase, we can additionally train Q-network models with deep Q-learning on MazeBase environments.
