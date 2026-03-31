// ============================================================
// Canonical – Lead Linux Kernel Engineer
// Written Interview Template
// ============================================================
// INSTRUÇÕES:
//   - NÃO coloque nome, email ou qualquer dado identificador
//   - Preencha cada resposta abaixo do respectivo comentário
//   - Compile com: typst compile canonical_written_interview.typ
// ============================================================

#set document(title: "Written Interview – Lead Linux Kernel Engineer")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
)
#set text(size: 11pt, lang: "en")
#set par(justify: true, leading: 0.75em)
#show heading.where(level: 1): it => {
  v(1.2em)
  block(
    fill: rgb("#1a1a2e"),
    inset: (x: 10pt, y: 7pt),
    radius: 4pt,
    width: 100%,
    text(fill: white, size: 13pt, weight: "bold", it.body)
  )
  v(0.4em)
}
#show heading.where(level: 2): it => {
  v(0.9em)
  text(size: 11.5pt, weight: "bold", fill: rgb("#1a1a2e"), it.body)
  v(0.1em)
  line(length: 100%, stroke: 0.5pt + rgb("#cccccc"))
  v(0.3em)
}
#show heading.where(level: 3): it => {
  v(0.5em)
  text(size: 10.5pt, weight: "bold", style: "italic", fill: rgb("#333333"), it.body)
  v(0.2em)
}

// ── Cabeçalho ───────────────────────────────────────────────
#align(center)[
  #v(0.5em)
  #text(size: 20pt, weight: "bold")[Written Interview]
  #v(0.3em)
  #text(size: 13pt, fill: rgb("#555555"))[Lead Linux Kernel Engineer – Ubuntu · Canonical]
  #v(0.5em)
  #line(length: 60%, stroke: 1pt + rgb("#1a1a2e"))
  #v(1.5em)
]

// ════════════════════════════════════════════════════════════
= Engineering Experience
// ════════════════════════════════════════════════════════════

== Technical Background

=== Please give a brief description of your technical background.

// ── SUA RESPOSTA ────────────────────────────────────────────
I have a degree in Electrical Engineering, with focus on low-level systems, including firmware, embedded systems and hardware-software integration. Throughout my career, I have worked both in academic and professional contexts developing systems with real constraints of performance, memory and real-time requirements. Professionally, I developed firmware in C/C++ using FreeRTOS for agriculture devices, responsible for data collection and processing via CAN network, ensuring reliable communication between multiple pieces of equipment. In this context, I worked directly with concurrency, memory management and synchronization between tasks. I also developed microservices in Python for geospatial data analysis and map rendering, as well as using the language extensively in mathematical modeling. 

Currently, I am finishing my master’s degree, where I propose a variation of the Memory Polynomial model for digital predistortion of RF amplifiers, with a focus on computational efficiency and feasibility of hardware implementation.

This work involves both high-level modeling in Python and hardware-oriented design using VHDL targeting FPGA implementations, requiring careful consideration of performance, resource constraints, and parallel execution.

I use Arch Linux as my main operating system, which provided me with practical understanding of the inner workings of Linux systems, including package management, troubleshooting and environment configuration. This experience reinforced my interest in working directly with the Linux kernel and low-level systems.
// ────────────────────────────────────────────────────────────


== Leadership & Product Ownership

=== What has been your most senior role in a software engineering organization?

// ── SUA RESPOSTA ────────────────────────────────────────────
Although my most senior official position was junior software engineer, I have worked with a high level of autonomy and technical responsibility over critical components of the system. I was responsible for analyzing performance issues, proposing architectural improvements and leading the complete implementation of solutions, from prototyping to production delivery. A relevant example was the evolution of a map rendering module, where I led technical decisions that directly impacted scalability and user experience. With the transition to remote work, I operated with even more independence, organizing my own workflow and ensuring consistent deliveries without close supervision. In addition to professional experience, I exercised direct leadership in the Tutorial Education Program (PET), where I led teams of up to 5 people for about 3 years, being responsible for work organization, priority definition and technical coordination. I also worked as a monitor in technical disciplines, which strengthened my communication and leadership skills in collaborative environments.
// ────────────────────────────────────────────────────────────

