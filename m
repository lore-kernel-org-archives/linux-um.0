Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByXgf-0005uo-SI for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Aug 2004 08:21:45 -0700
Received: from tharec.debianbase.de ([212.79.163.254] helo=mail2.debianbase.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByXge-0000SB-1j for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Aug 2004 08:21:45 -0700
Received: from mail.debianbase.de (tha.vpn.local [192.168.100.1])
	by mail2.debianbase.de (Postfix) with ESMTP id 8C8512BEC9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 Aug 2004 17:20:47 +0200 (CEST)
Received: from vaiobook.tha.local (vaiobook.tha.local [10.0.0.9])
	by mail.tha.local (Postfix) with ESMTP id EAFFF97ECCC
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 Aug 2004 17:20:53 +0200 (CEST)
From: Ralph =?iso-8859-15?q?Pa=DFgang?= <ralph@debianbase.de>
Subject: Re: [uml-devel] uml-patch-2.6.8.1-1 compilation error
References: <1093091667.5430.4.camel@vinay.gsecone.com>
In-Reply-To: <1093091667.5430.4.camel@vinay.gsecone.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Qh2JBMaM8gGv5y/"
Message-Id: <200408211720.48201.ralph@debianbase.de>
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
Date: Sat, 21 Aug 2004 17:20:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--Boundary-00=_Qh2JBMaM8gGv5y/
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Vinay (& list),

I had the same problem compiling a uml kernel 2.6.7 and 2.6.8.1. I took a 
debian kernel-source package and applied the uml-patch for it.

It seems that in ksyms.c "os_ioctl_generic" is declared twice. So I made a 
small patch for this problem.

I attached it as file to my mail, but because it's so short, I copy&paste it 
quite under my post.

It would be nice if a good kernel hacker would take a look at it. The UML 
works for me, but I'm not sure if I solved the problem correctly.

Patch (works for 2.6.7 and 2.6.8 with the uml patch applied):

diff -Naur kernel-source-2.6.7.orig/arch/um/kernel/ksyms.c 
kernel-source-2.6.7/$
--- kernel-source-2.6.7.orig/arch/um/kernel/ksyms.c     2004-08-19 
15:23:52.000$
+++ kernel-source-2.6.7/arch/um/kernel/ksyms.c  2004-08-19 15:26:14.000000000 
+$
@@ -87,7 +87,7 @@
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
-EXPORT_SYMBOL(os_ioctl_generic);
+/* EXPORT_SYMBOL(os_ioctl_generic); */
 EXPORT_SYMBOL(os_rcv_fd);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);

--Ralph

Am Samstag 21 August 2004 14:34 schrieb Vinay K Nallamothu:
> Hi List,
>
> While compiling I got the following error
>
> gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\"
> -D_LARGEFILE64_SOURCE   -Iarch/um/include
> -I/home/nvk/build/linux-2.6.8-uml1/arch/um/kernel/tt/include
> -I/home/nvk/build/linux-2.6.8-uml1/arch/um/kernel/skas/include
> -D_GNU_SOURCE -O2 -g -c -o arch/um/kernel/irq_user.o
> arch/um/kernel/irq_user.c CC      arch/um/kernel/ksyms.o
> arch/um/kernel/ksyms.c:90: redefinition of `__kcrctab_os_ioctl_generic'
> arch/um/kernel/ksyms.c:76: `__kcrctab_os_ioctl_generic' previously defined
> here arch/um/kernel/ksyms.c:90: redefinition of
> `__kstrtab_os_ioctl_generic' arch/um/kernel/ksyms.c:76:
> `__kstrtab_os_ioctl_generic' previously defined here
> arch/um/kernel/ksyms.c:90: redefinition of `__ksymtab_os_ioctl_generic'
> arch/um/kernel/ksyms.c:76: `__ksymtab_os_ioctl_generic' previously defined
> here
>
>
> Vinay
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_Qh2JBMaM8gGv5y/
Content-Type: text/x-diff; charset="iso-8859-15";
	name="uml-patch-2.6.7-2-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-patch-2.6.7-2-fix.diff"

diff -Naur kernel-source-2.6.7.orig/arch/um/kernel/ksyms.c kernel-source-2.6.7/arch/um/kernel/ksyms.c
--- kernel-source-2.6.7.orig/arch/um/kernel/ksyms.c	2004-08-19 15:23:52.000000000 +0200
+++ kernel-source-2.6.7/arch/um/kernel/ksyms.c	2004-08-19 15:26:14.000000000 +0200
@@ -87,7 +87,7 @@
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
-EXPORT_SYMBOL(os_ioctl_generic);
+/* EXPORT_SYMBOL(os_ioctl_generic); */
 EXPORT_SYMBOL(os_rcv_fd);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);

--Boundary-00=_Qh2JBMaM8gGv5y/--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
