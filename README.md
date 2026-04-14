# Stack-A-Stack

Stack-A-Stack is an iOS arcade stacking game built with Swift and SpriteKit. Players drop randomized block shapes onto a narrow platform, build the tallest stable tower they can, and push their score higher with score multipliers and limited-use power-ups.

## Overview

The project uses a scene-based flow:

- `StartScene` for the title screen and animated background
- `GameScene` for the main stacking gameplay
- `GameOverScene` for score display and replay

Blocks are generated in multiple shapes and sizes, then placed into a live physics world. Score increases as the stack grows, and the multiplier scales upward as more blocks are successfully placed.

## Current Gameplay Features

- Randomized block generation with multiple sprite sizes
- Physics-based stacking built on SpriteKit
- Score tracking and high score persistence with `UserDefaults`
- Multiplier-based scoring as the tower gets taller
- Pause / resume control during gameplay
- Power-up system with support for:
  - platform growth
  - light blocks
  - heavy blocks
  - block deletion
- Bundled image and audio assets for UI and game feedback

## Tech Stack

- Swift
- SpriteKit
- GameplayKit
- Xcode project / workspace for iOS

## Project Structure

```text
Controller/
  Game/        Main gameplay scene logic and UI setup
  GameOver/    Game over scene logic and presentation
  Start/       Start screen logic and animated background
Scenes/        `.sks` scene files
Assets/        Image and sound assets
Utilities/     Shared game state and sprite helpers
StackTheStack/ App entry point, storyboard, plist files
```

## Running The Project

1. Open `StackTheStack.xcworkspace` in Xcode.
2. Select an iOS simulator or connected device.
3. Build and run the `StackTheStack` app.

If the workspace gives you issues, the standalone `StackTheStack.xcodeproj` is also included.

## Notes

- This is a classic SpriteKit-era iOS project and may need small updates for the latest Xcode / iOS SDKs.
- A `GoogleService-Info.plist` file is present in the project, but the current codebase is primarily focused on local gameplay and persistence.
- Some power-up and polish paths are still marked as TODOs in the source.

## Why This Repo Exists

Stack-A-Stack is a compact example of an arcade game loop built with native Apple game frameworks. It is useful as both a playable prototype and a reference for scene transitions, simple game-state persistence, SpriteKit physics, and lightweight power-up systems in Swift.