=== What software products have you yourself led which shipped many releases to multiple customers?

// ── SUA RESPOSTA ────────────────────────────────────────────
I was responsible for leading the restructuring of the map rendering system used by companies in the agricultural sector, including major clients such as John Deere, Raízen, and Agris.

The original system had significant performance limitations when handling large volumes of geospatial data, for example, visualizing data from multiple machines over extended periods resulted in long loading times and poor responsiveness in the browser.

I identified the main bottlenecks and designed a new backend architecture based on vector tiles. This included building the data processing pipeline, implementing the rendering logic, and ensuring the system could scale efficiently under high data volume.

I first developed a prototype in Python to validate the approach, and then implemented the production version in C++, focusing on performance and memory efficiency.

As a result, rendering time was reduced from approximately 1 second to 2 milliseconds, significantly improving both scalability and user experience.
// ────────────────────────────────────────────────────────────

=== What is your proudest success as an engineering leader?

// ── SUA RESPOSTA ──────────────────────────────────────────── 
One of the project I am most proud of was the restructuring of the map rendering system, where I was able to transform a critical performance bottleneck into a highly efficient solution, with direct impact on user experience and product viability at scale. I also highlight my performance in the PET3D project during the pandemic, where I led the organization of the production of face shield mask support using 3D printing, coordinating the team and logistics to ensure continuous and efficient operation, resulting in the production of thousands of units destined to hospitals. This experience reinforced my leadership skills in high pressure situations with real impact.
// ────────────────────────────────────────────────────────────

== Linux Distribution Experience

=== Describe any direct involvement with the release of a public Linux distribution.

// ── SUA RESPOSTA ────────────────────────────────────────────
I do not have direct experience in developing or releasing a public Linux distribution. However, I use Arch Linux as my main operating system, which provided me with practical experience with manual installation, system configuration, package management with pacman and use of the AUR ecosystem. This environment requires detailed understanding of the system, resolution of problems and control over dependencies and builds. This experience was fundamental to develop my interest in working more deeply with the Linux kernel and with the ecosystem of distributions.
// ────────────────────────────────────────────────────────────

== Documentation & Quality

=== Describe an experience with a good software documentation process.

// ── SUA RESPOSTA ────────────────────────────────────────────
An experience that strongly influenced my approach was the need to maintain a critical module that had no documentation at all. This made the process slow and error-prone, requiring significant time just to understand how the code worked. From this experience, I started to value much more a two-layer documentation approach:
- External documentation, such as guides and architectural descriptions, that facilitate onboarding and usage.
- Internal documentation in the code, with description of logic and calculations, that facilitates maintenance and evolution.

In later projects, I used tools like doxygen to generate structured documentation from the code, ensuring consistency between implementation and documentation. I believe that good documentation is an essential component of software quality, as it reduces dependency on specific individuals, facilities, maintenance and allows safer evolution of the system.
// ────────────────────────────────────────────────────────────

=== Describe an experience with a good (or poor) software quality process.

// ── SUA RESPOSTA ────────────────────────────────────────────
At the company where I worked, there were basic quality practices, such as the use of GitHub Actions for deployment automation and development of unit tests. However there was no structured code review process, which allowed code to be integrated into production without proper validation. This resulted in low knowledge sharing and increased operational risk, especially in critical modules that were not well understood by the team.

My approach for this scenario would be to structure the quality process based on the following pillars:

- Mandatory code review, as a mechanism not only for validation but for knowledge sharing and technical alignment.

- Robust continuous integration, with execution of automated tests at every commit.

- Clear definition of quality standards, including code guidelines and acceptance criteria.
// ────────────────────────────────────────────────────────────

== Performance & Security

=== Have you ever had to improve the performance of a software system?

// ── SUA RESPOSTA ────────────────────────────────────────────
Yes, a significant example was the restructuring of the map rendering system, where I identified that the map generation process was becoming a critical bottleneck as the data volume increased. The solution involved implementing a new architecture based on vector tiles, prototyping the solution initially in Python to validate the approach and later reimplementing in C++ to maximize performance, which allowed efficient rendering even with large volumes of data. The result was a reduction from 1 second to 2 milliseconds in rendering time, significantly improving user experience and system scalability. This experience reinforced my ability to analyze performance and implement effective solutions to optimize complex systems.
// ────────────────────────────────────────────────────────────

