Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1S7cRY-0000xu-Gq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 00:51:56 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7cRX-0002T0-VE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 00:51:56 +0000
Message-ID: <4F5FEBA0.5010905@panasas.com>
Date: Tue, 13 Mar 2012 17:51:44 -0700
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4F5FCC7D.5090307@panasas.com> <4F5FDF42.90004@nod.at>
	<4F5FE32B.9040301@panasas.com> <4F5FE4B8.4020006@nod.at>
In-Reply-To: <4F5FE4B8.4020006@nod.at>
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

On 03/13/2012 05:22 PM, Richard Weinberger wrote:
> Am 14.03.2012 01:15, schrieb Boaz Harrosh:
>> I guess if you don't have it then you don't. The most reliable way for me to get
>> it is a simple "halt". I'm not able to ever shut down properly it reliably crashes
>> like:
>>
>> Kernel panic - not syncing: Kernel mode fault at addr 0x54, ip 0x6015c233
> 
> What is at addr 0x6015c233?
> "addr2line -e vmlinux 0x6015c233" shows it.
> 

linux-open-osd/arch/um/drivers/line.c:46


> Does it also happen with a vanilla kernel?
> 

Yes, you mean git checkout v3.2 Yes it's the same all the way back to 2.6.39 or so

I just did that I get the same as above: addr2line -e .build_um/vmlinux 0x600179b8
linux-open-osd/arch/um/drivers/line.c:46

>>
>> OK then I have a problem because I get the "access not permitted" on attaching to any of these
>> forks but the top most parent. (as sudo)
> 
> You cannot attach to them because they are already being ptrace()'ed by 
> the UML main thread.

right that what I thought.
so if I make a break point that happened in another fork will it trigger still? I guess
yes. But if anything goes wrong in any of the other forks, is there a way for me to break
that fork into the debugger and see what happened like a bt? 

My current theory is that Fedora became UML unfriendly is there some random-exec-mem thingy
I need to turn off?

> 
> Thanks,
> //richard

Thanks richard for your help
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

