Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqmgu-0006bh-PP
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 10 Feb 2004 21:13:40 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqmfe-0004Lz-Qe
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 10 Feb 2004 21:12:23 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.44.0402102352330.3217-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Compiling 2.6.3-rc1-mm1 in UML architecture
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
Date: Wed, 11 Feb 2004 00:12:41 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, MOLNAR Ingo <mingo@elte.hu>, William Stearns <wstearns@pobox.com>

Good day, Jeff, Ingo, all,
	Here's number 6713 in my critically acclaimed "Notes from the 
technically illiterate" series of UML endeavours.

	Compiling arch/um/kernel/ptrace.c:13:27 gives the error:
linux/proc_mm.h: no such file or directory.
	Symlinking arch/um/kernel/skas/include/proc_mm.h into 
include/linux makes the error go away.

	Next:
	In file included from arch/um/kernel/syscall_kern.c:22:
arch/um/include/sysdep/syscalls.h:17: conflicting types for 
`sys_ni_syscall'
include/linux/syscalls.h:453: previous declaration of `sys_ni_syscall' .  
UM types it as syscall_handler_t, include/linux types it as 
"asmlinkage long".
	I'm lost on this one.  No idea on how to resolve it.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	Fortune finishes the great quotations, #21

	Shall I compare thee to a Summer day?
	No, I guess not.
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