=== Have you ever had to identify and resolve a security exploit?

// ── SUA RESPOSTA ────────────────────────────────────────────
I have not had direct experience with identifying and resolving security exploits in software. In a professional context, I worked with firmware in an industrial environment, where the devices were not exposed to the internet and did not handle sensitive data. In my personal use, I maintain a home server accessed via VPN, which led me to learn and apply basic network security practices. Additionally, I have faced a situation where I accidentally committed a .env file with sensitive API keys. Upon identifying the issue, I revoked and replaced the credentials and removed the information from the commits. I recognize that software security is an area that I am still developing and intend to deepen, especially in the context of kernel engineering.
// ────────────────────────────────────────────────────────────

== Programming Languages

=== C programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
I consider my C/C++ level as intermediate/advanced. I used C extensively during my undergraduate studies in firmware and embedded systems projects, including an IoT automatic lock project with MQTT protocol and firmware development for the mini baja prototype in the SAE Brasil competition. Professionally, I developed firmware for agricultural devices using C/C++, where one of the most relevant experiences was implementing modules based on the AgIsoStack++ library, an open source C++ library based on the ISOBUS/ISO-11783 standard that allowed sending data and communicating with the virtual terminal of agricultural equipment, which required solid knowledge of data structures, pointers, linked lists and memory management. I was also responsible for the map rendering module, where I reimplemented in C++ a solution previously prototyped in Python, reducing rendering time from 1 second to 2 milliseconds.
// ────────────────────────────────────────────────────────────

=== Python programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
I consider my Python skills as advanced, especially in the context of data analysis and rapid prototyping, and I am confident in my ability to apply Python effectively in a variety of contexts, including those that require integration with lower-level systems. I started using Python during my undergraduate studies for complex calculations as an alternative to MATLAB, Over time, I expanded my use of Python to more robust tasks.

During my master's degree, Python became the main language for data analysis and mathematical modeling. I used numpy, scipy and matplotlib for simulation and validation of the digital predistortion model for RF power amplifiers.

During my undergraduate studies, I led the development of a fake news classifier using Python with NLTK for natural language processing, achieving 99% accuracy on validation data.

Professionally, I used pandas and geopandas for geospatial data analysis, and FastAPI for developing microservices and APIs. I also prototyped the map rendering module in Python before reimplementing it in C++, which reduced rendering time from 1 second to 2 milliseconds. In personal projects, I explored libraries like LangChain and CrewAI for experimentation with language agents.
// ────────────────────────────────────────────────────────────

=== Rust programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
I have a basic understanding of Rust, acquired through self-study, with a focus on its ownership model and memory safety guarantees. Although I have not yet used Rust in a professional context, my solid experience with C/C++ allows me to clearly understand the problems that Rust aims to solve, especially related to memory safety and concurrency. I have a direct interest in evolving in this language, especially in low-level applications and systems.
// ────────────────────────────────────────────────────────────

=== Git proficiency

// ── SUA RESPOSTA ────────────────────────────────────────────
I believe my Git proficiency is advanced. I use Git daily for version control in both academic and professional projects, including branch management, conflict resolution, pull requests for code review, and worktrees for parallel branch development. I utilize advanced commands such as rebase, cherry-pick, and bisect for maintaining a clean history and efficient problem-solving.

Beyond software development, Git is an integral part of my personal and academic workflow. My master's thesis and undergraduate monograph were written in open source projects (LaTeX and Typst) with complete versioning in Git, which made the process more organized and secure. I also use Git for expense tracking with Ledger and note organization in Markdown on Obsidian.

This integration of Git into different areas of my daily life reflects not only technical familiarity with the tool, but a genuine culture of versioning and organization.
// ────────────────────────────────────────────────────────────

== Kernel & Embedded Systems

=== Kernel source code development, maintenance, or debugging

