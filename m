Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZyILW-0007X2-0e
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:53:18 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZyILU-0008CY-W0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:53:17 +0000
References: <5649A525.9010404@oracle.com> <5649C186.7080106@nod.at>
	<5649C2D9.90407@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5649C3A3.2080400@nod.at>
Date: Mon, 16 Nov 2015 12:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <5649C2D9.90407@oracle.com>
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

Am 16.11.2015 um 12:49 schrieb Vegard Nossum:
> On 11/16/2015 12:44 PM, Richard Weinberger wrote:
>> Am 16.11.2015 um 10:43 schrieb Vegard Nossum:
>>> Starting UML like this:
>>>
>>> ./vmlinux rootfstype=hostfs rw ignore_console_loglevel con=xterm init=/bin/bash
>>>
>>> Results in unpredictable behaviour, most of the time an xterm flashes on
>>> my screen but the process aborts with only "Aborted" on the console
>>> where I ran the command, sometimes the xterm remains there but frozen,
>>> sometimes the xterm spews this warning non-stop:
>>
>> Hmm, is this a new regression?
>> I bet it only happens with con=xterm, right?
> 
> It's the first UML kernel I compile in a few years, so I don't know if
> it's old or new, sorry.
> 
> Yes, only con=xterm triggers this.

Okay, let me see. I use xterm very seldom these days. And maybe nobody else noticed. :D

> (For the record, I also couldn't con=pty or con=pts to work either, it
> just results in "Aborted."

You can use the "earlyprintk" parameter to get more output.

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

