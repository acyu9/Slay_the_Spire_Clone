# Slay_the_Spire_Clone
 
## Description
This is a tutorial series by Adam(GodotGameLab) that builds a clone of Slay the Spire game using Godot 4.1. Link to the series: https://www.youtube.com/watch?v=ulgh_neTJG8&ab_channel=GodotGameLab. 

## Topics
### Architecture
The project emphasizes on modularity (short code), scalability, and flexibility for easy unit testing. The high-level architecture separates the different functionalities, such as Battle, PlayerHandler, and UI so each component only needs to focus on its responsibilities. The data management utilizes the Godot Resources feature, which in simple terms, are "data containers". 

### Components
1. Characters  
   The warrior character has 3 types of actions - attack, block, and slash. Slash is the AOE attack.
2. Effects  
   Effects of attacking and blocking.
3. Enemies  
   There are 2 types of enemies, crab and bat. Both can perform attack and block actions. Crab has an additional megablock action while the bat can perform two consecutive attacks. The enemy AI has chance-based and conditional settings. 
4. Globals  
   These are settings available to all the nodes in the project via the Godot Autoload feature. The settings include event bus, which has all the signals to notify what is happening in the game, music, sound effect, and the shaker attack effect.
5. Scenes  
   The Battle node is the mastermind that brings the individual pieces together. For example, the player character and the enemy. The Card Target Selector helps the player aims an attack card at the selected enemy with an arc and an arrow. The Card UI utilizes the finite state machine which includes the base state, clicked state, dragging state, aiming state, and released state. These handle all the actions that can be performed with the card. The Enemy handles the enemy actions while the Player handles the player actions. Lastly, the UI contains all the pieces related to UI, such as the red flash effect when player is damaged.
   
