Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY3ez-0000oz-Dp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 11:52:57 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KY3ex-0004Kp-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 11:52:57 -0700
Message-ID: <48B450C7.9090906@meduna.org>
Date: Tue, 26 Aug 2008 20:51:51 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
	<48B3AED8.5040904@meduna.org>
	<20080826174600.GA24342@c2.user-mode-linux.org>
	<48B44658.8010403@meduna.org>
	<20080826184425.GA18462@c2.user-mode-linux.org>
In-Reply-To: <20080826184425.GA18462@c2.user-mode-linux.org>
Subject: Re: [uml-devel] FP registers corruption
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> You can work around this by putting a 0 into /proc/sys/vm/mmap_min_addr.

Permission denied here - looks quite hard readonly on this kernel
even for root.

>> Same here with 2.6.26.2 :(
> 
> Hmmm.  If it's not a problem there, I'm tempted to call it fixed,
> whatever it was.  Can you check current 2.6.27-rc?

OK, I'll try to convince my provider to test 2.6.26.2 and
possibly 27-rc soon - I'll let you know of the result.

Thanks
-- 
                                   Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