// ── SUA RESPOSTA ────────────────────────────────────────────
While I have not yet contributed directly to the Linux kernel source code, I have built a strong foundation in low-level systems through embedded development with FreeRTOS, working extensively with memory management, concurrency, and hardware-software interaction.

In this context, I developed firmware for agricultural devices where I dealt directly with pointers, data structures, task synchronization, and resource-constrained environments. This gave me a practical understanding of how an RTOS manages scheduling, memory, and inter-task communication, even without modifying the kernel itself.

I am currently deepening my knowledge of Linux kernel internals, including studying core subsystems and preparing to contribute in areas such as drivers and system-level performance.

I believe this combination of hands-on embedded experience and focused study provides a strong foundation for working with the Linux kernel, particularly in areas involving hardware interaction and system-level behavior.
// ────────────────────────────────────────────────────────────

=== Embedded system environments

// ── SUA RESPOSTA ────────────────────────────────────────────
I worked extensively with embedded systems throughout my career. During my undergraduate studies, I used devices like Arduino Uno, Nano and ESP8266 in academic projects, including an IoT automatic lock with MQTT protocol. In the SAE Brasil competition, I used the TM4C123GH6PM microcontroller from Texas Instruments (Tiva C Series) for RF telemetry and performance data collection of the vehicle, including dynamometer tests, lateral acceleration in curves and engine temperature.

Professionally, I worked on an embedded device developed and manufactured internally, composed of three ESP32 that communicated with each other via UART bridge on the same board. Two technical challenges were particularly significant:

The first was the synchronization of data between the ESP32 in a single device. The ESP0 generated events that needed to be always updated on the ESP2, which was responsible for communicating with the tractor's virtual terminal via ISOBUS. Any desynchronization resulted in incorrect data displayed to the operator, which required special care in designing the communication between the devices.

The second was a severe memory limitation. The system needed to allow the operator to select manufacturer and model of agricultural machines whose list contained more than 10,000 models. Loading everything into memory was unfeasible, and an implementation with SQLite proved impractical due to query latency. The solution was to store the data in structured binary files and implement binary search, loading only a vector of pre-established size into memory, which solved the problem efficiently within the hardware constraints.
// ────────────────────────────────────────────────────────────

=== Real-time systems (RTOS / Linux RT)

// ── SUA RESPOSTA ────────────────────────────────────────────
I have experience with real-time systems using FreeRTOS in the development of firmware for embedded agricultural devices. I worked with key RTOS features such as tasks, queues, semaphores, mutexes and memory management, in a system with multiple concurrent tasks accessing shared memory.

The main challenge was synchronization between tasks. Data shared between the three ESP32 needed to be always consistent — for example, events generated on the ESP0 needed to be updated on the ESP2, which was responsible for displaying information on the tractor's virtual terminal via ISOBUS. Incorrect use of semaphores in this shared memory resulted in deadlock situations, which required a careful review of the lock acquisition order and the communication architecture between tasks.

I also faced issues with the watchdog — tasks that blocked for excessive time waiting for resources caused system reset. The solution involved reviewing the timeouts for semaphore acquisition and ensuring that no task was indefinitely blocked, adding explicit handling for timeout cases.

I also had to deal with severe memory limitations, which required careful management of resources and optimization of data structures to ensure that the system could operate efficiently within the constraints of the hardware. These experiences gave me a practical understanding of concurrency, synchronization and the inherent challenges of real-time systems with limited resources.

This experience with FreeRTOS and real-time systems in an embedded context provided me with a solid foundation in understanding the principles of real-time operating systems, which I believe will be valuable for working with Linux RT and kernel development, where similar concepts of concurrency, synchronization and resource management are critical.
// ────────────────────────────────────────────────────────────

== Packaging & Firmware

=== Packaging and container formats (Debian, Snap, etc.)

// ── SUA RESPOSTA ────────────────────────────────────────────
I do not have direct experience creating packages in Debian, Snap or similar formats. However, I have practical experience with Docker, creating and configuring Dockerfiles for development and production environments.

