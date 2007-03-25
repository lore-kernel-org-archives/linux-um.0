Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HVHZH-0008RX-A1 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Mar 2007 18:30:47 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HVHZF-0002hr-Pw
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Mar 2007 18:30:47 -0700
Date: Sat, 24 Mar 2007 21:27:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070325012758.GA8260@c2.user-mode-linux.org>
References: <1174764836.15059.6.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1174764836.15059.6.camel@athena.fprintf.net>
Subject: Re: [uml-devel] missing asm/user.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Daniel Gryniewicz <dang@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 24, 2007 at 03:33:56PM -0400, Daniel Gryniewicz wrote:
> In their infinite wisdom, the Gentoo kernel team has decided to not ship
> asm/user.h with the kernel headers package anymore.  Since UML (even, as
> far as I can tell, in the most recent versions) uses this in several
> places, is there a way around this?  Are there plans to remove this
> need, or to use the ones from the UML kernel tree, or something?

This came up on IRC a week or so ago, but the conclusion then was that
this was a botch on their part since other distro headers still
included it, and became unusable as a result.

BTW, several of the occurrences are in kernelspace files, which aren't
affected by distro libc burps.

I have a patch ready in case this is for real, attached below.  It
takes care of the i386 side of things - there's an x86_64 include
which I ignored for now.

Do you believe that this is going to be permanent, or just a gyration
in the Gentoo kernel package?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.21-mm/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/user-offsets.c	2007-03-23 15:05:29.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/user-offsets.c	2007-03-24 21:18:44.000000000 -0400
@@ -1,7 +1,7 @@
 #include <stdio.h>
 #include <signal.h>
 #include <asm/ptrace.h>
-#include <asm/user.h>
+#include <asm/elf.h>
 #include <stddef.h>
 #include <sys/poll.h>
 
Index: linux-2.6.21-mm/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/ptrace_user.c	2007-03-24 21:18:44.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/ptrace_user.c	2007-03-24 21:20:44.000000000 -0400
@@ -8,8 +8,6 @@
 #include <errno.h>
 #include <unistd.h>
 #include "ptrace_user.h"
-/* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
-#include <asm/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
 #include "user.h"

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
