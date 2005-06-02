Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ddwz5-00057M-Jj	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 14:12:11 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Ddwz2-0005xi-TU	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 14:12:11 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050602210649.GA24306@ccure.user-mode-linux.org>
References: <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra>
	<1115481468.925.9.camel@localhost.localdomain>
	<20050507180356.GA10793@ccure.user-mode-linux.org>
	<1115573839.10373.42.camel@cobra>
	<20050508183533.GA27251@ccure.user-mode-linux.org>
	<1115590823.10373.68.camel@cobra> <1115600253.10373.74.camel@cobra>
	<1117307236.10041.4.camel@localhost> <1117691482.10122.107.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117691482.10122.107.camel@localhost>
Subject: [uml-devel] Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
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
Date: Thu, 2 Jun 2005 17:06:49 -0400
To: antoine <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 02, 2005 at 06:51:22AM +0100, antoine wrote:
> I applied the patches on the website to 2.6.12-rc5 (mm1 and mm2: most
> patches apply cleanly to both, some have been merged in mm2 obviously),
> I got an error here:

I pushed out a fixed set of patches (against -mm2) that work for me.

There were some include changes in stub_segv.c.

The .d file thing is still there.  That seems to have been caused by my 
changing stub_segv.c to a userspace file.

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
