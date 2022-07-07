# Audio Teleport
Simple client/server for sending audio from one (Linux) host to another.

## How does it work?
Client side: creates a dummy Pulseaudio playback device (sink) and sets it as default. It then records audio, compresses it and streams it to the server.
Server side: uses systemd socket activation to detect incoming audio and start a service to buffer it and play it.

## Why?
After trying various methods to stream audio to a Raspberry Pi connected to my home audio, I found a combination that worked consistently for me. My requirements, in order of importance, were:
1. Consistency: zero gaps, skips, pops, clicks
2. Quality: zero loss of fidelity
3. Latency: as close to zero latency as possible, without compromising #1 or #2

## Result
Consistency is 100% so far
Quality is perfect (lossless compression)
Latency is "not bad". Right now, it ranges from <1s to 6s. 

## TODO
1. Create a simple GUI to start/stop the client, configure it etc
2. Application shortcut (.desktop) to launch the GUI
3. Implement a kludgey 'watcher' that automatically stops the client after 5 minutes of silence
   - record 1s low-quality sample, test it for silence using ffmpeg
   - if it detects silence, increment counter, else reset to 0
   - if counter reaches X, stop the client

# Nitty gritty
## Recording
If you're using PipeWire or Pulseaudio, this should work. You just need to make sure you have the Pulseaudio utils `pactl` (to create the null sink) and `parec` (to record audio)

## Compression
This project uses lossless `flac` compression. Not only is is lossless, but it's the fastest compression I've found. I compared it against the excellent Opus codec, but it added a noticeable delay (several seconds!). 

## Send
Good old netcat!

## Socket listener
On the server side, it uses Systemd socket activation to detect traffic on port 12345. Once audio arrives, Systemd launches a service to play it.

## Buffering / playback
The service that plays audio first buffers it using `mbuffer`. This, in my experience, is the main factor in making the music reliable. Before I added it, I had major issues with reliablilty. There are several options that can be tuned, and I'll make these available through `/etc/audio-teleport` at some point. But right now, it works fine for me!
