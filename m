Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TtxoJ-0004HL-0K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 09:55:31 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ttxo3-0005o8-HC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 09:55:30 +0000
Received: from [194.164.232.154] (helo=[10.168.1.34])
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Ttxnu-0006VH-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 09:55:06 +0000
Message-ID: <50F132F9.1030601@bob-the-boat.me.uk>
Date: Sat, 12 Jan 2013 09:55:05 +0000
From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] "Couldn't grant pty"
To: user-mode-linux-devel@lists.sourceforge.net

Maybe someone can help me with this...

I have been trying to tie down an issue that I have with "UML Network
Related Crashing" so that Richard can reproduce my problem.

I am currently trying to use both a 32 bit UML and a 64 bit UML to run
Debian root filesystems, 32 bit and 64 bit respectively.

I am running on a 64 bit machine, with 64 bit kernel incorporating 32
bit compatibility.

The 32 bit environment that I am working in for the compilation of 32
bit UML kernels and running them is a place to which I bind mount /dev,
/sys, /proc to their primary locations; chroot to the top of this
structure; execute 'linux32'; and then work as though I was on a 32 bit
machine.

When I try to run the 32 bit UML kernel with the 32 bit Debian root
filesystem image, it boots to the login prompt, but I can't type
anything at the prompt. The UML kernel is displaying messages:

"Couldn't grant pty - errno = -2"

I have looked into this and I see that this message comes from
'arch/um/os-Linux/tty.c'; due to a non-zero result from
'initial_thread_cb( ... )', which is in 'arch/um/kernel/process.c';
which calls 'initial_thread_cb_skas( ... )', which is in
'arch/um/os-Linux/skas/process.c'.

The structure that contains the original non-zero result is not directly
manipulated, so I can see that this result comes from some different
thread and the working of this is not evident to the uninitiated like
myself.

Clearly, the 32 bit UML kernel must work with the 32 bit Debian
filesystem image for other people.

Therefore there must be something about the environment that I am
working in that causes this problem.

Is this a result of a UML bug that makes it dependent on something
unexpected? Or is it something that I'm doing wrong?

What should "Couldn't grant pty - errno = -2" be telling me?

Regards,
David

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122912
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

