Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVByf-0000Be-FC
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 07:46:45 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AVBye-0000Bs-Bf
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 07:46:44 -0800
Message-ID: <03ce01c3c190$edde5c10$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20031213130717.D57E.SBUML-DELETETHISPART@zar.att.ne.jp>
Subject: Re: [uml-devel] demo of SBUML - swsusp functionality for UML
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 Dec 2003 16:34:50 +0100
To: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>, user-mode-linux-devel@lists.sourceforge.net

hey this is GREAT!
i`m currently downloading the whole stuff and give it a try.

> UML.  Eventually it will be announced and hosted at
> sbuml.sourceforge.net
can you explain why it will be hosted as an extra project? i just see it as additional feature for uml - so why somewhat "forking" ?
just independence?

>Potential users might include software
> developers who wish to prepare demos without bothering potential users
> with setup instructions, teachers of programming who want to distribute
> debugging scenarios to students, or software users who would like
> provide detailed bug reports (super core dumps :-) to developers.
and security experts can snapshot infected honeypot UML`s and transfer them
to other experts for analysis :D

regards
roland




----- Original Message ----- 
From: "Richard Potter" <sbuml-deletethispart@zar.att.ne.jp>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Saturday, December 13, 2003 5:07 AM
Subject: [uml-devel] demo of SBUML - swsusp functionality for UML


