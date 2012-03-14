Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1S7wge-0006sv-Vq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 22:28:52 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7wge-0004yC-0J for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 22:28:52 +0000
Message-ID: <4F611B97.1050809@panasas.com>
Date: Wed, 14 Mar 2012 15:28:39 -0700
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4F5FCC7D.5090307@panasas.com> <4F5FDF42.90004@nod.at>
	<4F5FE32B.9040301@panasas.com> <4F5FE4B8.4020006@nod.at>
	<4F5FEBA0.5010905@panasas.com> <4F60557B.7020704@nod.at>
In-Reply-To: <4F60557B.7020704@nod.at>
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
Subject: Re: [uml-devel] UML: Please help with __module_text_address crashing
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 03/14/2012 01:23 AM, Richard Weinberger wrote:
> Am 14.03.2012 01:51, schrieb Boaz Harrosh:
>> Yes, you mean git checkout v3.2 Yes it's the same all the way back to 2.6.39 or so
>>
>> I just did that I get the same as above: addr2line -e .build_um/vmlinux 0x600179b8
>> linux-open-osd/arch/um/drivers/line.c:46
> 
> Please give this patch a try:
> https://lkml.org/lkml/2012/3/10/163
> 

Yes with this patch I'm not crashing with halt anymore. Cheers.

Let me test some more and see if I have other problems. I crashed once in some
networking stack-trace but did not save it, let me see play with it some more.

But surly it needs to go upstream. I'll run with it out of tree for now.

>> My current theory is that Fedora became UML unfriendly is there some random-exec-mem thingy
>> I need to turn off?
>>
> 
> No. UML tty driver is broken like hell and newer distors seem to trigger it.
> I thought only Fc16 with systemd is affected. But as you using Fc15, I 
> was wrong...
> 


I have an administrative question. (If I may). This came up now with my FC15
setups. (I did not have these problem with my old FC12 setup)

In a default setup (make defconfig) I have:

CONFIG_XTERM_CHAN=y
CONFIG_CON_CHAN=xterm

If I leave it at that then very early in the boot an xterm X11 window comes up
the terminal is on the host (I see my host name and environment, not the UML one)
and the boot process just stops. Even if I close the window the boot is just stuck
I can only do "sudo killall vmlinux" from the host.

If I change "CONFIG_CON_CHAN not set" or just "CONFIG_CON_CHAN=nothing" then the
boot process complains but continues to a login prompt like I use to.

Do you know how to fix that?

Also in vi, it thinks I only have 25 lines. Do you know in FC where I say console
have more lines, or better yet auto adopt to my host console. I guess it might be
related to my first Q. I did not use to have these problems with my old setup

> Thanks,
> //richard

Thanks a million, for being so patient with me
Boaz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

