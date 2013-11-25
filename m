Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1VkzjG-0000yR-QW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 17:13:46 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VkzjF-0006gk-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Nov 2013 17:13:46 +0000
Message-ID: <52938537.8010204@panasas.com>
Date: Mon, 25 Nov 2013 19:13:27 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <20131122060223.GP9991@yliu-dev.sh.intel.com>
	<2845101.Wgsx5afvdX@sandpuppy> <52936758.405@panasas.com>
	<1438760.zvSCZ2cKYN@sandpuppy>
In-Reply-To: <1438760.zvSCZ2cKYN@sandpuppy>
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
Subject: Re: [uml-devel] WARNING: CPU: 0 PID: 1 at init/main.c:711
	do_one_initcall()
To: Richard Weinberger <richard@nod.at>
Cc: Yuanhan Liu <yuanhan.liu@linux.intel.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 11/25/2013 05:09 PM, Richard Weinberger wrote:
> Am Montag, 25. November 2013, 17:06:00 schrieb Boaz Harrosh:
>>> Sad to hear.
>>> Did you try one from http://fs.devloop.org.uk/?
>>> Just booted a FC18 on UML. Works fine.
>>
>> I just tried this exact one last week. (It gets stuck half way through boot)
>> Could you post me the .config file you used, and command line, and/or any
>> other info?
> 
> Just did (on x86_64):
> 
> $ make defconfig ARCH=um

For some reason this one (I'm on FC17 x86_64) did not pick up the CONFIG_64BIT
and compiled a 32bit uml (I should have suspected when build failed with missing
gnu/stubs-32.h which is in an glibc-devel.i686 package) So after crashing very
fast I finally inspected under xconfig, fixing that ...

> $ make -j 4 linux ARCH=um
> $ ./linux ubda=../Fedora18-AMD64-root_fs mem=512M
> 

My god it works. I even have networking now. I guess the start from
scratch defconfig, did it for me, go figure. I had a .config that would
load FC15 but not FC17-FC18. (the new one loads both)

I'll try to put some load on it now. For a long time UM would crap under
load. Where in FC13 it would run (very slow) under the same load, on FC15
it would crash. Will report if you want.

> Thanks,
> //richard
> 

Thank you! Sir Richard.
Boaz


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

