Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aFKqd-0000qT-QV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 02 Jan 2016 11:59:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aFKqc-000446-U2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 02 Jan 2016 11:59:51 +0000
References: <1451701909-24430-1-git-send-email-vegard.nossum@oracle.com>
	<5687B7EA.9090605@nod.at>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <5687BBAA.3020101@oracle.com>
Date: Sat, 2 Jan 2016 12:59:38 +0100
MIME-Version: 1.0
In-Reply-To: <5687B7EA.9090605@nod.at>
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
Subject: Re: [uml-devel] [PATCH] [RFC] um: define and use
	HAVE_LIBPCAP/HAVE_LIBVDEPLUG
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org

On 01/02/2016 12:43 PM, Richard Weinberger wrote:
> Am 02.01.2016 um 03:31 schrieb Vegard Nossum:
>> If you don't have libpcap or libvdeplug installed, you will get build
>> failures when compiling certain files:
>>
>> arch/um/drivers/vde_user.c:8:24: fatal error: libvdeplug.h: No such file or directory
>>   #include <libvdeplug.h>
>>
>> arch/um/drivers/pcap_user.c:7:18: fatal error: pcap.h: No such file or directory
>>   #include <pcap.h>
>>
>> This patch adds a basic pre-build check and defines the kconfig variables
>> HAVE_LIBPCAP and HAVE_LIBVDEPLUG depending on the result.
>>
>> There is a basic disadvantage to this scheme, namely that the user may
>> never see the options that rely on these libraries if they are not
>> installed. As a trade-off, we add a brand new option, MISSING_LIBRARIES
>> (defaulting to 'y'), which allows those options to be visible (and
>> selectable) anyway.
>>
>> [Note: I find this useful personally as I ran into the above build
>>   failures when playing around with UML -- so take this more as a
>>   suggestion on how things MAY be done better than a real patch.]
>
> Why can't you build with UML_NET_VDE=n and UML_NET_PCAP=n
> or install the missing libs?
> To me the patch reads like a lazy approach to make allyesconfig somehow build. :-)
>
> If one selects VDE or PCAP (either manually or via allyesconfig) and the libs are
> missing the build has to fail. Everything else will introduce nasty side effects
> like having different builds with the same config and packagers will cry.

Yeah, fair enough.


Vegard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

