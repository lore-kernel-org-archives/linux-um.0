Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqaBx-0003mb-GF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 09:25:09 -0700
Message-Id: <200407301723.i6UHNeUE002844@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 29 Jul 2004 22:34:01 EDT."
	<200407292234.04279.alydar@users.sourceforge.net> 
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
	<200407291430.18818.alydar@users.sourceforge.net>
	<200407292234.04279.alydar@users.sourceforge.net> 
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
Date: Fri, 30 Jul 2004 13:23:40 -0400
To: Allen Chan <alydar@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, 260111@bugs.debian.org

alydar@users.sourceforge.net said:
> More details on the problem after some more investigation and
> testing... the specific function that was moved from chan_user.c to
> chan_kern.c that caused the problem is generic_console_write().
> Notice the isatty() calls.  They probably explain the earlier
> observation that piping or redirecting the stdout gets around the
> problem. 

The move_console_write patch at http://user-mode-linux.sourceforge.net/patches.html
backs out this part of that change.

Can anyone who's seeing this check that it fixes the hang?

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
