# Game 2048 ChatGPT AI algorithms Statistics
### We have two AI algorithms for Game 2048: Expectimax and Monte Carlo

| Expectimax AI  |Monte Carlo AI  |
| -------------- | -------------- |
| <img src="https://github.com/BestKora/Game2048ChatGPTStatistics/blob/main/Record%20Expectimax1%20143%20436%20.gif" width="300"/>    | <img src="https://github.com/BestKora/Game2048ChatGPTStatistics/blob/main/Record%20Monte%20Carlo%20Async%2070%20108%20.gif" width="314"/>   |
|  | |

### Write the results of AI algorithms: Expectimax and Monte Carlo - in SwiftData:
These are stochastic algorithms and their results: the maximum value of the tile **maxTile** and the **score** are random variables. It would be desirable to have an experimental distribution of these random variables in the form of histograms in order to choose their optimal parameters.
The Game2048ChatGPT application has been extended to save the results of multiple runs of the algorithms **Expectimax** and **Monte Carlo** in the **SwiftData** database (DB) for subsequent statistical analysis. When writing the code, the **ChatGPT AI** was used as much as possible, which sometimes, breaking all programming stereotypes, offers very original solutions, and this is what helped to get such a concise and readable code for our statistical tasks.

Here is the distribution of the maximum tile value **maxTile** and the **score** for the **Expectimax** algorithm for different weights **zeroWeight**, which is involved in the heuristic evaluation function **evaluate()** of the game board. The **evaluate()** score significantly affects the choice of the next move in the game 2048.
We obtain a similar histogram for the **Monte Carlo** method, but here there are more settings. The main ones are the number of experiments **simulations** and the weight coefficient **zeroWeightMC**, which is multiplied by the number of tiles with a zero value.

