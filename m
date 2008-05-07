Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jtaq5-0006aH-EG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 21:01:09 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jtaq3-0003Km-V0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 21:01:09 -0700
Date: Wed, 7 May 2008 00:00:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080507040020.GA15972@c2.user-mode-linux.org>
References: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200805062304.m46N4h6d007206@devserv.devel.redhat.com>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org

On Tue, May 06, 2008 at 07:04:43PM -0400, Ulrich Drepper wrote:
> This patch breaks UML for me on x86-64 running Fedora 8 (gcc 4.1.2):

Two odd things -
    I'm using what appears to be the same environment - F8, gcc 4.1.2
	gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)
and I've seen nothing like this

    --showconfig doesn't work.  This is implemented in
arch/um/kernel/config.c.in (which becomes config.c after some
preprocessing), and as far as I can tell, it's just not in the
binary.  So, I'm wondering whether there's something odd with __used.

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
