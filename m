Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILgnH-0006uP-Lx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 07:57:51 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILgnF-0004rQ-8i
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 07:57:51 -0700
Message-ID: <46C465E4.1070606@nagafix.co.uk>
Date: Thu, 16 Aug 2007 15:57:40 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975C78.5010903@nagafix.co.uk>	<20070713160500.GB7468@c2.user-mode-linux.org>	<4697BFCB.2060701@nagafix.co.uk>	<20070713184545.GC9472@c2.user-mode-linux.org>	<46AF757F.9080103@nagafix.co.uk>	<20070807152131.GB6141@c2.user-mode-linux.org>
	<46B8980A.6010902@nagafix.co.uk> <46C31489.9040704@nagafix.co.uk>
In-Reply-To: <46C31489.9040704@nagafix.co.uk>
Subject: Re: [uml-devel] 2.6.21.5 crashes [was link failure,
	multiple definition of 'in6addr_any']
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Antoine Martin wrote:
> Antoine Martin wrote:
>> Jeff Dike wrote:
>>> On Tue, Jul 31, 2007 at 06:46:39PM +0100, Antoine Martin wrote:
>>>> If it doesn't crash on emerge --sync (when I reboot it doesn't
>>>> always crash), try building something big (like glibc or gcc:
>>>> emerge glibc gcc)
>>> Well, I did that, and it finished fine.
>> Damn, so maybe it is interacting with apache. This guest has got
>> apache running and it crashes every few days (usually when doing an
>> emerge sync but not always).
> 
> 
>>> Does this happen with a current UML?  Do you have any stack traces
>>> or core dumps for me to look at?
>> No core dumps but I'll try getting some stack traces using SysRq next
>>  time it crashes.
> 
> SysRq doesn't dump anything anymore (or did it ever? IIRC it did)
> This crash is 100% reproducible in my systems. Just emerging stuff
> triggers it.
Even better than emerging stuff, I found that simply doing a:
emerge --sync
Will crash during the sync or when it rebuilds the cache.

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxGXkGK2zHPGK1rsRCl4+AJ9M+RBcrHoGk21+9kEkZDt302Rd2QCeLHAR
/4QhuzJQPxf208rzd4Cczqo=
=jsDz
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
