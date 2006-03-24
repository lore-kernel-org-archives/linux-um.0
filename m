Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMpM0-0000tg-Bi for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 08:41:36 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMpM0-0001Vt-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 08:41:36 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FMpLS-0007Rx-It for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 17:41:03 +0100
Received: from jameson.reflexsecurity.com ([72.54.64.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Mar 2006 17:41:02 +0100
Received: from lunz by jameson.reflexsecurity.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Mar 2006 17:41:02 +0100
From: Jason Lunz <lunz@falooley.org>
Message-ID: <e017e2$hci$2@sea.gmane.org>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<200603240156.36646.blaisorblade@yahoo.it>
	<20060324023029.GD8104@ccure.user-mode-linux.org>
	<200603241534.01844.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: (implementation idea) Re: uml and nonstandard memory
	splits?
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
Date: Fri, 24 Mar 2006 16:40:34 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it said:
> However, currently, the rounding can't be 0.5G, it must be 0.25G with the 
> current code, and it's still fragile if the host code is changed.
>
> (arch/i386/Kconfig)
> config PAGE_OFFSET
>         hex
>         default 0xB0000000 if VMSPLIT_3G_OPT
>         default 0x78000000 if VMSPLIT_2G
>         default 0x40000000 if VMSPLIT_1G
>         default 0xC0000000

Yes, I don't think other choices are too unlikely in the future.
0xB0000000 was only chosen because it prevents a typical 32-bit machine
with 1G of ram from having 1/8 of it in a little 128M highmem zone. In
the future, "typical" could likely be something else.

Jason



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
