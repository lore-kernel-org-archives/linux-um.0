Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1ZyIQ8-00024l-8N
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:58:04 +0000
Received: from mx0b-000f0801.pphosted.com ([67.231.152.113])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZyIQ5-0000Dx-VB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:58:04 +0000
Received: from pps.filterd (m0048192.ppops.net [127.0.0.1])
	by mx0b-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tAGBs3Qa005130 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Nov 2015 03:57:55 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0b-000f0801.pphosted.com with ESMTP id 1y7dshg3ts-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Nov 2015 03:57:55 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Mon, 16 Nov 2015 11:57:51 +0000
Message-ID: <5649C4BE.7020904@brocade.com>
References: <5649A525.9010404@oracle.com> <5649C186.7080106@nod.at>
	<5649C2D9.90407@oracle.com> <5649C3A3.2080400@nod.at>
In-Reply-To: <5649C3A3.2080400@nod.at>
Content-Language: en-US
Content-ID: <DD18C30DB12FD84F9D6FF4A0B95B7E0D@brocade.local>
MIME-Version: 1.0
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
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 16/11/15 11:53, Richard Weinberger wrote:
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
>>> Hmm, is this a new regression?
>>> I bet it only happens with con=xterm, right?
>> It's the first UML kernel I compile in a few years, so I don't know if
>> it's old or new, sorry.
>>
>> Yes, only con=xterm triggers this.
> Okay, let me see. I use xterm very seldom these days. And maybe nobody else noticed. :D

ignore_console_runlevel triggers this. If you do not use it xterm 
console actually works fine (I use it all the time with a debian userspace).

A.

>
>> (For the record, I also couldn't con=pty or con=pts to work either, it
>> just results in "Aborted."
> You can use the "earlyprintk" parameter to get more output.
>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Presto, an open source distributed SQL query engine for big data, initially
> developed by Facebook, enables you to easily query your data on Hadoop in a
> more interactive manner. Teradata is also now providing full enterprise
> support for Presto. Download a free open source copy now.
> http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

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

