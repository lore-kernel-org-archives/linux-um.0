Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d7lPi-0004hD-F1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 16:21:34 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d7lPe-00041B-CC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 16:21:34 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
	helo=smaug.kot-begemot.co.uk) by www.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d7lPX-0007mA-CN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 16:21:23 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1d7lPX-0002gp-5Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 17:21:23 +0100
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
	<D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
	<ab5f910f-a84a-b0c7-2750-92bc00ab2bfa@nod.at>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <eafa83d0-823f-ea0e-b532-63d9e683ce98@kot-begemot.co.uk>
Date: Mon, 8 May 2017 17:21:23 +0100
MIME-Version: 1.0
In-Reply-To: <ab5f910f-a84a-b0c7-2750-92bc00ab2bfa@nod.at>
Subject: Re: [uml-devel] [uml-user] UML on WSL
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
To: user-mode-linux-devel@lists.sourceforge.net

So far it is late 2.6. The high res timer subsystem settled fully 
somewhere circa 2.6.10 if memory serves me right. One of those lovely 
kernels which had VM collapse bugs :)

I am finishing testing the vector IO drivers and epoll irq controller 
for them you will need 3.0 onwards

In fact, I have run into brokennes in the core net_sched in 4.11 so I 
cannot fully test the xmit path in the new network drivers, otherwise I 
would have sent them out by now.

I have asked on linux-net, but no answer so far, trying to debug it 
myself. It is seriously broken (both for us and for virtio so kvm/qemu 
should be affected too).

A.


On 08/05/17 17:15, Richard Weinberger wrote:
> Thomas,
>
> Am 08.05.2017 um 18:09 schrieb Thomas Meyer:
>> Or asked he other way around:
>>
>> Is somewhere documented what's the minimum host kernel version that a UML kernel will run on?
>>
>> E.g.:
>> building a UML kernel from 4.11 will need a host kernel version 2.6.18 with features x, y and z enabled?
> Not really. But let's be realistic, we don't have to support a 2.4 host.
> UML should run on any kernel of a supported distro.
>
> On the other hand, if we can help WSL with a small change to UML, I'll happily apply such a patch.
>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

