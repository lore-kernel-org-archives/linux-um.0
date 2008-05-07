Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtXC9-00010G-UV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 17:07:41 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtXC8-0000rr-L9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 17:07:41 -0700
Date: Tue, 6 May 2008 17:06:40 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <4820EC0E.1030603@redhat.com>
Message-ID: <alpine.LFD.1.10.0805061655590.32269@woody.linux-foundation.org>
References: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
	<alpine.LFD.1.10.0805061625090.32269@woody.linux-foundation.org>
	<4820EC0E.1030603@redhat.com>
MIME-Version: 1.0
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
Cc: user-mode-linux-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Ingo Molnar <mingo@elte.hu>



On Tue, 6 May 2008, Ulrich Drepper wrote:
> 
> Linus Torvalds wrote:
> > It breaks things how?
> 
> A crash on startup:

Some UML person should really take a look. It might be a compiler bug that 
is triggered by -fno-unit-at-a-time, but considering that x86 is the most 
tested architecture by far and apparently does *not* hit that problem, it 
sounds more likely that it's UML-related and the compiler just triggers a 
bug in UML.

Anybody?

Yes, I'll revert that commit, but just reverting it without somebody 
trying to figure out what is wrong with UML isn't good.

		Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
