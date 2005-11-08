Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZXjx-0002eE-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 09:58:37 -0800
Received: from waste.org ([216.27.176.166])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZXjw-0006cP-V3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 09:58:38 -0800
From: Matt Mackall <mpm@selenic.com>
Message-ID: <20051108175800.GB8126@waste.org>
References: <200510300624.38794.rob@landley.net>
	<35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com>
	<20051030151506.GA3354@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030151506.GA3354@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: What's wrong with tmpfs?
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
Date: Tue, 8 Nov 2005 09:58:00 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: jonathan@jonmasters.org, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 30, 2005 at 10:15:06AM -0500, Jeff Dike wrote:
> On Sun, Oct 30, 2005 at 12:53:00PM +0000, Jon Masters wrote:
> > On 10/30/05, Rob Landley <rob@landley.net> wrote:
> > 
> > > If somebody needs a reproduction sequence, I'm happy to oblige.  In theory
> > > "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it
> > > wouldn't have shipped...
> > 
> > I don't see this behaviour on a regular desktop box running 2.6.14.
> > Guess it's UML specific.
> 
> Sorry, but wrong.
> 
> IIRC, this triggers when you don't have CONFIG_TMPFS enabled.  If you don't,
> you still get it, but you get a version that's only usable in-kernel.

That sounds like a regression. Turning off CONFIG_TMPFS replaces tmpfs
with an aliased ramfs. It should be perfectly usable everywhere that
tmpfs is, with the exception that it's not swap-backed and doesn't
have an size limiting.

-- 
Mathematics is the supreme nostalgia of our time.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
