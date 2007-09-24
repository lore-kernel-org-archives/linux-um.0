Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IZu8E-0000ul-33 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 13:02:14 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IZu8B-0001HU-Ct
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 13:02:13 -0700
Date: Mon, 24 Sep 2007 16:01:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070924200127.GB25202@c2.user-mode-linux.org>
References: <20070918233336.GA9746@c2.user-mode-linux.org>
	<20070918170733.c6399124.akpm@linux-foundation.org>
	<200709201757.56298.p.giarrusso@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200709201757.56298.p.giarrusso@gmail.com>
Subject: Re: [uml-devel] [PATCH] UML - Fix irqstack crash
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
To: Paolo Giarrusso <p.giarrusso@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 20, 2007 at 05:57:49PM +0200, Paolo Giarrusso wrote:
> Yes, indeed - or sign extension on 64bit machines would set to 1 the whole 
> high-word.
> 
> But using long for that mask makes no difference; either int or long
> long (or  better, either u32 or u64) should be used, given that the
> used signal range  is the same on 32 and 64bit machines, it should
> be u32 for normal signals or u64 if RT-signals are also allowed.

We don't use RT signals for anything, so we could use u32.  I don't
see it making much difference though.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
