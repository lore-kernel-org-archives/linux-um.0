Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbfW4-0004o8-Cx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 06:41:04 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EbfW2-0005ok-Tk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 06:41:04 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
Message-ID: <20051114153352.GA4303@ccure.user-mode-linux.org>
References: <200511121936.41697.rob@landley.net>
	<20051113193256.GA25736@ccure.user-mode-linux.org>
	<200511132020.01596.blaisorblade@yahoo.it>
	<200511131732.11279.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511131732.11279.rob@landley.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 14 Nov 2005 10:33:52 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Sun, Nov 13, 2005 at 05:32:10PM -0600, Rob Landley wrote:
> On Sunday 13 November 2005 13:20, Blaisorblade wrote:
> > On Sunday 13 November 2005 20:32, Jeff Dike wrote:
> > > On Sat, Nov 12, 2005 at 07:36:41PM -0600, Rob Landley wrote:
> > > > Stub registers -
> > > >         0 - 9090909090909090
> > > >         1 - 9090909090909090
> > > >         2 - 9090909090909090
> > > >         3 - 9090909090909090
> > > >         4 - 9090909090909090
> > > >         5 - 9090909090909090
> > > >         6 - 9090909090909090
> > > >         7 - 9090909090909090
> > > >         8 - 9090909090909090
> > > >         9 - 9090909090909090
> > > >         10 - 0
> > > >         11 - 9090909090909090
> > > >         12 - 9090909090909090
> > > >         13 - 9090909090909090
> > > >         14 - 9090909090909090
> > > >         15 - ffffffffffffffff
> > > >         16 - 9090909090909090
> > > >         17 - 33
> > > >         18 - 292
> > > >         19 - 9090909090909090
> > > >         20 - 2b
> > >
> > > I remain baffled by this.  There is nothing valid there.  At the very
> > > least RSP and RIP should be reasonable, and they're not.
> >

I understand this a bit better.  We have some signal frame corruption going
on.  When there's a signal return, somehow RSP is pointing at all these
no-ops.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
