Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BuO2I-0002mE-3n for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Aug 2004 21:14:54 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BuO2H-0005eu-KC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Aug 2004 21:14:54 -0700
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i7A5FUQW027590 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Aug 2004 01:15:30 -0400
Message-Id: <200408100515.i7A5FUQW027590@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Testing needed for terminal handling patches
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
Date: Tue, 10 Aug 2004 01:15:30 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I've posted a set of patches that fiddle with UML's handling of terminal modes
to http://user-mode-linux.sourceforge.net/patches.html

I'd like people to try them out and report bad experiences, especially if you
saw the 'netdevice 0' hang or stairstepping output during boot.  They are the
catch-eintr, bb-raw, and clean-raw patches.

In particular, I removed the complain argument to raw, which means that it
will always complain if something failed.  The reason it was there in the
first place is that a long, long time ago, in a universe far, far away, I
saw a failure there on stdout call printk, which would recurse through the
same code, causing the same failure, reporting it through printk again, ad
infinitum.  I'm curious as to whether this infinite recursion was sparked
by an EINTR or something else.

Also, TCSACRAIN is always used instead of TCSANOW.  I don't see any reason
that I need NOW instead of DRAIN.

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
