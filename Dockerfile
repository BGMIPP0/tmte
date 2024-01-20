# Use the official Ubuntu 20.04 LTS base image
FROM ubuntu:20.04

# Set environment variables
ENV TERM=xterm-256color

# Update the package lists and install basic dependencies
RUN apt-get update && apt-get install -y \
    bash \
    tmate \
    expect

# Clean up unnecessary files to reduce the image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the resolution (adjust as needed)
RUN xrandr -s 1280x1024

# Set up additional configuration based on the system information
# (Note: The following lines are placeholders and may need modification)
RUN echo "Host: Z10PA-U8 Series" >> /etc/system-info
RUN echo "Kernel: 6.1.0-13-amd64" >> /etc/system-info
RUN echo "CPU: Intel Xeon E5-1650 v3 (12) @ 3." >> /etc/system-info
RUN echo "Memory: 147058MiB / 257626MiB" >> /etc/system-info

# Create an expect script to interact with tmate and press 'q'
RUN echo -e '#!/usr/bin/expect\nspawn tmate\nexpect "tmate"\nsend "q"\ninteract' > /usr/local/bin/start_tmate
RUN chmod +x /usr/local/bin/start_tmate

# Run the expect script when the container starts
CMD ["/usr/local/bin/start_tmate"]
