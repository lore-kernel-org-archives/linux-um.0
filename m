Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IIRXx-000378-QK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Aug 2007 09:04:40 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IIRXv-0000XF-8v
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Aug 2007 09:04:37 -0700
Message-ID: <46B8980A.6010902@nagafix.co.uk>
Date: Tue, 07 Aug 2007 17:04:26 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975C78.5010903@nagafix.co.uk>
	<20070713160500.GB7468@c2.user-mode-linux.org>
	<4697BFCB.2060701@nagafix.co.uk>
	<20070713184545.GC9472@c2.user-mode-linux.org>
	<46AF757F.9080103@nagafix.co.uk>
	<20070807152131.GB6141@c2.user-mode-linux.org>
In-Reply-To: <20070807152131.GB6141@c2.user-mode-linux.org>
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

Jeff Dike wrote:
> On Tue, Jul 31, 2007 at 06:46:39PM +0100, Antoine Martin wrote:
>> If it doesn't crash on emerge --sync (when I reboot it doesn't always
>> crash), try building something big (like glibc or gcc: emerge glibc gcc)
> 
> Well, I did that, and it finished fine.
Damn, so maybe it is interacting with apache. This guest has got apache
running and it crashes every few days (usually when doing an emerge sync
but not always).


> Does this happen with a current UML?  Do you have any stack traces or
> core dumps for me to look at?
No core dumps but I'll try getting some stack traces using SysRq next
time it crashes.

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuJgKGK2zHPGK1rsRCibpAJ9NLCwY8o192pgebZ04QqUUzYQ8dQCfZvcZ
jlaytfGYM9N4uy3R6QDkRnc=
=XC5D
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
