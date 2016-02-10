Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1aTXh3-0007PE-A3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 16:32:41 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTXh1-0003ly-SJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 16:32:41 +0000
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
	<1455114596-3532-2-git-send-email-vegard.nossum@oracle.com>
	<20160210161536.GA11999@kroah.com> <56BB651A.7030107@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56BB661E.7010308@nod.at>
Date: Wed, 10 Feb 2016 17:32:30 +0100
MIME-Version: 1.0
In-Reply-To: <56BB651A.7030107@oracle.com>
Subject: Re: [uml-devel] [PATCH 02/21] usb: add HAS_IOMEM dependency to
	USB_NET2272
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
To: Vegard Nossum <vegard.nossum@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, James McMechan <James_McMechan@hotmail.com>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, user-mode-linux-devel@lists.sourceforge.net

Am 10.02.2016 um 17:28 schrieb Vegard Nossum:
> I don't think there is a "correct function" for when HAS_IOMEM is not
> enabled. There is no IO address space on UML, so it doesn't make sense
> to compile these drivers in the first place.
> 
> Or do you mean to use the dummy implementation from asm-generic/io.h? (I
> have to admit I don't know how that would work.)

We already had an discussion of having an ioremap() like this for UML and S390:

static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
{
	BUG();
	return NULL;
}

But IMHO we should just fix the driver dependencies instead of providing dummy
interfaces just for the sake of making things somehow build...

Thanks,
//richard

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

