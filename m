Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EY3eR-0001XE-7M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 07:38:47 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EY3eQ-000796-TT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 07:38:47 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] What's different about building for x86-64?
References: <200511040807.03708.rob@landley.net>
	<20051104160402.GA4379@ccure.user-mode-linux.org>
In-Reply-To: <20051104160402.GA4379@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040938.35735.rob@landley.net>
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
Date: Fri, 4 Nov 2005 09:38:35 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 04 November 2005 10:04, Jeff Dike wrote:
> On Fri, Nov 04, 2005 at 08:07:03AM -0600, Rob Landley wrote:
> > My build is basically extracting the 2.6.14 tarball, adding the squashfs
> > patch, and then doing this:
> >
> > make ARCH=um O=../linux-build allnoconfig &&
>
> I would start with a make defconfig.  This smacks of a mangled
> configuration.

Actually, he turned out to be using an older version of my firmware linux 
build script (the one with the 2.6.13.2 kernel, from the website), and the 
problem he was seeing is that building on an x86-64 machine in 32 bit 
emulation mode gets confused.

Once he started building in 64 bit mode, he got past that, but then hit the 3 
level page tables leak from 2.6.13 shortly thereafter.  I sent him a new 
build script using 2.6.14 and still am waiting to hear back...

Thanks,

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
