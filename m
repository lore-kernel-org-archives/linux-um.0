Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXQAq-0002DW-K4
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 11:20:32 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXQAq-0000hM-5H
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 11:20:32 -0800
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AXQAn-00057g-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 19 Dec 2003 20:20:29 +0100
From: Jason Lunz <lunz@falooley.org>
Message-ID: <slrnbu6j80.6le.lunz@absolut.localnet>
References: <Pine.LNX.4.58.0312171735540.8123@earth> <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth> <Pine.LNX.4.58.0312172249020.19508@earth> <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth> <Pine.LNX.4.58.0312181514140.7622@earth>
Subject: [uml-devel] new_mm : /proc/mm copy_segments failed, err = 0
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
Date: Fri, 19 Dec 2003 19:09:52 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> the attached patch makes the combo 2.6.0 patch compile for the
> !CONFIG_PROC_MM case. (necessary if forcing TT mode by disabling skas.)
>
> This is also a small cleanup as it moves the architecture-independent
> ptrace functions into the generic kernel/ptrace.c file.
>
> i've also uploaded a new combo patch with the alignment fix plus these
> changes included:
>
>     redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A2

OK, I've complied a 2.6.0 host with this (and only this) -A2 patch for
an SMP pentium III. The host is running debian unstable.

I also compiled a 2.4.23 uml kernel using uml-patch-2.4.22-7.bz2 and the
small ELF_PLAT_INIT fix.

Using a very simple root_fs (it basically only contains a busybox
/bin/sh and a statically compiled /bin/zsh4), the uml boots and detects
skas3 and /proc/mm on the host.

The problem is that on every process fork, I see $Subject appear one or
more times on the console, and subjectively the uml seems to be running
a little slowly. Is this normal?

Jason



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
