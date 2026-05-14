// Anıl Sezgin — CV
// Compiled with: typst compile cv.typ Anil_Sezgin_CV.pdf

#set page(margin: (x: 1.2cm, top: 1.2cm, bottom: 1cm))
#set text(font: "Segoe UI", size: 8.5pt, fill: rgb("#444444"))
#set par(justify: true, leading: 0.5em)

// Colors
#let accent = rgb("#1a5c2a")
#let light-gray = rgb("#888888")

// Helpers
#let section(title) = {
  v(6pt)
  text(10pt, weight: "bold", fill: accent, upper(title))
  v(-5pt)
  line(length: 100%, stroke: 1.2pt + accent)
  v(3pt)
}

#let entry(title, subtitle, date, location) = {
  grid(
    columns: (1fr, auto),
    row-gutter: 1pt,
    text(weight: "bold", size: 9pt, title),
    align(right, text(size: 8pt, fill: light-gray, date)),
    text(fill: accent, size: 8.5pt, weight: "medium", subtitle),
    align(right, text(size: 8pt, fill: light-gray, location)),
  )
}

#let tag(body) = {
  box(
    fill: rgb("#e8f0e8"),
    radius: 3pt,
    inset: (x: 5pt, y: 2.5pt),
    text(size: 7.5pt, weight: "medium", fill: accent, body)
  )
}

#let divider() = {
  v(1pt)
  line(length: 100%, stroke: 0.4pt + rgb("#dddddd"))
  v(1pt)
}

#let items(..args) = {
  list(
    indent: 6pt, body-indent: 4pt, spacing: 3pt,
    marker: text(fill: accent, size: 7pt, "›"),
    ..args,
  )
}

// ── HEADER ──
#align(center)[
  #text(22pt, weight: "bold", fill: rgb("#1a1a1a"))[ANIL SEZGİN]
  #v(-5pt)
  #text(10pt, fill: accent, weight: "medium")[Senior AOSP & BSP Developer]
  #v(1pt)
  #text(8pt, fill: light-gray)[
    #link("mailto:anil.sezgin@outlook.com")[anil.sezgin\@outlook.com] #h(4pt)·#h(4pt) +46 70 549 3309 #h(4pt)·#h(4pt) #link("https://www.linkedin.com/in/anilsezgin/")[linkedin.com/in/anilsezgin] #h(4pt)·#h(4pt) Ankara, Turkey
  ]
]
#v(4pt)
#line(length: 100%, stroke: 0.5pt + rgb("#cccccc"))
#v(2pt)

// ── LEFT + RIGHT COLUMNS via place ──
// Right column is placed absolutely, left column flows normally with a width constraint.

#let right-col-width = 35%
#let gutter = 12pt

// Place the right column
#place(right, dx: 0pt, dy: 0pt,
  block(width: right-col-width)[
    #section("Education")
    #entry("M.S. in Computer Engineering", "Özyeğin University", "2017 — 2019", "")
    #v(4pt)
    #entry([B.S. in EE Engineering], "Middle East Technical University", "2008 — 2013", "")

    #section("Areas of Expertise")
    #tag("Embedded Android (AOSP)")
    #h(2pt)
    #tag("BSP Development")
    #h(2pt)
    #tag("Android Automotive OS")
    #h(2pt)
    #tag("Linux Device Drivers")
    #h(2pt)
    #tag("QNX Hypervisor")
    #h(2pt)
    #tag("Android App Dev")
    #h(2pt)
    #tag("Embedded Linux / Yocto")
    #h(2pt)
    #tag("OTA Update Systems")

    #section("Programming")
    #tag("C")
    #h(2pt)
    #tag("C++")
    #h(2pt)
    #tag("Java")
    #h(2pt)
    #tag("Python")
    #h(2pt)
    #tag("Kotlin")
    #h(2pt)
    #tag("Shell Scripting")
    #h(2pt)
    #tag("OOP")
    #h(2pt)
    #tag("MATLAB")

    #section("Tools & Platforms")
    #tag("Android Studio")
    #h(2pt)
    #tag("Git")
    #h(2pt)
    #tag("Gerrit")
    #h(2pt)
    #tag("JIRA")
    #h(2pt)
    #tag("GDB")
    #h(2pt)
    #tag("ADB")
    #h(2pt)
    #tag("Yocto")
    #h(2pt)
    #tag("Repo Tool")
    #h(2pt)
    #tag("VS Code")
    #h(2pt)
    #tag("Behave / Pytest")

    #section("Languages")
    #tag("Turkish — Native")
    #h(2pt)
    #tag("English — Fluent")

    #section("Honors")
    #entry("65th among 1,600,000", "Univ. Entrance Exam (ÖSS)", "2008", "")

    #section("Projects")
    #items(
      [*Vestel Venus V3 5570* — Smartphone (BSP & AOSP)],
      [*7.85" Tablet PC* — Tablet product line],
      [*THOR Tablet Series* — Multiple variants],
    )
  ]
)

