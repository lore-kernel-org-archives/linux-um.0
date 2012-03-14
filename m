Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1S7jUf-0001oQ-4S
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 08:23:37 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S7jUZ-00050q-Uh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 08:23:37 +0000
Message-ID: <4F60557B.7020704@nod.at>
Date: Wed, 14 Mar 2012 09:23:23 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4F5FCC7D.5090307@panasas.com> <4F5FDF42.90004@nod.at>
	<4F5FE32B.9040301@panasas.com> <4F5FE4B8.4020006@nod.at>
	<4F5FEBA0.5010905@panasas.com>
In-Reply-To: <4F5FEBA0.5010905@panasas.com>
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

Am 14.03.2012 01:51, schrieb Boaz Harrosh:
> Yes, you mean git checkout v3.2 Yes it's the same all the way back to 2.6.39 or so
>
> I just did that I get the same as above: addr2line -e .build_um/vmlinux 0x600179b8
> linux-open-osd/arch/um/drivers/line.c:46

Please give this patch a try:
https://lkml.org/lkml/2012/3/10/163

> My current theory is that Fedora became UML unfriendly is there some random-exec-mem thingy
> I need to turn off?
>

No. UML tty driver is broken like hell and newer distors seem to trigger it.
I thought only Fc16 with systemd is affected. But as you using Fc15, I 
was wrong...

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