A concrete example arose when the project was running in production inside a container with predefined memory and space, but the errors did not reproduce when running directly on my machine. To investigate, I created a Dockerfile that replicated exactly the production environment and mapped the project within the container, which allowed me to debug the C++ code directly in the same environment where the errors occurred.

This way I was able to identify and solve problems that were invisible outside the container, including memory overflow, logic errors and problems in interpreting the received data, all caused by the specific constraints of the production environment. 

This experience showed me the value of reproducible and isolated environments for debugging, and sparked my interest in learning more about package formats like Debian and Snap, especially in the context of Linux distributions.
// ────────────────────────────────────────────────────────────

=== EFI, ACPI and/or DeviceTree experience

// ── SUA RESPOSTA ────────────────────────────────────────────
I do not have professional experience with EFI, ACPI or DeviceTree, but I am studying these technologies on my Arch Linux as part of my preparation for kernel engineering.
// ────────────────────────────────────────────────────────────

== Open Source & Automation

=== Open source projects you have actively participated in

// ── SUA RESPOSTA ────────────────────────────────────────────
My interaction with open source has been primarily through deep usage, integration, and analysis of existing projects, rather than direct upstream contributions so far.

In my professional work, I used and extended the AgIsoStack++ library, an open source implementation of the ISOBUS (ISO-11783) protocol. This required reading and understanding a complex C++ codebase, adapting it to embedded constraints, and integrating it into production systems communicating with agricultural machinery.

Beyond that, I rely extensively on open source tools in my daily workflow, including Arch Linux, Git, and build systems associated with the AUR ecosystem. Working with Arch has exposed me to package definitions, dependency resolution, and build processes, often requiring analysis and modification of PKGBUILDs.

While I have not yet made direct upstream contributions, I am actively moving in that direction. I am currently focusing on deepening my understanding of low-level Linux components with the goal of contributing to projects closer to the kernel and system-level tooling.

I see open source not only as a development model, but as a learning and collaboration environment, and I intend to increase my level of participation over time.
// ────────────────────────────────────────────────────────────

=== CI/CD, workflow engines, and back-end process automation

// ── SUA RESPOSTA ────────────────────────────────────────────
I have practical experience with CI/CD mainly using GitHub Actions, both in professional and personal contexts, with a focus on automating build, testing and artifact generation.

In personal projects, I developed a workflow using GitHub Actions to automate the generation of my resume in English from a Portuguese version written in Typst. With every push to the main branch, the pipeline was automatically executed, compiling the document and generating the final PDF as an artifact. This process eliminated manual steps and ensured consistency between versions, as well as serving as a practical example of automation applied to a simple but recurring flow.

I also used Docker as a complementary tool to ensure environment reproducibility, especially in situations where errors occurred only in production. By creating containers that faithfully replicated the real environment, I was able to integrate this flow into development, facilitating debugging and reducing inconsistencies between environments.

Overall, my experience with CI/CD is more concentrated in continuous integration and automation of build and delivery processes. I recognize that I can still evolve in more complex pipelines, such as multi-layer testing and more robust validations, and this is a point that I am interested in deepening, especially in environments closer to critical systems.
// ────────────────────────────────────────────────────────────

== Machine Learning

=== Experience with machine learning, ANNs, and classification

// ── SUA RESPOSTA ────────────────────────────────────────────
I have practical experience with machine learning mainly in the academic context, with a focus on mathematical modeling, signal processing and classification.

During my graduation, I had a solid foundation in machine learning through specific courses in the area, where I studied fundamental concepts such as artificial neuron models, activation functions and training processes. As part of these studies, I developed a simple controller based on a single neuron using the tanh activation function, where the input parameters were the error, its sum and its derivative, in a way analogous to a PID controller (kp, ki, kd). This experience helped me understand, in a practical way, how neuron-based models can be applied in control problems.

Also during graduation, I led the development of a fake news classifier using Python, applying natural language processing techniques with the NLTK library. The model was trained and validated with a labeled dataset, achieving approximately 99% accuracy on validation data. This project involved everything from data preprocessing to model selection and evaluation.

