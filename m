Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aVB5n-00033w-JI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Feb 2016 04:48:59 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aVB5m-0007NP-OA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Feb 2016 04:48:59 +0000
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
	<1455114596-3532-20-git-send-email-vegard.nossum@oracle.com>
	<20160215010938.GA2729@kroah.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <56C158A4.9000909@oracle.com>
Date: Mon, 15 Feb 2016 05:48:36 +0100
MIME-Version: 1.0
In-Reply-To: <20160215010938.GA2729@kroah.com>
Subject: Re: [uml-devel] [PATCH 20/21] usb: support building without
	CONFIG_HAS_DMA
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On 02/15/2016 02:09 AM, Greg Kroah-Hartman wrote:
> On Wed, Feb 10, 2016 at 03:29:55PM +0100, Vegard Nossum wrote:
>> Some platforms don't have DMA, but we should still be able to build
>> USB drivers for these platforms. They could still be used through
>> vhci_hcd, usbip_host, or maybe something like USB passthrough in UML
>> from a capable host.
>>
>> This is admittedly ugly with all the #ifdefs, but it is necessary to
>> get around linker errors like these:
>
> Sorry, you are going to have to do something else here, I can't accept
> this patch, it's just too ugly to read :(
>

Ok, I'll work on an alternative. Thanks for the feedback ;-)


Vegard

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

