Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F9y2B-0001DL-EE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2006 21:19:59 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F9y28-00024r-VZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2006 21:19:59 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0602170009160.4626@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] 2.6.16-rc2 x86_64; Jeff's uml patch tar doesn't apply
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
Date: Fri, 17 Feb 2006 00:19:07 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good evening, all,
 	The uml patch tar file at 
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16-rc2/patches.tar 
should apply to 2.6.16-rc2, but when I try to apply it I get:


==== Applying /usr/src/2.6.16-rc2-patches-20060208/uml-add-tls-support
patching file arch/um/include/os.h
patching file arch/um/kernel/exec_kern.c
patching file arch/um/kernel/process_kern.c
patching file arch/um/kernel/ptrace.c
patching file arch/um/kernel/skas/process_kern.c
patching file arch/um/os-Linux/Makefile
Hunk #2 FAILED at 12.
1 out of 2 hunks FAILED -- saving rejects to file 
arch/um/os-Linux/Makefile.rej
patching file arch/um/os-Linux/tls.c
patching file arch/um/sys-i386/Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/um/sys-i386/Makefile.rej
patching file arch/um/sys-i386/syscalls.c
patching file arch/um/sys-i386/tls.c
patching file arch/um/sys-x86_64/Makefile
Hunk #1 FAILED at 7.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/um/sys-x86_64/Makefile.rej
patching file arch/um/sys-x86_64/tls.c
patching file include/asm-um/desc.h
patching file include/asm-um/processor-i386.h
patching file include/asm-um/processor-x86_64.h
patching file include/asm-um/ptrace-generic.h
patching file include/asm-um/ptrace-i386.h
patching file include/asm-um/ptrace-x86_64.h
patching file include/asm-um/segment.h
Something went wrong with 
/usr/src/2.6.16-rc2-patches-20060208/uml-add-tls-support . Press enter 
when ready to move on.
==== Applying /usr/src/2.6.16-rc2-patches-20060208/fix-struct-compile
can't find file to patch at input line 6
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|# Change a couple of instances of struct modify_ldt_ldt_s to struct 
user_desc.
|Index: linux-2.6.15/arch/um/os-Linux/tls.c
|===================================================================
|--- linux-2.6.15.orig/arch/um/os-Linux/tls.c   2006-02-06 
16:47:11.000000000 -0500
|+++ linux-2.6.15/arch/um/os-Linux/tls.c        2006-02-06 
16:48:21.000000000 -0500
--------------------------
File to patch:


 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	..all in all it's just another rule in the firewall.
 	/Ping Flood/
(Courtesy of Hirling Endre)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