In my master's degree, my experience is more focused on modeling of nonlinear systems than on direct classification. I developed a variation of the Memory Polynomial model for digital predistortion of RF power amplifiers, using Python for simulation and validation. Although it is not a model based on neural networks, the problem involves parameter tuning from data and performance optimization, concepts close to machine learning.

Overall, my experience with machine learning is more directed towards understanding the fundamentals and practical application in specific problems than towards extensive use of modern frameworks. I have an interest in deepening this knowledge, especially in applications that involve optimization, embedded systems and integration with low-level software.
// ────────────────────────────────────────────────────────────

== Fit for the Role

=== How have your prior experiences prepared you for a downstream kernel role (backporting, packaging, qualification)?

// ── SUA RESPOSTA ────────────────────────────────────────────
My experience has prepared me well for this role due to the consistent exposure to low-level systems, direct integration with hardware and operations under real performance and resource constraints.

I developed firmware in C/C++ with FreeRTOS, dealing directly with memory management, concurrency, synchronization between tasks and communication between devices. This type of environment requires a deterministic and careful approach, very close to the challenges found in the development and maintenance of Linux kernel components. 

In particular, the experience with embedded systems exposed me to classic problems of integration between hardware and software, such as communication via specific protocols, data synchronization between multiple devices and operation under severe memory limitations. These scenarios are analogous to the work of integrating drivers and device support in the kernel, where understanding hardware behavior and software reliability are critical.

Additionally, my performance in performance analysis and optimization, such as in the case of the restructuring of the map rendering system, reinforced my ability to identify bottlenecks, propose architectural solutions and implement significant improvements in existing systems. This type of work is directly applicable to the context of maintenance and evolution of downstream code, where it is often necessary to adapt solutions for different environments and requirements.

Although I do not have direct experience with upstream development of the Linux kernel or with formal backporting processes, I am familiar with the Linux ecosystem through intensive use of Arch Linux, as well as practical experience with reproducible environments using Docker and CI/CD pipelines. This gives me a solid foundation to quickly evolve in tasks related to packaging, integration and software qualification. 

Overall, I believe that my combination of experience in embedded systems, focus on performance, ability to work with real constraints and strong autonomy prepares me well for a role focused on maintenance, integration and evolution of the Linux kernel in a downstream context. I see this opportunity as a natural evolution of my trajectory towards systems even closer to hardware and with greater impact at scale.
// ────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
= Education
// ════════════════════════════════════════════════════════════

== High School

=== Competitive ranking in maths and hard sciences

// ── SUA RESPOSTA ────────────────────────────────────────────
During high school, I performed well in mathematics and physics, which were my areas of greatest interest. I always had an aptitude for logic and problem-solving, especially in mathematics, and in physics I was particularly interested in the more applied parts, such as electricity and systems. This interest directly influenced my decision to pursue Electrical Engineering.
// ────────────────────────────────────────────────────────────

=== Competitive ranking in languages and the arts

// ── SUA RESPOSTA ────────────────────────────────────────────
In languages and arts, my performance was satisfactory, but they were not areas of major interest for me. However, I always maintained a consistent level. English at school was not very strong, so I sought to develop it on my own by taking courses after classes. This effort ended up being important later, especially for reading technical documentation and content in the technology area.
// ────────────────────────────────────────────────────────────

=== What kind of high school student were you? Interests and hobbies?

// ── SUA RESPOSTA ────────────────────────────────────────────
In high school, I was a responsible and committed student, who studied enough to meet my obligations and pass the subjects. Despite this, I always had an awareness of my duty to learning and to my family, which kept me responsible and committed. 

Outside of school, I was quite physically active. I played soccer and went to the gym regularly, which helped me develop discipline and consistency. 

My real desire to learn only really emerged in college. It was when I came into contact with technology and engineering that everything changed. I discovered an area that truly motivated me, and that completely transformed my relationship with study and effort.
// ────────────────────────────────────────────────────────────

== University

=== Which university and degree did you  chose? What others did you consider?

