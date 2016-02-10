Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1aTVvm-0002WD-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:39:46 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aTVvl-0008W1-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:39:46 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1aTVve-000369-EW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:39:38 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1aTVve-0005QH-6S
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:39:38 +0000
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
	<1455114596-3532-21-git-send-email-vegard.nossum@oracle.com>
	<56BB4AB2.5050400@nod.at>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <56BB4BAA.4000903@kot-begemot.co.uk>
Date: Wed, 10 Feb 2016 14:39:38 +0000
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
To: user-mode-linux-devel@lists.sourceforge.net

On 10/02/16 14:35, Richard Weinberger wrote:
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
> How do you use USB on uml?
> Or is it just for build coverage?

USB over Net should work. if that is working in the first place.

A.

>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


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

