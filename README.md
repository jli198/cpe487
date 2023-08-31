# Digital System Design (CPE 487)

![Stevens Logo](stevenslogo.png)

Department of Electrical and Computer Engineering </br>
Fall 2023 </br>
</br>
Instructor: Dr. Bernard Yett </br>
[Canvas Course Address](https://sit.instructure.com/courses/67809) </br>
Class Meeting Location: Burchard 103 </br>
Class Meeting Time: Tuesdays and Thursdays 12:30 - 1:45 </br>
[Contact Info](mailto:byett1@stevens.edu) </br>
Office: EAS Annex 203 </br>
Prerequisite(s): ENGR 245 Circuits and Systems </br>

## COURSE DESCRIPTION

The course focuses on digital system design, modeling, and synthesis using VHSIC (Very High Speed Integrated Circuits) Hardware Description Language (VHDL). The course begins with a review of Boolean logic and binary arithmetic. Students then learn modeling and simulation of digital circuits using behavioral, dataflow, and structural modeling techniques, including the use of VHDL subprograms and operator overloading. This is followed by computer-aided synthesis and implementation, including finite state machines (FSM) and test bench design. Students will use commercial VHDL compilation, simulation, and synthesis tools to evaluate and test their designs. They will also participate in several laboratory sessions in which they develop and test hardware implementations using commercial FPGA evaluation boards.

## STUDENT LEARNING OUTCOMES AND OBJECTIVES

After successful completion of this course, you will be able to...

* Efficiently model a complex digital system as a hierarchy of interconnected components, taking advantage of regularity and component reuse.
* Apply VHDL entity/architecture modeling to represent component inputs and outputs and also internal signals, variables, and operations.
* Develop VHDL models of systems using behavioral, structural, and dataflow concepts to describe the internal behavior and/or structure of the design.
* Develop technical documentation of a complex digital system using hardware description language and schematic representations and to evaluate the correct function and performance based on simulations of system.
* Build VHDL models of complex digital circuits suitable for synthesis where the target platform is an FPGA or ASIC logic library, and understand the limitations of VHDL as a synthesis language and know which particular styles of VHDL coding leads to efficient solutions.
* Use VHDL to design complex sytnhesizable state machines using Mealy and/or Moore architectures.
* Write test vectors for digital system and develop a VHDL test-bench to apply these vectors using file-based input/output operations.
* Represent and document designs, perform simulations, and synthesize implementations using software tools provided by an FPGA vendor.

## COURSE FORMAT AND STRUCTURE

This course is on-campus. To access the course, please [visit](stevens.edu/canvas). For more information about course access or support, contact the Technology Resource and Assistance Center (TRAC) by calling 201-216-5500. </br>
</br>
Course Logistics

* When assignments are due, they are due by 11:59 PM EST on the due date listed in the course schedule.
* Deadlines are an unavoidable part of being a professional, and this course is no exception. Course requirements must be completed and posted or submitted on or before the specified due date and delivery time deadline. Dute dates and delivery time deadlines are in Eastern Time (as used in Hoboken, NJ).
* After the due date, 1 point will be ddeducted per 12 hours that the assignment is late.
* The start of the final class of the semester is the final deadline for all assignments - they will be graded with a maximum of 50 points

Instructor's Online Hours and Office Hours: </br>
Office Hours: 9 AM - 11 AM Tuesday/Wednesday/Thursday </br>
</br>
I will be available via email and respond as soon as I am available (generally within 24 hours if not much sooner). You may also email me for in-person or online appointments. You may also stop by my office - if I am there and not in the middle of something pressing, I am happy to make time for you. </br>
</br>
Zoom link for office hours: </br>
</br>
If it is not possible for you to make it to in-person student hours, the Zoom link will allow for a virtual solution. I will prioritize students there in-person, but should still be able to make time for virtual attendees. </br>
</br>
I am happy to discuss questions related to the homework or other course materials, but also open to talking about school in general, plans after graduation, sports, gaming, etc.

## TENTATIVE COURSE SCHEDULE

I may shift due dates further out, but they will never be sooner than what is listed here. Exact topics/sources are subject to change. I will notify you of any significant changes during in-person course sessions and via email.

Class | Main Topics and Book Sections
 --- | ---
Week 1 | Course Intro + Entrance "Exam"; Chapters 1-3 | Note
Week 2 | Chapters 4-8; Download and install GHDL and GTKWave; One-hot Coding; Gray Code; GHDL Examples: Hello and Half Adder
Week 3 | Chapters 9 - 13; GHDL Examples: Full Adder, D flip-flop, T flip-flop
Week 4 | Appendices A to C; GHDL Examples: 4-to-1 multiplexer and 1-to-4 demultiplxer; Semiconductor device fabrication and electronic design automation (EDA)
Week 5 | Download and install Vivado and cable drivers; FPGA Lab 1 Project 1
Week 6 | No class Tuesday; FPGA Lab 1 Project 1
Week 7 | FPGA Lab 2
Week 8 | FPGA Lab 3
Week 9 | FPGA Lab 6
Week 10 | FPGA Lab 4
Week 11 | FPGA Lab 5
Week 12 | Lab Makeup Period/Project Work
Week 13 | Project Work
Week 14 | Project Work
Week 15 | Project Presentation

Special Dates:
Date | Name/Type/Reason | Note
Sept. 1 | Classes Begin |
Sept. 4 | Labor Day | No Class
Sept. 15 | Last day for Course Withdrawal without W |
Oct. 9 | Fall Recess | No Class
Oct. 10 | MONDAY CLASS SCHEDULE |
Nov. 22 - 26 | Thanksgiving Recess | No class
Dec. 14 | Last Day of Class
Dec. 15 - 22 | Final Exams |

## COURSE MATERIALS

Textbook: **[Free Range VHDL](https://github.com/fabriziotappero/Free-Range-VHDL-book/blob/master/free_range_vhdl.pdf) by Bryan Mealy and Fabrizio Tappero** </br>
Reference:

* Digital Design With An Introduction to the Verilog HDL, VHDL, and SystemVerilog
* "Digital Design and Computer Architecture (ARM)", Sarah Harris and David Harris, 2015. - [Available at](https://dl.acm.org/doi/10.5555/2815529)
* *Design Recipies for FPGAS*

Other Readings or Materials: Will all be made available on Canvas directly.

## COURSE REQUIREMENTS

### Readings

The course schedule sometimes indicates sections from the textbook that should be read **before** coming to class. Doing so will greatly improve your comprehension of the material presented in the lectures. I strongly urge you to stay on schedule with your reading! </br>
</br>

### Exam

* There will be **one** comprehensive final exam in the form of a lab practical. It will cover concepts and programming techniques from the entire class.
* You are allowed four **handwritten** notes sheet for the final exam (one letter size piece of paper, front and back). Preparing these is a very useful study exercise, as it helps you to concisely synthesize and organize the key concept.
* Any additional details necessary to complete problems will be provided.
* Unless otherwise noted, **no online resources may be used** on an exam. Naturally, all tests/exams are to be done **completely individually,** with no consultation or discussion between students. **Cell phones and other devices will be put away for the duration of the exam.**

***"Make-up exams are not given.*** If you cannot take an exam, you must contact me **in advance** of the exam, not afterwards. Failure to notify me prior to the examination will result in an **unexcused absence, and a score of 0.** </br>
</br>
**Cheating on any part of an exam will also result in a score of 0.**

### Attendance and Quizzes

Attendance will primarily be handled via exit "quizzes" intended to serve as Assessments of Learning. They have several useful purposes, including serving as a low-stakes method for you to provide feedback to me, and in turn for me to identify concepts you all may be struggling with in order to address them further during class. These will be issued approximately once a week. Missing 2 or more of these quizzes or failing to thoughtfully answer questions will result in deductions of 5 percent each from the Attendance/Participation grade. Irrelevant or consistently incorrect answers to questions will result in deductions of 5 percenet from the Quiz grade.

## TECHNOLOGY REQUIREMENTS

Baseline technical skills necessary for this course

* Basic computer and web-browsing skills
* Navigating Canvas

Technology skills necessary for this specific course

* Ability to install and use tools such as GHDL, GTKWave, Vivado, etc.

Required Equipment

* Comptuer: current Mac (OS X) or PC (Windows 7+) with high-speed internet connection

## GRADING PROCEDURES

Grades will be based on:

Attendance/Participation | 10 %
Quizzes | 10%
Lab Assignments | 30%
Project | 30%
Final Exam (Comprehensive) | 20%

Letter Grades:

92.5-100 | A
89.5 - 92.49 | A-
86.5 - 89.49 | B+
82.5 - 86.49 | B
79.5 - 82.49 | B-
76.5 - 79.49 | C+
72.5 - 76.49 | C
69.5 - 72.49 | C-
62.5 - 69.49 | D+
59.5 - 62.49 | D
<= 59.49 | F

## Academic Integrity

### Undergraduate Honor System

Enrollment into the undergraduate class of Stevens Institute of Technology signifies a student's commitment to the Honor System. Accordingly, the provisions of the Stevens Honor System apply to all undergraduate students in coursework and Honor Board proceedings. It is the responsibility of each student to become acquainted with and to uphold the ideals set forth in the Honor System Constitution. More information about the Honor System including the constitution, bylaws, investigative procedures, and the penalty matrix can be [found online](http://web.stevens.edu/honor/) </br>
</br>
The following pledge shall be written in full and signed by every student on all submitted work (including, but not limited to, homework, projects, lab reports, code, quizzes and exams) that is assigned by the course instructor. No work shall be graded unless the pledge is written in full and signed.

***“I pledge my honor that I have abided by the Stevens Honor System.”***

### Reporting Honor System Violations

Students who believe a violation of the Honor System has been committed should report it within ten business days of the suspected violation. Students have the option to remain anonymous and can report violations [online](www.stevens.edu/honor).

### Other Policies

* In this class, we will be making use of active learning techniques such as think-pair-share and a flipped classroom, all of which are designed to strengthen your learning and knowledge acquisiton. By working together, we often learn better, develop more sophisticated solutions to problems, and solidify our own understandings. Please come to class ready to collaborate with your peers and be an active participant.
* All students are to abide by the University’s policy on academic honesty. The homework submitted should be your own work and not copied verbatim from other students or from other resources. You are allowed to work together, but you should each contribute and be able to explain the solutions if asked. If you work with others and one or more of you do not understand your solutions, it is your responsibility to ask other students or myself from assistance.
* Many of the materials and readings for this class have copyright protections. They are for your sole educational use and should not be shared, copied, or distrbitued without permission of the instructor or the copyright holder. If you have questions about sharing specific materials outside the course, either with colleagues or the internet, please ask me.
* ChatGPT, Google Bard, other etc. AI tools
  * I'm still learning the best usages for these tools as well
  * "Use these tools to help you understand challenging passages in assigned readings, or to build preliminary foundational knowledge tohelp you understand more difficult concepts. Don't use AI to cheat - use it as a tool to help you learn."
  * I'm not out to painstakingly catch every single usage of AI or other potential sources of cheating, and I will not be using any kind of AI-detection tool. If I notice what looks to me like something that is obviously not your own work, we'll start with a conversation and determine the best route forward from there.

## LEARNING ACCOMODATIONS

Stevens Institute of Technology is dedicated to providing appropriate accommodations to students with documented disabilities. The Office of Disability Services (ODS) works with undergraduate and graduate students with learning disabilities, attention deficit-hyperactivity disorders, physical disabilities, sensory impairments, psychiatric disorders, and other such disabilities in order to help students achieve their academic and personal potential. They facilitate equal access to the educational programs and opportunities offered at Stevens and coordinate reasonable accommodations for eligible students. These services are designed to encourage independence and self-advocacy with support from the ODS staff. The ODS staff will facilitate the provision of accommodations on a case-by-case basis. </br>
</br>
For more information about Disability Services and the process to receive accommodations, [visit](https://www.stevens.edu/student-diversity-and-inclusion/disability-services). If you have any questions please contact: Phillip Gehman, the Director of Disability Services Coordinator at Stevens Institute of Technology at [email](mailto:pgehman@stevens.edu) or by phone: 201.216.3748.

### Disability Services Confidentiality Policy

Student Disability Files are kept separate from academic files and are stored in a secure location within the Office of Disability Services. The Family Educational Rights Privacy Act (FERPA, 20 U.S.C. 1232g; 34CFR, Part 99) regulates disclosure of disability documentation and records maintained by Stevens Disability Services. According to this act, prior written consent by the student is required before our Disability Services office may release disability documentation or records to anyone. An exception is made in unusual circumstances, such as the case of health and safety emergencies.

## INCLUSIVITY

### Name and Pronoun Usage

As this course includes group work and class discussion, it is vitally important for us to create an educational environment of inclusion and mutual respect. This includes the ability for all students to have their chosen gender pronoun(s) and chosen name affirmed. If the class roster does not align with your name and/or pronouns, please inform the instructor of the necessary changes.

### Inclusion Statement

Stevens Institute of Technology believes that diversity and inclusiveness are essential to excellence in academic discourse and innovation. In this class, the perspective of people of all races, ethnicities, gender expressions and gender identities, religions, sexual orientations, disabilities, socioeconomic backgrounds, and nationalities will be respected and viewed as a resource and benefit throughout the semester. Suggestions to further diversify class materials and assignments are encouraged. If any course meetings conflict with your religious events, please do not hesitate to reach out to your instructor to make alternative arrangements. </br>
</br>
You are expected to treat your instructor and all other participants in the course with courtesy and respect. Disrespectful conduct and harassing statements will not be tolerated and may result in disciplinary actions.

## MENTAL HEALTH RESOURCES

Part of being successful in the classroom involves a focus on your whole self, including your mental health.  While you are at Stevens, there are many resources to promote and support mental health.  The Office of Counseling and Psychological Services (CAPS) offers free and confidential services to all enrolled students who are struggling to cope with personal issues (e.g., difficulty adjusting to college or trouble managing stress) or psychological difficulties (e.g., anxiety and depression). Appointments are can be made by phone (201-216-5177).

## EMERGENCY INFORMATION

In the event of an urgent or emergent concern about the safety of yourself or someone else in the Stevens community, please immediately call the Stevens Campus Police at 201-216-5105 or on their emergency line at 201-216-3911.  These phone lines are staffed 24/7, year round.  For students who do not reside near the campus and require emergency support, please contact your local emergency response providers at 911 or via your local police precinct.  Other 24/7 national resources for students dealing with mental health crises include the National Suicide Prevention Lifeline (1-800-273-8255) and the Crisis Text Line (text “Home” to 741-741). If you are concerned about the wellbeing of another Stevens student, and the matter is not urgent or time sensitive, please email the [CARE Team](mailto:care@stevens.edu). A member of the CARE Team will respond to your concern as soon as possible.  

## ADDITIONAL RIGHTS, RESPONSIBILITIES, AND RESOURCES

* Students in this class are encouraged to speak up and participate during class meetings. Because the class will represent a diversity of individual beliefs, backgrounds, and experiences, every member of this class must show respect for every other member of this class. I am firmly committed to diversity and equality in all areas of campus life, and I will work to promote an anti-discriminatory environment where everyone feels safe and welcome. I recognize that discrimination can be direct or indirect and take place at both institutional and personal levels. I believe that such discrimination is unacceptable, and I am committed to providing equality of opportunity for all by eliminating any and all discrimination, harassment, bullying, or victimization. The success of this policy relies on the support and understanding of everyone in this class. We all have a responsibility not to be offensive to each other, or to participate in, or condone harassment or discrimination of any kind.
* Classroom rules:
  * Respect others’ rights to hold opinions and beliefs that differ from your own. Challenge or criticize the idea, not the person.
  * Listen carefully to what others are saying even when you disagree with what is being said. Comments that you make should reflect that you have paid attention to the speaker’s comments.
  * Be courteous. Don’t interrupt or engage in private conversations while others are speaking.
  * Support your statements. Use evidence and provide a rationale for your points.
  * Allow everyone the chance to talk. If you have much to say, try to hold back a bit; if you are hesitant to speak, look for opportunities to contribute to the discussion.
  * If you are offended by something or think someone else might be, speak up and don’t leave it for someone else to have to respond to it.
* Title IX prohibits all forms of gender-based discrimination, including sexual assault and harassment, in federally funded education programs. Title IX reads: “No person in the United States shall, on the basis of sex, be excluded from participation in, be denied the benefits of, or be subjected to discrimination under any education program or activity receiving federal financial assistance.”
* You are encouraged to contact Stevens’s Title IX Coordinator to report any incidents of sexual harassment, sexual violence, domestic/dating violence or stalking. The Title IX coordinator is located on the 2nd floor of the University Center and can be reached at [email](mailto:xruci@stevens.edu) or (201)-216-3383. For more information about Title IX and Stevens’s Sexual Assault Response Team (SART) Sites or policies and procedures regarding sexual, domestic/dating violence and stalking please [visit](https://www.stevens.edu/student-diversity-and-inclusion/title-ix)
* If a student believes they have been discriminated against or harassed, they are encouraged to contact the Office of Diversity, Equity and Inclusion at 201-216-5624, [email](mailto:DEI@stevens.edu), University Center 219, or see [website](https://www.stevens.edu/student-diversity-and-inclusion/office-of-diversity-equity-and-inclusion) for more information.
* The safety of students, faculty, and staff at Stevens is of the utmost importance. Stevens has partnered with RAVE Safety to help you connect with Stevens Campus Police Department in an emergency. Stevens Guardian is a mobile app that turns any cell phone into a personalized protection network. It connects you directly with Stevens Campus Police during an emergency and provides important information instantly. Visit the Stevens Guardian website for instructions regarding downloading the app.

## Disclaimer

This syllabus is intended to give you guidance in what may be covered during the semester and will be followed as closely as possible. However, I reserve the right to modify, supplement and make changes as appropriate, and will update you accordingly.
