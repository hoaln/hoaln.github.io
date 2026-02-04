---
layout: single
title: "Building the Future: My Journey in Electric Vehicle Technology"
date: 2026-01-16
published: false
categories:
  - Electric Vehicles
  - Embedded Systems
  - Career
tags:
  - EV Charging
  - ISO 15118
  - V2G
  - Embedded Software
  - AUTOSAR
excerpt: "Insights from 15+ years developing EV charging infrastructure, V2G protocols, and safety-critical embedded systems for the electric mobility revolution."
header:
  teaser: /assets/images/ev-tech-teaser.jpg
  overlay_image: /assets/images/ev-tech-header.jpg
  overlay_filter: 0.5
author_profile: true
read_time: true
comments: true
share: true
related: true
toc: true
toc_label: "Contents"
toc_icon: "bolt"
---

As an embedded software engineer, I've had the privilege of working on some of the most exciting technological transitions of our time—from military communication systems to the burgeoning electric vehicle revolution. Today, I want to share some insights from my journey and what it takes to build reliable, safe, and efficient EV charging infrastructure.

## The E-Mobility Revolution

Vietnam's automotive industry is experiencing a remarkable transformation. When I joined VinFast, I knew I was stepping into something special—a chance to contribute to sustainable transportation from the ground up. The challenge? Building world-class EV charging infrastructure that meets international standards while being robust enough for diverse deployment scenarios.

## From ISO Standards to Real-World Implementation

One of the most fascinating aspects of working on EV charging stations is implementing **ISO 15118** (Vehicle-to-Grid communication) and **ISO 61851** (Electric vehicle conductive charging systems). These aren't just abstract specifications—they're the foundation of safe, interoperable charging infrastructure.

### Key Technical Challenges

**1. Real-Time Communication**
Implementing the V2G protocol stack requires precise timing and state machine management. Every message exchange between the vehicle and charging station must be deterministic and reliable. We use FreeRTOS to ensure real-time performance while managing multiple communication channels (CAN, Ethernet, power line communication).

**2. Safety-Critical Systems**
When dealing with high-voltage DC fast charging (up to 400A at 800V), safety isn't optional—it's paramount. Our firmware implements multiple safety layers:
- Hardware watchdogs
- Redundant voltage/current monitoring
- Emergency shutdown sequences
- Compliance with ISO 26262 functional safety standards

**3. Cloud Integration**
Modern charging stations aren't standalone devices—they're connected IoT systems. We integrate with AWS IoT for:
- Remote monitoring and diagnostics
- Over-the-air firmware updates
- Usage analytics and billing
- Load balancing across charging networks

## Lessons from Building E-Scooter Platforms

Before diving deep into car charging infrastructure, I led firmware development for VinFast's e-scooter lineup. This experience taught me invaluable lessons about:

### Power Management
E-scooters have limited battery capacity, making every milliampere count. We implemented aggressive power management:
- Deep sleep modes for BLE connectivity units
- Dynamic frequency scaling based on workload
- Wake-on-motion using accelerometer interrupts

### User Experience
The engine sound simulator we developed for e-scooters is a perfect example of engineering meeting user experience. Electric vehicles are quiet—too quiet for pedestrian safety. Our solution generates realistic engine sounds that:
- Increase with speed
- Provide auditory feedback to the rider
- Alert pedestrians and other road users

## The Intersection of Hobbies and Engineering

### Marathon Running 🏃
Running marathons has taught me about perseverance and incremental progress—qualities essential in embedded systems development. Debugging a race condition at 3 AM requires the same mental endurance as pushing through kilometer 35 of a marathon.

I've also built custom fitness trackers using Nordic nRF52840, integrating:
- Heart rate monitoring via BLE
- GPS tracking
- Real-time pace calculations
- Data sync to cloud platforms

### Photography 📷
Photography sharpens my attention to detail. Capturing the perfect shot requires understanding light, timing, and composition—skills that translate directly to debugging and system design. I often photograph the hardware I work with, creating documentation that's both technical and visually compelling.

## Looking Ahead

The future of embedded systems in automotive is incredibly exciting:

**1. Vehicle-to-Everything (V2X)**  
Beyond V2G, we're moving toward comprehensive vehicle communication with infrastructure, other vehicles, and the grid itself.

**2. AI at the Edge**  
Machine learning models running directly on embedded processors for predictive maintenance, adaptive charging curves, and user behavior analysis.

**3. Cybersecurity**  
As vehicles become more connected, securing embedded systems against cyber threats becomes critical. Hardware security modules (HSM) and secure boot processes are becoming standard.

## Advice for Aspiring Embedded Engineers

If you're interested in embedded systems and e-mobility:

1. **Master the Fundamentals** - C, real-time operating systems, and hardware interfaces are non-negotiable
2. **Understand Standards** - ISO, SAE, and automotive standards aren't just bureaucracy—they encode decades of engineering wisdom
3. **Build Projects** - Start with Arduino, move to ESP32, then tackle ARM Cortex-M platforms
4. **Never Stop Learning** - Technology evolves rapidly; continuous learning is essential
5. **Balance Work and Life** - Your best debugging insights often come during a run, not at the desk

## Open Invitation

I'm always excited to discuss embedded systems, EV technology, or even marathon training strategies! Feel free to reach out on [LinkedIn](https://linkedin.com/in/hoaln) or via [email](mailto:hoa.luu@vinfast.com).

Let's build the future of sustainable transportation together! 🚗⚡

---

*Have questions about EV charging protocols or embedded systems? Leave a comment below or connect with me on social media!*
