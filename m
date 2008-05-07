Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtYnE-0002I6-Tw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 18:50:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtYnC-0002yK-8T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 18:50:04 -0700
Date: Tue, 6 May 2008 21:48:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080507014857.GB14912@c2.user-mode-linux.org>
References: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
	<alpine.LFD.1.10.0805061625090.32269@woody.linux-foundation.org>
	<4820EC0E.1030603@redhat.com>
	<alpine.LFD.1.10.0805061655590.32269@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805061655590.32269@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@redhat.com>, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Tue, May 06, 2008 at 05:06:40PM -0700, Linus Torvalds wrote:
> Some UML person should really take a look. It might be a compiler bug that 
> is triggered by -fno-unit-at-a-time, but considering that x86 is the most 
> tested architecture by far and apparently does *not* hit that problem, it 
> sounds more likely that it's UML-related and the compiler just triggers a 
> bug in UML.
> 
> Anybody?

I think that's likely true.

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
