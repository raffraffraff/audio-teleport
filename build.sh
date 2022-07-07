#!/bin/bash

echo "Create tarball..."
tar czf source.tgz -C source/ usr etc

for output_type in deb rpm; do
	echo "Build ${output_type}..."
	fpm \
		--name audio-teleport \
		--description "Create a PulseAudio playback device, capture its output and stream it to a remote host using flac and mbuffer"
		--depends mpv \
		--depends mbuffer  \
		--input-type tar \
		--output-type ${output_type} \
		--after-install scripts/post-install.sh \
		--before-remove scripts/pre-uninstall.sh \
		--after-remove scripts/post-uninstall.sh \
		source.tgz
done

echo "Cleanup..."
rm source.tgz
