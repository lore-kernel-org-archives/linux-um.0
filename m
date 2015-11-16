Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZyICn-00071m-JP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:44:17 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZyICm-0008Cd-04
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:44:17 +0000
References: <5649A525.9010404@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5649C186.7080106@nod.at>
Date: Mon, 16 Nov 2015 12:44:06 +0100
MIME-Version: 1.0
In-Reply-To: <5649A525.9010404@oracle.com>
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
Subject: Re: [uml-devel] WARNING: CPU: 0 PID: 908 at
 include/linux/thread_info.h:128 sigsuspend+0xab/0xc0()
To: Vegard Nossum <vegard.nossum@oracle.com>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi!

Am 16.11.2015 um 10:43 schrieb Vegard Nossum:
> Hi,
> 
> Starting UML like this:
> 
> ./vmlinux rootfstype=hostfs rw ignore_console_loglevel con=xterm init=/bin/bash
> 
> Results in unpredictable behaviour, most of the time an xterm flashes on
> my screen but the process aborts with only "Aborted" on the console
> where I ran the command, sometimes the xterm remains there but frozen,
> sometimes the xterm spews this warning non-stop:

Hmm, is this a new regression?
I bet it only happens with con=xterm, right?

Thanks,
//richard

------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

