Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1De2DF-0004tC-2R	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 19:47:09 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1De2DD-0004Wa-HI	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 19:47:08 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050603023809.GA28818@ccure.user-mode-linux.org>
References: <1115481468.925.9.camel@localhost.localdomain>
	<20050507180356.GA10793@ccure.user-mode-linux.org>
	<1115573839.10373.42.camel@cobra>
	<20050508183533.GA27251@ccure.user-mode-linux.org>
	<1115590823.10373.68.camel@cobra> <1115600253.10373.74.camel@cobra>
	<1117307236.10041.4.camel@localhost> <1117691482.10122.107.camel@localhost>
	<20050602210649.GA24306@ccure.user-mode-linux.org>
	<1117766016.10122.202.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117766016.10122.202.camel@localhost>
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
Date: Thu, 2 Jun 2005 22:38:09 -0400
To: antoine <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jun 03, 2005 at 03:33:36AM +0100, antoine wrote:
> Thanks, almost all applied cleanly - I skipped the s390 ones for now.

I wouldn't cherry-pick patches.  You may be right, but it also means you're
running different code than me.

> I can bring the network up manually (ifconfig) and ping (in and out),
> but running any of the /etc/init.d/ scripts locks up, same goes for
> starting sshd or even "Hello World" in hello.sh

Dunno, it works here, and I've beat on it a bunch.  If you can get stack
traces or anything from the hangs, that might help.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
