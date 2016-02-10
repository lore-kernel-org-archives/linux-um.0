Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTW1C-0004XB-Et
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:45:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTW1B-0006RV-Ll
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:45:22 +0000
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
	<1455114596-3532-21-git-send-email-vegard.nossum@oracle.com>
	<56BB4AB2.5050400@nod.at>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <56BB4CF0.90105@oracle.com>
Date: Wed, 10 Feb 2016 15:45:04 +0100
MIME-Version: 1.0
In-Reply-To: <56BB4AB2.5050400@nod.at>
Subject: Re: [uml-devel] [PATCH 21/21] usb: remove HAS_IOMEM dependency from
	USB_SUPPORT
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
To: Richard Weinberger <richard@nod.at>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, James McMechan <James_McMechan@hotmail.com>

On 02/10/2016 03:35 PM, Richard Weinberger wrote:
> Am 10.02.2016 um 15:29 schrieb Vegard Nossum:
>> USB has not been usable on UML since this commit:
>>
>> commit e25df1205f37c7bff3ab14fdfc8a5249f3c69c82
>> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Date:   Thu May 10 15:45:57 2007 +0200
>>
>>      [S390] Kconfig: menus with depends on HAS_IOMEM.
>>
>>      Add "depends on HAS_IOMEM" to a number of menus to make them
>>      disappear for s390 which does not have I/O memory.
>>
>>      Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>
>> With hopefully all USB Host Controller Drivers that need it now
>> depending on HAS_IOMEM, we can remove the dependency from USB_SUPPORT
>> itself. This makes it possible to include USB support in UML builds
>> again.
>
> How do you use USB on uml?
> Or is it just for build coverage?

You can use usbip_host (USB over ip) to connect with real devices or
gadgetfs (e.g. dummy_hcd) to emulate a device in the UML userspace which
connects to the USB driver in the UML kernel.

James McMechan at one time had some patches for passing through USB
devices on the host to the UML kernel but I don't think it was ever
merged. Anyway, that might be desirable to bring back at some point in
the future.

My specific use case is using gadgetfs inside UML for USB device driver
fuzzing.


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

