Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvUBU-0007qM-1p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 22:00:56 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BvUBQ-0008Il-Ik
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 22:00:52 -0700
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i7D624JA005298 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 13 Aug 2004 02:02:04 -0400
Message-Id: <200408130602.i7D624JA005298@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.26-3
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
Date: Fri, 13 Aug 2004 02:02:04 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This patch has lots of stuff in it, mostly bug fixes and cleanups, notably:
	the 'netdevice 0' hang is gone
	UML doesn't hang if the system clock goes backwards
	added some EINTR protection
	cleaned up the switching of terminals between raw and normal
	cleanups in the fork code
	removed a field from the thread structure
	fixed the SMP build
	the malloc/free wrappers should be right now
	fixed an iomem bug

Also, UML will load at a normal address (0x80xxxxx) with CONFIG_MODE_SKAS on 
and CONFIG_MODE_TT off.  This was for valgrind, but it has the side-effect of
letting UML have larger physical memories - ~750M with CONFIG_STATIC_LINK off
and ~2.75G with it on.

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
