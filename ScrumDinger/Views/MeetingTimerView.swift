//
//  MeetingTimerView.swift
//  ScrumDinger
//
//  Created by Furkan Can Baytemur on 6.07.2022.
//

import SwiftUI

struct MeetingTimerView: View {
    let theme: Theme
    let speakers: [ScrumTimer.Speaker]
    let isRecording : Bool
    
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24, antialiased: true)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Billy", isCompleted: true), ScrumTimer.Speaker(name: "Catherine", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(theme: .periwinkle, speakers: speakers, isRecording: true)
    }
}
