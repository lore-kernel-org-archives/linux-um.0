Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrhQz-0002hq-25 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 11:21:17 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BrhQy-0000eH-HO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 11:21:16 -0700
Message-Id: <200408021919.i72JJnUE024546@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 02 Aug 2004 01:15:46 EDT."
	<200408020115.47228.allen@home0.com> 
References: <200407280315.08207.alydar@users.sourceforge.net>
	<20040801155231.GA19648@ccure.user-mode-linux.org>
	<410D4E2A.8020704@hevanet.com>
	<200408020115.47228.allen@home0.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Mon, 02 Aug 2004 15:19:49 -0400
To: Allen Chan <allen@home0.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Matt Clay <mattclay@hevanet.com>, 260111@bugs.debian.org

allen@home0.com said:
> It appears that the tcgetattr() and tcsetattr() calls are expecting
> pointers to structures of size 60, but are getting pointers to
> structures of size 36 instead when placed inside chan_kern.c.  On a
> tcgetattr() call, the next 24 bytes on the stack after the local
> structure become open game for memory corruption.  On a tcsetattr()
> call, actions may be taken based on 24 bytes worth of data which is
> likely to be garbage. 

Right, this looks like a real explanation.  Thanks for chasing it down.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
