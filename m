Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaIP3-0004xx-31 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 14:57:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IaIP2-0003wU-Je
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 14:57:13 -0700
Date: Tue, 25 Sep 2007 17:56:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070925215629.GA10926@c2.user-mode-linux.org>
References: <20070925173713.GA8262@c2.user-mode-linux.org>
	<1190750055.17409.38.camel@chaos>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1190750055.17409.38.camel@chaos>
Subject: Re: [uml-devel] [PATCH] UML - time build fix
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Sep 25, 2007 at 09:54:15PM +0200, Thomas Gleixner wrote:
> On Tue, 2007-09-25 at 13:37 -0400, Jeff Dike wrote:
> > Put back an implementation of timeval_to_ns in
> > arch/um/os-Linux/time.c.  tglx pointed out in his review of tickless
> > support that there was a perfectly good implementation of it in
> > linux/time.h.  The problem is that this is userspace code which can't
> > pull in kernel headers and there doesn't seem to be a libc version.
> 
> Oops. Did not notice. 

It's a UML peculiarity...

> Can't we move it into some header file which is accessible from everywhere ?

Not in the generic kernel.  UML has some generally includable headers
of its own, but that doesn't really help.

The one thing that would help is a libc timeval_to_ns.

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
