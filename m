Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvwcV-0002Xe-1c for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 May 2008 08:40:53 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JvwcR-0004cK-QZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 May 2008 08:40:50 -0700
Date: Tue, 13 May 2008 11:40:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080513154033.GA8867@c2.user-mode-linux.org>
References: <4821B5FC.40307@vulnscan.org>
	<20080509154552.GH10169@c2.user-mode-linux.org>
	<48255FC4.4040805@vulnscan.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48255FC4.4040805@vulnscan.org>
Subject: Re: [uml-devel] umls unresponsive & consuming 100% cpu time
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
To: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, May 10, 2008 at 10:41:40AM +0200, Bram Matthys (Syzop) wrote:
> I also saw this on my console (which does not react either btw), not sure
> when it appeared.. at or very short after/before the time setting:
> Stub registers -
> ~        0 - 621a
> ~        1 - 13
> ~        2 - 621a
> ~        3 - 6215
> ~        4 - 8
> ~        5 - bfae182c
> ~        6 - 0
> ~        7 - 7b
> ~        8 - 7b
> ~        9 - 0
> ~        10 - 0
> ~        11 - ffffffff
> ~        12 - 1000be
> ~        13 - 73
> ~        14 - 200246
> ~        15 - bfae1810
> ~        16 - 7b
> wait_stub_done : failed to wait for SIGTRAP, pid = 26141, n = 26141, errno =
> 0, status = 0x1c7f

For this one, try this patch:

Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2008-04-14 10:44:33.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2008-05-13 11:37:35.000000000 -0400
@@ -55,7 +55,7 @@ static int ptrace_dump_regs(int pid)
  * Signals that are OK to receive in the stub - we'll just continue it.
  * SIGWINCH will happen when UML is inside a detached screen.
  */
-#define STUB_SIG_MASK (1 << SIGVTALRM)
+#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH))
 
 /* Signals that the stub will finish with - anything else is an error */
 #define STUB_DONE_MASK (1 << SIGTRAP)

I doubt it will fix the time problem.  I'm going to chase vincent's
problem on the assusmption that you're seeing the same thing.  When I
figure that out, we'll see how true that is.


> The old 2.6.20.1 uml's react fine when setting time backwards, btw (well..
> within reasonable limits)

UML got its timekeeping redone as part of the tickless work and I'm
still shaking out bugs...

       	    	       Jeff


-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
