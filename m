Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J28eK-0008WE-Dp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Dec 2007 09:12:04 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J28eJ-0005ol-83
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Dec 2007 09:12:04 -0800
Date: Tue, 11 Dec 2007 12:11:56 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071211171156.GA6656@c2.user-mode-linux.org>
References: <20071208141753.GA4667@c2.user-mode-linux.org>
	<1197301533.6483.440.camel@athena.fprintf.net>
	<1197343606.6483.484.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1197343606.6483.484.camel@athena.fprintf.net>
Subject: Re: [uml-devel] SKAS3 for 2.6.23
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
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Dec 10, 2007 at 10:26:46PM -0500, Daniel Gryniewicz wrote:
> Okay, attached is a patch against 2.6.23.9 + skas3 patch to make it
> build (and run) as a UML guest.  I've only tested it on x86_64 (but I
> did use SUBARCH=i386).  I went the route of minimal changes to get it to
> build, as just including things from asm/arch/ didn't work very well.

Thanks, I've dropped this into my tree.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
