Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fey6z-0005rr-LT for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2006 10:41:05 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fey6z-0000Ik-Ol for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2006 10:41:05 -0700
Received: from mail.signal1network.com ([208.176.116.2]
	helo=ucontrol.mobiledns.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fey6y-0002hC-8P
	for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2006 10:41:05 -0700
Received: from ucontrol.mobiledns.com (localhost [127.0.0.1])
	by ucontrol.mobiledns.com (8.13.4/8.13.4/Debian-3sarge1) with ESMTP id
	k4DHeuPY011191 for <User-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 May 2006 13:40:56 -0400
Received: from localhost (pyro@localhost)
	by ucontrol.mobiledns.com (8.13.4/8.13.4/Submit) with ESMTP id
	k4DHenXo011185 for <User-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 May 2006 13:40:56 -0400
From: Steven James <pyro@linuxlabs.com>
Message-ID: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 May 2006 13:40:48 -0400 (EDT)
To: User-mode-linux-devel@lists.sourceforge.net

Greetings,

I have been working on a few experimental system calls using a ptrace
mechanism similar to UML to implement the calls. Naturally this lead me to
look at PTRACE_SYSEMU vs. PTRACE_SYSCALL. Since the extra system calls are
implemented entirely by the ptrace thread it seems a shame to take the
context switch on entry and exit from the call. In some cases, I need to
also implement a few of the standard Linux kernel calls in the ptrace
thread as well, based on parameters of the call (for example, writes to
specific open files).

The patch below for x86_64 implements a scheme where a ptraced system call
is skipped if the ptrace thread sets a return value (in RAX) when it
handles the syscall entry. Otherwise things proceed normally.

A similar change is even easier on i386 since the needed logic is already
in entry.S for SYSEMU.

I chose changing RAX as the trigger since that is otherwise a useless
thing for a tracing thread to do at syscall entry.

G'day,
sjames


||||| |||| |||||||||||||  |||
by Linux Labs International, Inc.
   Steven James, CTO

55 Marietta Street
Suite 1830
Atlanta, Ga 30303
866 824 9737 support



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
