/*
 * Copyright (c) Avito Tech LLC
 */

import Foundation
import PathLib
import ProcessController

public final class SimulatorVideoRecorder {
    public enum CodecType: String {
        case h264
        case hevc
    }
    
    private let processControllerProvider: ProcessControllerProvider
    private let simulatorUuid: String
    private let simulatorSetPath: AbsolutePath

    public init(
        processControllerProvider: ProcessControllerProvider,
        simulatorUuid: String,
        simulatorSetPath: AbsolutePath
    ) {
        self.processControllerProvider = processControllerProvider
        self.simulatorUuid = simulatorUuid
        self.simulatorSetPath = simulatorSetPath
    }
    
    public func startRecording(
        codecType: CodecType,
        outputPath: AbsolutePath
    ) throws -> CancellableRecording {
        let processController = try processControllerProvider.createProcessController(
            subprocess: Subprocess(
                arguments: [
                    "/usr/bin/xcrun",
                    "simctl",
                    "--set",
                    simulatorSetPath,
                    "io",
                    simulatorUuid,
                    "recordVideo",
                    "--codec=\(codecType.rawValue)",
                    outputPath
                ]
            )
        )
        try processController.start()

        return CancellableRecordingImpl(
            outputPath: outputPath,
            recordingProcess: processController
        )
    }
}
