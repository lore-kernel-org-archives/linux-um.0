Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IFvo2-00080P-6d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 Jul 2007 10:46:50 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IFvo0-0000uy-Oh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 Jul 2007 10:46:50 -0700
Message-ID: <46AF757F.9080103@nagafix.co.uk>
Date: Tue, 31 Jul 2007 18:46:39 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975C78.5010903@nagafix.co.uk>
	<20070713160500.GB7468@c2.user-mode-linux.org>
	<4697BFCB.2060701@nagafix.co.uk>
	<20070713184545.GC9472@c2.user-mode-linux.org>
In-Reply-To: <20070713184545.GC9472@c2.user-mode-linux.org>
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
> On Fri, Jul 13, 2007 at 07:09:15PM +0100, Antoine Martin wrote:
>> Works for me (tm)
> 
> OK.
> 
>> btw, if you're in bug squashing mode, 
> 
> I always am (or if not, someone needs to give me a good kick in the rump).
> 
>> I've got one which is 100% 
>> reproducible - looks like a resource leak to me: simply run a post 
>> 2.6.20 guest kernel on a 2.6.21.5 32-bit host (IIRC with or without 
>> skas3) and do an "emerge --sync" (gentoo fs) on the guest. It will hang 
>> half way through, you can interrupt the task with ^Z, but nothing else 
>> will run after that.
> 
> OK, I'll take a look.
If it doesn't crash on emerge --sync (when I reboot it doesn't always
crash), try building something big (like glibc or gcc: emerge glibc gcc)
It does look like an fd leak or something: the connection stays alive,
processes already started can still receive keyboard input, but no way
to login or run any commands.

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGr3V/GK2zHPGK1rsRCnHjAJ9MCfCo2IIE1jroW008jhOZGizn8gCdGT/T
TlwijBMcskIJz0E+jAT01l4=
=X9u4
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