// Left column — constrained width so it doesn't overlap the right column
#block(width: 100% - right-col-width - gutter)[
  #section("Summary")
  Senior software engineer with 13+ years of experience in consumer electronics, defense industry, and automotive. Expert in Embedded Android (AOSP), Board Support Package (BSP) development, and QNX. Proven track record in leading platform-level software development across smartphones, tablets, defense systems, and next-generation automotive infotainment platforms.

  #section("Experience")

  #entry("Lead Software Developer", "HaleyTek AB — BSP", "May 2023 — Present", "Göteborg, Sverige")
  #items(
    [Integration of baselines of various automotive Android and QNX projects.],
    [Customization of Android Automotive OS and QNX for OEM customer needs.],
    [Debugging platform-level issues on both QNX Hypervisor and Android VM.],
    [Writing automated tests using Behave and Pytest frameworks.],
  )

  #divider()
  #entry("Senior Software Engineer", "Aptiv — Advanced Safety / UX", "Nov 2021 — Apr 2023", "Kraków, Polska")
  #items(
    [Development and maintenance of software download applications using Android's Update Engine.],
    [Adaptation of Android OTA package creation to customer-specific software download format.],
    [Debugging platform-level issues on both QNX and Android Virtual Machine.],
  )

  #divider()
  #entry("Senior Researcher", "TÜBİTAK SAGE — Embedded Systems", "Oct 2019 — Sep 2021", "Ankara, Turkey")
  #items(
    [Extension and development of ExoPlayer library for real-time video streaming.],
    [Development of video player applications using GStreamer SDK, H.264 over RTP/RTSP.],
    [Embedded Linux development using Yocto for i.MX 8 based custom HMI boards.],
  )

  #divider()
  #entry("Software Architect", "Vestel Electronics — Mobile Devices", "Dec 2017 — Sep 2019", "Manisa, Turkey")
  #items(
    [Led architectural decisions for Android OS customization on Qualcomm-based smartphones and tablets.],
    [Design, development and integration of system services for manufacturing and OTA updates.],
  )

  #divider()
  #entry("Sr. Software Design Specialist", "Vestel Electronics — Mobile Devices", "Jan 2015 — Dec 2017", "Manisa, Turkey")
  #items(
    [Android OS bring-up on custom boards based on Qualcomm chipsets.],
    [Peripheral bring-ups of display (MIPI-DSI), audio, sensors (I2C, SPI) on Linux Kernel.],
  )

  #divider()
  #entry("Software Design Specialist", "Vestel Electronics — Mobile Devices", "Jan 2014 — Dec 2014", "Manisa, Turkey")
  #items(
    [BSP-level development and integration for tablet and smartphone product lines.],
  )

  #divider()
  #entry("Software Design Engineer", "Vestel Electronics — Mobile Devices", "Dec 2013", "Manisa, Turkey")
  #items(
    [Android platform development and board bring-up for mobile devices.],
  )
]
