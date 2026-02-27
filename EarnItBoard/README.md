# EarnIt Board

A lightweight, privacy-first “earn-it” chore/habit tracker for parents to help kids earn rewards.

## How to Run
- Open `EarnItBoard.xcodeproj` in Xcode 15+ (iOS 17 SDK required).
- Build and run on iPhone or iPad simulator/device.
- Enable iCloud + CloudKit in Xcode project capabilities (default container).

## Data Storage
- Uses SwiftData for local persistence.
- All data is stored on-device and synced to iCloud via CloudKit (no external servers).
- App works offline and syncs when network is available.

## iCloud Sync
- Requires iCloud capability enabled (CloudKit, default container).
- Sync is automatic; local changes appear instantly, remote changes merge when available.
- Last-writer-wins for conflicts.

## Project Structure
- `Models.swift`: SwiftData models (Kid, Task, Reward, Event)
- `ModelContainer.swift`: SwiftData + CloudKit setup
- `EarnItBoardApp.swift`: App entry point
- `AppShell.swift`: TabView, navigation, adaptive layouts
- `Features/`: All feature views (Kids, Tasks, Rewards, Today, History)
- `Components/`: Shared UI components
- `Utils/`: Helpers, extensions

## Accessibility
- Dynamic Type, VoiceOver labels, large tap targets, good contrast
- Works in Light/Dark mode

## Next Features (not implemented)
- Widgets
- Streaks
- Multiple boards/families
- Export/share history
- Subscriptions (no IAP/ads in MVP)

---

MIT License
