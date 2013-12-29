Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1VxGFU-0006K6-Dx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Dec 2013 13:17:44 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VxGFS-0001EV-SK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Dec 2013 13:17:44 +0000
Received: from mail.polarparty.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 89C841D1DCC
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Dec 2013 14:14:38 +0100 (CET)
MIME-Version: 1.0
Date: Sun, 29 Dec 2013 14:14:38 +0100
From: stian@nixia.no
In-Reply-To: <52C01B3D.3010508@gmx.de>
References: <52B5A773.3000705@gmx.de> <52C01B3D.3010508@gmx.de>
Message-ID: <d0b8642ac645400c9e1bf7e4f7d8a4d2@nixia.no>
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
Subject: Re: [uml-devel] negative pid -516 possible ?
To: user-mode-linux-devel@lists.sourceforge.net

>> #6  0x08421d02 in rest_init () at init/main.c:401
>>         pid = -516
>> #7  0x080487e1 in start_kernel () at init/main.c:655
>>         command_line = 0x85b6400 <command_line> "earlyprintk 
>> ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap 
>> eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=1025M con0=fd:0,fd:1 con=pts 
>> rootfstype=ext4  root=98:0"
>> #8  0x08049e09 in start_kernel_proc (unused=0x0) at 
>> arch/um/kernel/skas/process.c:46
>>         pid = -516
>> #9  0x0805f7cb in new_thread_handler () at 
>> arch/um/kernel/process.c:129
>>         fn = 0x0
>> #10 0x00000000 in ?? ()
>> No symbol table info available.
>>
>>
>> Is this a valid number ?
> I'm asking b/c there's no process group id 516, and -516 always
> happens in the back traces.
> And furthermore after a while the UML system does no longer serve any
> ssh login attempts.

516 ==  -ERESTART_RESTARTBLOCK  ??

Stian

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

