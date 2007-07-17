Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IAlC1-0000FD-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 04:26:16 -0700
Received: from nic.netdirect.ca ([216.16.235.2] helo=rubicon.netdirect.ca)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IAlBy-0007Vw-My
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 04:26:13 -0700
Date: Tue, 17 Jul 2007 07:24:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <Pine.LNX.4.64.0707170723170.21802@localhost.localdomain>
MIME-Version: 1.0
Subject: [uml-devel] potentially dead CONFIG variables under arch/um
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@karaya.com>


========== HARDDOG_NOWAYOUT ==========
arch/um/drivers/harddog_kern.c:72:#ifdef CONFIG_HARDDOG_NOWAYOUT
========== PROC_MM ==========
arch/um/kernel/ptrace.c:13:#ifdef CONFIG_PROC_MM
arch/um/kernel/ptrace.c:227:#ifdef CONFIG_PROC_MM
========== TTY_LOG ==========
arch/um/os-Linux/Makefile:15:obj-$(CONFIG_TTY_LOG) += tty_log.o
arch/um/os-Linux/Makefile:16:user-objs-$(CONFIG_TTY_LOG) += tty_log.o
arch/um/kernel/exec.c:34:#ifdef CONFIG_TTY_LOG
arch/um/kernel/exec.c:42:#ifdef CONFIG_TTY_LOG

rday

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
