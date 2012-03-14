Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1S7byy-0007rS-3J
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 00:22:24 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S7byx-00064Q-Cy
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 00:22:24 +0000
Message-ID: <4F5FE4B8.4020006@nod.at>
Date: Wed, 14 Mar 2012 01:22:16 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4F5FCC7D.5090307@panasas.com> <4F5FDF42.90004@nod.at>
	<4F5FE32B.9040301@panasas.com>
In-Reply-To: <4F5FE32B.9040301@panasas.com>
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 14.03.2012 01:15, schrieb Boaz Harrosh:
> I guess if you don't have it then you don't. The most reliable way for me to get
> it is a simple "halt". I'm not able to ever shut down properly it reliably crashes
> like:
>
> Kernel panic - not syncing: Kernel mode fault at addr 0x54, ip 0x6015c233

What is at addr 0x6015c233?
"addr2line -e vmlinux 0x6015c233" shows it.

Does it also happen with a vanilla kernel?

>
> OK then I have a problem because I get the "access not permitted" on attaching to any of these
> forks but the top most parent. (as sudo)

You cannot attach to them because they are already being ptrace()'ed by 
the UML main thread.

Thanks,
//richard

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

