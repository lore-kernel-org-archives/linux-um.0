Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJ6xH-0006z8-Ar for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Aug 2007 05:17:31 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IJ6xF-0008Ee-RN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Aug 2007 05:17:31 -0700
Message-ID: <46BB05D2.7010501@nagafix.co.uk>
Date: Thu, 09 Aug 2007 13:17:22 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975C78.5010903@nagafix.co.uk>
	<20070713160500.GB7468@c2.user-mode-linux.org>
	<4697BFCB.2060701@nagafix.co.uk>
	<20070713184545.GC9472@c2.user-mode-linux.org>
	<46AF757F.9080103@nagafix.co.uk>
	<20070803175340.GA8430@c2.user-mode-linux.org>
In-Reply-To: <20070803175340.GA8430@c2.user-mode-linux.org>
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
>> It does look like an fd leak or something: the connection stays alive,
>> processes already started can still receive keyboard input, but no way
>> to login or run any commands.
> 
> OK, so I get this:
> 
> 	Welcome to viper.nagafix.co.uk
> 
> 	@ERROR: access denied to gentoo-portage from pool-72-70-38-233.bstnma.fios.verizon.net (72.70.38.233)
> 
> What are the public servers that I can sync against, and where do I put them?
Ooops, my update script seems to have been interrupted in the past and
failed to remove the "SYNC=XXX" line it places in /etc/make.conf
Script now fixed and the images have been updated too.

Antoine

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuwXSGK2zHPGK1rsRCpWHAJ986mjSod2gLW11+jI9iYgoQI6gqACeMm8A
B+9MBfr2My/xrpFswM2ZuCE=
=ETyK
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