// ── SUA RESPOSTA ────────────────────────────────────────────
I chose Electrical Engineering because I have always been curious to understand how hardware and electrical circuits work. I chose the Federal University of Paraná (UFPR) because it was the best university in my city, with a well-structured electrical engineering program, recognized in the job market, and a faculty with experience in areas of my interest such as embedded systems, signal processing and control. I took the entrance exam exclusively for UFPR, as it was my first and only option. I also considered Mechanical Engineering, which is a very interesting area, but I opted for Electrical Engineering because I identified more with the course at the time of choice.

// ────────────────────────────────────────────────────────────

=== Did you do particularly well in any area of your degree?

// ── SUA RESPOSTA ────────────────────────────────────────────
Yes, to contextualize, the Electrical Engineering course is not very software-focused on the contrary, it focuses almost exclusively on hardware, physics and boolean logic, being the lowest possible level. I performed especially well in the disciplines of Digital Electronics, Firmware and Microelectronics, where I had the opportunity to develop practical projects with microcontrollers, embedded systems and synthesis of logic circuits using VHDL. Additionally, I had good performance in control and signal processing disciplines, which were fundamental for my training and for the development of my master's project. These areas motivated me a lot and gave me a solid foundation for my engineering career, especially in contexts close to hardware.
// ────────────────────────────────────────────────────────────

=== Overall degree result and what it reflects about you

// ── SUA RESPOSTA ────────────────────────────────────────────
My overall result in graduation was a GPA of 0.8466, which I consider an honest reflection of my academic trajectory. During the pandemic we were approximately one year without classes, and when we returned we faced an extremely compressed schedule, six semesters of content condensed into two years.

I opted consciously to take fewer courses per semester instead of keeping up with the accelerated pace, prioritizing the quality of learning over the speed of completion. This resulted in a later graduation, but it allowed me to better assimilate the content and dedicate the last year almost exclusively to my thesis, which was a project of high technical complexity.

I believe this decision reflects my way of approaching learning. I prefer to do less and do it well rather than accumulate superficial approvals. The GPA of 0.8466 reflects this consistency and commitment throughout the course.
// ────────────────────────────────────────────────────────────

=== Exceptional achievements in high school and university

// ── SUA RESPOSTA ────────────────────────────────────────────
In high school, I received the award for outstanding student, granted to students who demonstrated consistent academic improvement over the year, which reflected my commitment to progressively improving.

In university, my most significant achievements were in the SAE Brasil competition with the mini baja team. I was one of the responsible for the electrical part of the vehicle and our team won the trophy for best electrical project in the Southern regional for two consecutive years:
- 1st place in the first year;
- 2nd place in the second year;
- 7th place in the national championship

A significant improvement that reflected the work and evolution of the team.

I also consider my participation in PET during the pandemic exceptional, where I coordinated the production and logistics of printing face shield mask supports donated to hospitals. A concrete delivery with real humanitarian impact at a critical moment.

In BigPET, I led the development of a fake news classifier in Python with NLTK that achieved 99% accuracy on validation data, being my main machine learning project in graduation.
// ────────────────────────────────────────────────────────────

=== Leadership roles during education

// ── SUA RESPOSTA ────────────────────────────────────────────
All my leadership roles were during graduation. In the Tutorial Education Program (PET), I held leadership in two distinct projects for approximately 3 years, coordinating teams of 5 people in each.

In PET3D, during the pandemic, I coordinated the team and logistics of production of supports for face shield masks donated to hospitals, which required scheduling organization to keep 3D printers operating continuously.

In BigPET, I led the development of a fake news classifier using Python and NLTK, achieving 99% accuracy on validation data.

I also worked as a scholarship monitor in the Digital Electronics and Microelectronics courses, teaching online classes during the pandemic and conducting in-person sessions twice a week for classes of more than 10 students.
// ────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
= Context
// ════════════════════════════════════════════════════════════

== Canonical's Mission

=== Your thoughts on Canonical's mission. What is most appealing? What seems risky or unappealing?

// ── SUA RESPOSTA ────────────────────────────────────────────
The Canonical mission to make open source software accessible, reliable and usable at scale is very aligned with how I see technology. My migration to Linux was not just out of technical curiosity, but also because I believe in the value of open and collaborative systems as a basis for innovation.

