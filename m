Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaIau-0006EE-6s for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 15:09:28 -0700
Received: from www.tglx.de ([213.239.205.147] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaIat-0007yM-OF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 15:09:28 -0700
From: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20070925215629.GA10926@c2.user-mode-linux.org>
References: <20070925173713.GA8262@c2.user-mode-linux.org>
	<1190750055.17409.38.camel@chaos>
	<20070925215629.GA10926@c2.user-mode-linux.org>
Date: Wed, 26 Sep 2007 00:08:47 +0200
Message-Id: <1190758127.17409.81.camel@chaos>
Mime-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff,

On Tue, 2007-09-25 at 17:56 -0400, Jeff Dike wrote:
> On Tue, Sep 25, 2007 at 09:54:15PM +0200, Thomas Gleixner wrote:
> > On Tue, 2007-09-25 at 13:37 -0400, Jeff Dike wrote:
> > > Put back an implementation of timeval_to_ns in
> > > arch/um/os-Linux/time.c.  tglx pointed out in his review of tickless
> > > support that there was a perfectly good implementation of it in
> > > linux/time.h.  The problem is that this is userspace code which can't
> > > pull in kernel headers and there doesn't seem to be a libc version.
> > 
> > Oops. Did not notice. 
> 
> It's a UML peculiarity...
> 
> > Can't we move it into some header file which is accessible from everywhere ?
> 
> Not in the generic kernel.  UML has some generally includable headers
> of its own, but that doesn't really help.
> 
> The one thing that would help is a libc timeval_to_ns.

Fair enough.

	tglx



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
