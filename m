Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByV9G-0008GX-5O for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Aug 2004 05:39:06 -0700
Received: from [61.95.227.64] (helo=gateway.gsecone.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1ByV9E-00088Y-BV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Aug 2004 05:39:05 -0700
Received: from gsecone.com ([61.95.227.65])
	by gateway.gsecone.com (8.12.8/8.12.8) with ESMTP id i7LB7b0G012200
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 Aug 2004 18:02:30 +0530
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
Content-Type: text/plain
Message-Id: <1093091667.5430.4.camel@vinay.gsecone.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml-patch-2.6.8.1-1 compilation error
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 21 Aug 2004 18:04:28 +0530
To: user-mode-linux-devel@lists.sourceforge.net

Hi List,

While compiling I got the following error

gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE   -Iarch/um/include -I/home/nvk/build/linux-2.6.8-uml1/arch/um/kernel/tt/include -I/home/nvk/build/linux-2.6.8-uml1/arch/um/kernel/skas/include -D_GNU_SOURCE -O2 -g -c -o arch/um/kernel/irq_user.o arch/um/kernel/irq_user.c
  CC      arch/um/kernel/ksyms.o
arch/um/kernel/ksyms.c:90: redefinition of `__kcrctab_os_ioctl_generic'
arch/um/kernel/ksyms.c:76: `__kcrctab_os_ioctl_generic' previously defined here
arch/um/kernel/ksyms.c:90: redefinition of `__kstrtab_os_ioctl_generic'
arch/um/kernel/ksyms.c:76: `__kstrtab_os_ioctl_generic' previously defined here
arch/um/kernel/ksyms.c:90: redefinition of `__ksymtab_os_ioctl_generic'
arch/um/kernel/ksyms.c:76: `__ksymtab_os_ioctl_generic' previously defined here


Vinay




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