What stands out the most to me about Canonical is the ability to turn these principles into real production systems. Ubuntu is not just an operating system for desktop, but a platform present in cloud, embedded systems and corporate environments, which demonstrates a high level of maturity and reliability.

I have a particular interest in the work required to ensure stability and performance in such a diverse ecosystem. The integration, validation and maintenance of the Linux kernel for different platforms is a relevant and essential technical challenge for the success of this mission.

In terms of risks, I see the constant challenge of balancing rapid evolution with long-term stability, especially in a more downstream-focused model. Still, I believe that this ability to balance these factors is one of the company's strengths.
// ────────────────────────────────────────────────────────────


== Competitive Landscape

=== Who are Canonical's key competitors, and how should Canonical set about winning?

// ── SUA RESPOSTA ────────────────────────────────────────────
Canonical operates in different segments, each with its own competitive challenges.

In the corporate Linux market, the main competitor is Red Hat, which has a strong presence due to its support model and history in the sector. Canonical, on the other hand, stands out for its agility, strong adoption by developers and integration with cloud platforms.

In the context of cloud, Ubuntu already has a consolidated presence, being frequently used as a standard system in various providers. Maintaining this position depends directly on performance, fast security updates and hardware compatibility.

Regarding general-purpose operating systems, Microsoft still dominates the desktop, but I see Canonical focusing more on enabling developers and infrastructure than directly competing in that segment.

I believe Canonical should continue investing in reliability, speed in delivering security updates and quality in hardware integration. Excellence in kernel maintenance and integration is an important strategic differentiator.
// ────────────────────────────────────────────────────────────


== Motivation

=== Why do you most want to work for Canonical?

// ── SUA RESPOSTA ────────────────────────────────────────────
My main motivation is to work directly with the Linux kernel and with systems engineering at a level closer to hardware. I have a strong interest in contributing at the level where I can have the greatest impact currently, while also continuing to develop myself to take on more advanced responsibilities over time.

Throughout my experience with embedded systems and performance-sensitive applications, I have often worked close to hardware, dealing with memory limitations, concurrency and real-time behavior. This naturally sparked my interest in operating systems, especially the Linux kernel.

What attracts me to Canonical is the opportunity to work with the integration, stability and evolution of the kernel in real systems. Even though it is a role more focused on downstream, I see this as a highly relevant engineering work, as it ensures that complex systems operate reliably in different environments.

Beyond this, I see this position as a natural evolution of my trajectory, allowing me to deepen my knowledge in operating systems while applying my previous experience in embedded systems.
// ────────────────────────────────────────────────────────────

=== What would you most want to change about Canonical?

// ── SUA RESPOSTA ────────────────────────────────────────────
One specific area I would be interested in improving is the documentation and communication around kernel maintenance and integration processes. Given the complexity of the Linux kernel and the diversity of platforms supported, having clear and accessible documentation can help both internal teams and external contributors understand how to effectively work with the kernel in the context of Ubuntu. This could involve more detailed guides on backporting, testing procedures, and best practices for ensuring stability across different hardware configurations.
// ─────────────────────────────────────────────────

=== What gets you most excited about this role?

// ── SUA RESPOSTA ────────────────────────────────────────────
What excites me the most about this role is the combination of technical depth and real-world impact. Working directly with the Linux kernel, even in a downstream context, means contributing to the foundation that millions of people rely on every day, from developers to end users.

I am particularly excited about the RISC-V ecosystem. As a genuinely open and royalty-free architecture, I believe RISC-V has the potential to become the dominant architecture in embedded and domestic computing in the future. Being part of a team that helps establish Ubuntu as a reference on this architecture from an early stage is an opportunity I find genuinely compelling.

Beyond the technical challenges, what motivates me most deeply is contributing to improving the Linux end-user experience and helping make Linux distributions the most popular operating systems in the world. I believe open source is the natural direction of computing collaborative, transparent and accessible to everyone and I want to be part of that transformation.

This role represents the ideal combination of what I value: working close to hardware, contributing to open source at scale, and being part of a mission I genuinely believe in.
// ────────────────────────────────────────────────────────────
