Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtYWK-0000ay-M7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 18:32:36 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtYWJ-0006SG-6H
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 18:32:36 -0700
Date: Tue, 6 May 2008 21:31:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080507013135.GA14251@c2.user-mode-linux.org>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org

On Tue, May 06, 2008 at 04:38:54PM -0700, Ulrich Drepper wrote:
> Linus Torvalds wrote:
> > It breaks things how?
> 
> A crash on startup:
> 
> #12 0x0000000060021917 in wait_stub_done (pid=4384) at
> arch/um/os-Linux/skas/process.c:94
> #13 0x00000000600210a0 in do_syscall_stub (mm_idp=0x61f4fd28,
> addr=0x61c1fd18) at arch/um/os-Linux/skas/mem.c:86

Can you send me the binary?  Preferably with symbols?

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
