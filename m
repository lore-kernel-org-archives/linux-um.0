Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArINc-0007Az-1S
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 07:03:52 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ArIKL-0003wM-DS
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 07:00:29 -0800
From: Matt Ayres <matta@tektonic.net>
Content-Type: text/plain
Message-Id: <1076598155.20064.12.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] /dev/anon without /dev/anon ?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 12 Feb 2004 10:02:36 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I had tried out the /dev/anon patch on a host server, success wasn't too
good.  It crashed after a few hours of running.  This was without
ubd=mmap passed to the UML's. Unfortunately I do not have any sort of
OOPs.

Now the interesting part, I rebooted with the previous kernel so it does
not have the /dev/anon kernel patch.  The /dev/anon device still exists
and the UML's are using it!  

My primary question now is, is this a "bad thing" to do?  Would there be
any significant performance problems to just let it run this way? 
Shouldn't the UML kernel check to make sure that /dev/anon kernel
support is indeed there?

Thanks,
Matt



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
