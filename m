Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtaJ9-0003Nq-Cs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 20:27:08 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtaJ5-0004T1-FX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 20:27:06 -0700
Date: Tue, 6 May 2008 23:26:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080507032611.GA15155@c2.user-mode-linux.org>
References: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
	<alpine.LFD.1.10.0805061625090.32269@woody.linux-foundation.org>
	<4820EC0E.1030603@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4820EC0E.1030603@redhat.com>
Subject: Re: [uml-devel] [PATCH] fix UML on x86-64
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
To: Ulrich Drepper <drepper@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Tue, May 06, 2008 at 04:38:54PM -0700, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Linus Torvalds wrote:
> > It breaks things how?
> 
> A crash on startup:

It seems that initcalls from the libc side of the house aren't being
called because they're not in the initcall section.  The one that
matters here is init_syscall_regs in arch/um/os-Linux/skas/mem.c.  If
you run with initcall_debug, you'll notice its absence.  As to why,
and why it depends on -fno-unit-at-a-time, I have no idea.

    	   	   Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
