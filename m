Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds683-0008Cx-DB	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:47:55 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds681-0000zF-W4	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:47:55 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507112355.05642.blaisorblade@yahoo.it>
Subject: [uml-devel] Big SKAS3 bug found with 2.6/CONFIG_REGPARM - please
	upgrade
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
Date: Mon, 11 Jul 2005 23:55:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

I've worked during this weekend to diagnose the problem I reported earlier, in 
the thread " Please test 2.6.13-rc2 in TT mode! Big problem with syscall 
parameters clobbering".

It can affect an application when these conditions are verified:
*) the host is running a 2.6 kernel with SKAS patch and is compiled with 
CONFIG_REGPARM
*) it is calling sys_mmap2, old_mmap, sys_mprotect or sys_modify_ldt
*) the call happens via int 0x80
*) on return, the application relies on the values stored in registers 
(actually on some specific registers, depending on the exact situation).

Condition 3 means that a dynamically linked app with NPTL glibc won't incur in 
this problem, nor will statically linked app compiled on NPTL-only distros.

I've tested 2.6.9-V7, 2.6.11-V8/-V9-pre4 and 2.6.12-V8/-V9-pre4, all with 
CONFIG_REGPARM enabled, and compiled with gcc 3.3.4, and they all show this 
bug. Analysis with CONFIG_REGPARM disabled show that the problem won't happen.

Probably gcc 3.4 triggers it as well; the buggy code is present 
unchanged even in SKAS3-V1 against 2.6.3, although maybe it wouldn't be 
triggered by such an old kernel (because CONFIG_REGPARM wasn't present IIRC).

The solution, for user, is to upgrade to SKAS3-V8.2, or to SKAS3-v9-pre7 
(which is still to consider as *experimental*).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
