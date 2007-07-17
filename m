Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IApPJ-0000ij-5q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 08:56:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IApPE-00006q-FK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 08:56:12 -0700
Date: Tue, 17 Jul 2007 11:55:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070717155555.GA7965@c2.user-mode-linux.org>
References: <Pine.LNX.4.64.0707170723170.21802@localhost.localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707170723170.21802@localhost.localdomain>
Subject: Re: [uml-devel] potentially dead CONFIG variables under arch/um
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
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Oops, sorry for ignoring your last post...

On Tue, Jul 17, 2007 at 07:24:09AM -0400, Robert P. J. Day wrote:
> 
> ========== HARDDOG_NOWAYOUT ==========
> arch/um/drivers/harddog_kern.c:72:#ifdef CONFIG_HARDDOG_NOWAYOUT

This looks bogus.  There is a WATCHDOG_NOWAYOUT and I think we should
use that instead.

> ========== PROC_MM ==========
> arch/um/kernel/ptrace.c:13:#ifdef CONFIG_PROC_MM
> arch/um/kernel/ptrace.c:227:#ifdef CONFIG_PROC_MM
> ========== TTY_LOG ==========
> arch/um/os-Linux/Makefile:15:obj-$(CONFIG_TTY_LOG) += tty_log.o
> arch/um/os-Linux/Makefile:16:user-objs-$(CONFIG_TTY_LOG) += tty_log.o
> arch/um/kernel/exec.c:34:#ifdef CONFIG_TTY_LOG
> arch/um/kernel/exec.c:42:#ifdef CONFIG_TTY_LOG

These two are used, but in code which is not yet merged.  These
references leaked into mainline by accident.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
