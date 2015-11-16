Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1ZyNrM-0003v1-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 17:46:32 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZyNrL-0007kP-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 17:46:32 +0000
References: <5649A525.9010404@oracle.com> <5649C186.7080106@nod.at>
	<5649C2D9.90407@oracle.com> <564A1339.8010607@nod.at>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <564A166A.5080504@oracle.com>
Date: Mon, 16 Nov 2015 18:46:18 +0100
MIME-Version: 1.0
In-Reply-To: <564A1339.8010607@nod.at>
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
To: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 11/16/2015 06:32 PM, Richard Weinberger wrote:
> Am 16.11.2015 um 12:49 schrieb Vegard Nossum:
>> On 11/16/2015 12:44 PM, Richard Weinberger wrote:
>>> Am 16.11.2015 um 10:43 schrieb Vegard Nossum:
>>>> Starting UML like this:
>>>>
>>>> ./vmlinux rootfstype=hostfs rw ignore_console_loglevel con=xterm init=/bin/bash
>>>>
>>>> Results in unpredictable behaviour, most of the time an xterm flashes on
>>>> my screen but the process aborts with only "Aborted" on the console
>>>> where I ran the command, sometimes the xterm remains there but frozen,
>>>> sometimes the xterm spews this warning non-stop:
>>>
>>> Hmm, is this a new regression?
>>> I bet it only happens with con=xterm, right?
>>
>> It's the first UML kernel I compile in a few years, so I don't know if
>> it's old or new, sorry.
>>
>> Yes, only con=xterm triggers this.
>
> /me found some odd stuff.
>
> arch/um/drivers/chan_user.c tries to call sigsuspend() on the host side.
> But sadly the kernel has also a function with the same name.
> So, chan_user.c calls into the UML kernel instead of the host.
> This seems to work by accident but confuses the Linux signal logic
> and you trigger from time to time the WARN_ON().
>
>  From a quick look, the kernel sigsuspend() has no users except in the same
> object file. So we can mark it static and UML calls the real one.
>
> Does the attached patch help?
> I'm sure we need more work as this clearly never worked as expected. :-(

Perfect, with your patch xterm works every time.

(With the earlyprintk tip you gave earlier, I was also able to use
con0=pts -- con0=pty doesn't seem to find any host devices, but that's
probably expected.)

Thanks a lot!


Vegard

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