> Dear UML developers:
>
> We have been working on a type of software suspend and restore for
> UML.  Eventually it will be announced and hosted at
> sbuml.sourceforge.net, however while that site is being prepared, it
> seems appropriate for people on this User-mode-linux-devel mailing
> to have a chance to try out the system in its present form.
>
> If you would like, you can download a demo from:
> http://sbuml.sourceforge.net/demo-for-umldev-list.html
>
> Source code for the scripts is included in the demo.  Source code for
> the binary will be available soon.
>
> SBUML was created to support research in "Computation Scrapbook" based
> programming tools and to support research in model checking.
> (http://hagi.is.s.u-tokyo.ac.jp/members/potter/pubs/) There are also
> potentially many other applications.  However, our short term
> development (and bug fixing) focus will be using SBUML to distribute
> pre-configured runtime state.  Potential users might include software
> developers who wish to prepare demos without bothering potential users
> with setup instructions, teachers of programming who want to distribute
> debugging scenarios to students, or software users who would like
> provide detailed bug reports (super core dumps :-) to developers.
>
> To make this more practical, it should be possible to run SBUML on
> many different distributions of host Linux.  Therefore a high-priority
> task will be to understand exactly what host details SBUML and the
> snapshots depend on.  Hopefully most of these dependencies can be
> removed.  For dependencies that remain, a simple tool should be
> developed so potential users can quickly test if SBUML or a particular
> set of snapshots will work with their host Linux.  At this time, the
> only way to find out is to download the system and give it a try.....
>
> For now, please post questions/comments about SBUML in this
> User-mode-linux-devel mailing list.  If traffic becomes excessive,
> maybe we can move discussions over to a mailing list at
> sbuml.sourceforge.net.
>
> --Richard
>
> The readme.txt file:
>
> This is a quick readme file to give people already familiar with
> User-Mode Linux enough information to play with SBUML a bit.  More
> information, simple manuals, and sample snapshots will be posted
> at http://sbuml.sourceforge.net
>
> What is SBUML?
> ==============
>
> SBUML is an extension to User-mode Linux (UML) for saving and
> restoring UML state in mid-execution. It provides a *computation
> ScrapBook* for UML that can be used to distribute/migrate
> pre-configured runtime state and aid debugging activities.  It can
> be used for swsusp.
>
> It it based on UML version 2.4.18-36, and thus only supports the tt
> mode of UML.  After releasing this demo, the highest priority task
> will be to update SBUML to work with the latest UML kernel.  Only one
> post-2.4.18-26 bug fix has been patched in, which was the that makes
> UML run on RedHat 9.0.
>
> What should be known before running the SBUML demo?
> ===================================================
>
> 1) It requires about 1.5gig to 2.0gig of hard disk space.
> 2) All file changes will be in the demo's "sbumldemo" directory
>    and subdirectories.  Removing this directory tree should uninstall
>    the demo and all side effects, except for a few small files in /tmp.
> 3) It has been run successfully on hosts with RedHat 7.2, 8.0, and 9.0.
>    It is more likely to work if you have vncviewer, curl, xdelta, and
>    nc (netcat) installed, because any library incompatibilities with
>    the binaries included in the demo will be avoided.
> 4) The demo will grab IP addresses on your subnet.  For example, if
>    the host's IP is 192.168.1.90, SBUML will assign restored machines
>    addresses like 192.168.1.22, 192.168.1.23, etc.  (Addresses that
>    respond to pings will automatically be skipped.)  Therefore, the
>    current demo is only suitable for running on a subnet that you own.
>    (This whole scheme needs to be replaced with something more polite and
>    reliable.)
> 5) It runs fine with Linux hosts running inside of VMWare.  Therefore
>    running VMWare's NAT network will avoid most potential problems with
>    item #4.
> 6) The two most essential commands are:
>    1- sbumlhalt -all   #this will clean up all SBUML machines and their directories
>    2- sbuml--kill-all-xterm-linux   # a very aggressive scan of /proc to kill any
>          processes that *seems* to be related to SBUML, because sbumlhalt sometimes
>          misses a few.  If you have any non-SBUML UMLs running, it will probably kill
>          them too.
> 7) A few known bugs that you might run into:
>    1- Only one xterm console window can be saved into a snapshot.
>    2- SIGWINCH has been disabled, so resizing the xterm windows does not work right.
>    3- Xterm state is not saved. (this is an intentional limitation, not a bug)
>    4- Some versions of ping do not support the -w timeout parameter, which hangs
>       the sbumlvnc script.
>    5- The technique used to update /etc/resolv.conf in a UML can be unreliable and
>       needs to be replaced.  Firewall settings on the host can make it fail.
>    6- Failed snapshot downloads are not handled gracefully
>
> How do you download/install it?
> ===============================
>
> SBUML is packed as a demo in 4 files with these or similar names:
> sbuml-core-2.4.18-36um-2sb-b.tarz (800KB)
>   --the specially built UML binary and high-level control scripts.
> sbumldemo-bases.tar.gz (220MB)
>   --backing files for a UML running a small RedHat 7.2 distribution
> sbumldemo-snapshots-120503.tar.gz (65MB)
>   --example snapshots of running UMLs
> sbumldemo-support-bin-redhat72-120503.tar.gz (294KB)
>   --binaries that *might* make it easier for some people to get
>     sbuml working on their Linux Host installation.  The xdelta and
>     vncviewer binaries seem to be quite portable.  curl and nc are more
>     troublesome. (Please tell me if you know how to build a portable
>     curl or nc.)
>
> To install:
> (1) untar all the files.
> (2) cd into the sbumldemo directory
> (3) execute ./sbumlinitdemo
>
> With just a little luck, downloading and untaring can be automated by
> downloading the small file named "sbuml-download-and-install-script-xxxxxxx"
> and typing
> $ source sbuml-download-and-install-script-xxxxxxx
> If you mirror the demo, please be sure to change the download path in this file.
>
> Then just read the short messages carefully.  It will probably ask you
> to execute ./scripts/install_uml_net_as_root in a root shell to give
> uml_net root privileges.  If you want, you can alternatively copy an
> older version of uml_net into the ./scripts directory.  Recently I noticed
> that the latest build of uml_net did not work, but I have not had time
> to find out why.
>
>
> How do you run it quickly?
> ==========================
>
> After you have run ./sbumlinitdemo and have a
> "[(sbumldemo subshell) cur-dir] $" prompt, execute
> the "sbumlquick" command.  You will then get
> something like this:
>
> [(sbumldemo subshell) sbumldemo]$ sbumlquick
> 1) /home/test/doit/sbumldemo/scripts/../snapshots/rh72-32m-f7185deab716119d
> 2) /home/test/doit/sbumldemo/scripts/../snapshots/rh72-32m-vnc-800x600-41ab54e69365d2cc
> 3) /home/test/doit/sbumldemo/scripts/../snapshots/rh72-64m-kde-800x600-2e5a7cfde430c80e
> 4) /home/test/doit/sbumldemo/scripts/../snapshots/rh72-64m-vnc-800x600-d18f29698f8c071c
> 5) /home/test/doit/sbumldemo/scripts/../snapshots/rh72-96m-kde-800x600-a3551ca7e09e2300
> 6) /home/test/doit/sbumldemo/scripts/../snapshots/rh72-96m-vnc-800x600-8e19871e9036a776
> #?
>
> The snapshots in the default snapshot directory are listed.  Enter 1
> (for the "rh72-32m-f7185deab716119d" snapshot) and return and soon (3
> to 30 seconds, certainly within 60 seconds), a new xterm should open
> with a 32meg machine prebooted.  Press return to see the login prompt.
>
> Snapshots with vnc or kde in the name will try to assign an IP
> address and connect vncviewer to a gui in the UML, so these really
> require compatible versions of nc, xdelta, and vncviewer to be on the
> shell path.
>
> The "sbumlhalt -all" should be used to remove the machines.
>
> What other commands are there to play with?
> ===========================================
>
> All the commands are implemented as bash scripts in the ./scripts
> directory, so reading through those may give some clues.  However,
> here are the main ones presented as an example scenario:
>
> [(sbumldemo subshell) sbumldemo]$ sbumlboot m1
>   --This command boots a new machine and call it m1
>   --After the machine boots, log in as root using "root" as the password.
>   --Start some eye candy to make the demo more interesting, e.g. run
>     the "top" command.
> [(sbumldemo subshell) sbumldemo]$ sbumlfreeze m1
>   --This command freezes the top command's updates (and the whole UML)
> [(sbumldemo subshell) sbumldemo]$ sbumlcontinue m1
>   --This command continues the top command's updates (and the whole UML)
> [(sbumldemo subshell) sbumldemo]$ sbumlsave m1 topuml -f -c
>   --This command makes a snapshots of the UML's state and saves it as "topuml"
>   --(The -f means "freeze first", and the -c means "continue after")
> [(sbumldemo subshell) sbumldemo]$ sbumlrestore m2 topuml -c
>   --This command starts another machine called "m2" using the state in topuml.
>   --(The -c means "continue after restoring")
> [(sbumldemo subshell) sbumldemo]$ sbumlrestore m topuml -c
>   --Same as above, only the machine name is chosen automatically to be
>     the first free machine name of the form m followed by some integer.
> [(sbumldemo subshell) sbumldemo]$ sbumlquick topuml
>   --Same as above, just easier to type.
> [(sbumldemo subshell) sbumldemo]$ sbumlquick topuml ; sbumlquick topuml ; sbumlquick topuml ;
>   --Quickly create three more copies...just for the fun of it.
> [(sbumldemo subshell) sbumldemo]$ sbumlhalt m1
>   --This command gets rid of the original UML machine that was booted from scratch
> [(sbumldemo subshell) sbumldemo]$ sbumlhalt -all
>   --This command gets rid of the rest of the running UMLs
> [(sbumldemo subshell) sbumldemo]$ sbuml--kill-all-xterm-linux
>   --This command will kill off any stubborn UML processes that did not
>     listen to sbumlhalt, which should not be many, if any.
>
> How reliable is it?
> ===================
>
> There is really not enough experience or rigorous testing to know yet.
> However, what experience there is indicates that a saved snapshot will
> usually restore into a machine that will continue running successfully.
> Occasionally, a snapshot will not restore.  However, once a snapshot
> has been successfully restored once, it (almost?) always will restore
> successfully every time thereafter.
>
> One conclusion from all this is that if you want to use it for typical
> software suspend and resume functionality (swsusp), make sure you can
> successfully restore the snapshot *before* halting the original machine.
>
> Acknowledgments
> ===============
>
> SBUML was supported in part by a Grant-in-Aid for Precursory Research
> for Embryonic Science and Technology (PRESTO), from Japan Science and
> Technology Agency (JST).  Addition support has been provided by the
> Exploratory Software Project of the Information-technology Promotion
> Agency (IPA).  Study of Jeff Dike's UML code (with all its trampolines
> and other interesting techniques) was done jointly with Osamu Sato and
> Professor Masami Hagiya of Tokyo University.  Important portions of
> the current code were written by Osamu Sato.  Mitsuharu Yamamoto helped
> with testing and provided needed Linux expertise.
>
> Special acknowledgments must be given to Jeff Dike, for creating the
> UML system, and Greg Lonnon, who contributed UML's original
> copy-on-write(COW) feature, which has been essential for making
> snapshots small enough to be practical.
>
> Contact
> =======
>
> Richard Potter
> suml at zar.att.nt.jp
> potter at is.s.u-tokyo.ac.jp
>
> Last edited: 12-12-2003
>
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
