#  Plugin

This module provides a basic class that plugin can use to create a bridge between the worker and the plugin.
All events are broadcasted into running plugins, but not backwards.
The worker will start web socket server, the plugin subprocess, and then disconnect.
Plugin is expected to terminate after its web socket disconnect. 
Worker will forcefully terminate it after some timeout if it stays alive.   

```
Main Executable     ----- (web socket) ------->     Plugin
```

## Using `Plugin`

In your `Package.swift`, import the library that has all required APIs to implement a plugin. Please use the matching Emcee version as a tag:

```
dependencies: [
    .package(url: "https://github.com/avito-tech/EmceePluginSupport", .revision("18.0.0"))
]
```

In your plugin target add `EmceePlugin` dependency: 

```
targets: [
    .target(
        name: "MyOwnPlugin",
        dependencies: [
            "EmceePlugin",
            "EmceePluginModels"
        ]
    )
]
```

The main class for plugin is `Plugin`. The most common scenario is (`main.swift`):

```swift
import Foundation
import EmceePlugin
import EmceePluginModels

func main() throws -> Int32 {
    let plugin = try Plugin { (event: PluginAppleTestEvent) in
        // process an event
    }
    plugin.join()
    return 0
}

exit(try main())

```

`Plugin` class will automatically stop streaming events when web socket gets disconnected, allowing `join()` method to return.

## Helpers

You can use `SimulatorVideoRecorder` to capture the video of the simulator. 
You should cancel all ongoing recording after you receive `didRun` event.
