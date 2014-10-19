Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1Xfpld-0000l7-S1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Oct 2014 12:39:25 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xfplc-0002Po-2T
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Oct 2014 12:39:25 +0000
Message-ID: <1413722356.2991.8.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 19 Oct 2014 14:39:16 +0200
Mime-Version: 1.0
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [UM] Long loop in __getnsdayoftime() after resume from
	ram
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello,

in UML kernel I get a long cpu using loop in __getnstimeofday()
(kernel/time/timekeeping.c:315) in the call of timespec_add_ns(),
when I left the host kernel suspended to ram for a few hours and resume
again.
this is because it seems like the tk->xtime_sec wasn't updated yet, but
the nsecs were. nsecs can be as high as 8111000111000111000l

the function timespec_add_ns() (include/linux/time.h:266) will call
__iter_div_u64_rem() which has an optimized loop for the case
that the dividend is not much bigger as the divisior.
but this isn't the case for resume from ram on the host kernel.

any ideas how to fix this? is it possible to intercept the resume from
ram and update the timekeeper->xtime_sec somehow?
or can the um arch somehow overwrite timespec_add_ns() to always use
div_u64_rem() instead?

with kind regards

PS: repost on these lists, because nobody did respond to my original
email.


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

