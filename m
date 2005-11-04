Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EY5JP-0006Jn-J7 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 09:25:11 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EY5JL-0002RX-VP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 09:25:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] What's different about building for x86-64?
References: <200511040807.03708.rob@landley.net>
	<20051104160402.GA4379@ccure.user-mode-linux.org>
	<200511040938.35735.rob@landley.net>
In-Reply-To: <200511040938.35735.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041801.33833.blaisorblade@yahoo.it>
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
Date: Fri, 4 Nov 2005 18:01:32 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>

On Friday 04 November 2005 16:38, Rob Landley wrote:
> On Friday 04 November 2005 10:04, Jeff Dike wrote:
> > On Fri, Nov 04, 2005 at 08:07:03AM -0600, Rob Landley wrote:
> > > My build is basically extracting the 2.6.14 tarball, adding the
> > > squashfs patch, and then doing this:
> > >
> > > make ARCH=um O=../linux-build allnoconfig &&
> >
> > I would start with a make defconfig.  This smacks of a mangled
> > configuration.

> Actually, he turned out to be using an older version of my firmware linux
> build script (the one with the 2.6.13.2 kernel, from the website), and the
> problem he was seeing is that building on an x86-64 machine in 32 bit
> emulation mode gets confused.

> Once he started building in 64 bit mode, he got past that, but then hit the
> 3 level page tables leak from 2.6.13 shortly thereafter.

Don't you know that I maintain a kernel tree exactly for this purpose?

The fix is included starting from 2.6.13-bs1. And I've even merged it upstream 
in -stable (even if it was merged in .4 only).

> I sent him a new 
> build script using 2.6.14 and still am waiting to hear back...

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
