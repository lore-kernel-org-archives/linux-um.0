Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <paul.chavent@fnac.net>) id 1QIPp0-0002pk-9M
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2011 18:32:14 +0000
Received: from smtpfb2-g21.free.fr ([212.27.42.10])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QIPoy-0001f2-IR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2011 18:32:14 +0000
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 1EB95D1AD47
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  6 May 2011 20:12:31 +0200 (CEST)
Message-ID: <4DC4398C.2070307@fnac.net>
Date: Fri, 06 May 2011 20:10:20 +0200
From: Paul Chavent <paul.chavent@fnac.net>
MIME-Version: 1.0
References: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
	<BANLkTimDwsBk-MvFFABgf0kzx3WHkt6uMA@mail.gmail.com>
In-Reply-To: <BANLkTimDwsBk-MvFFABgf0kzx3WHkt6uMA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------010502010307010208070008"
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] for ARCH=um,
 optionaly give a path for the vde installation.
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010502010307010208070008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2011 09:52 AM, richard -rw- weinberger wrote:
>
> On Thu, May 5, 2011 at 9:34 AM,<paul.chavent@fnac.net>  wrote:
>> Hi.
>>
>> I use uml with vde. The kernel links against libvdeplug.a and automatically find it. But i would like to manually give its path.
>>
>> So i made a patch for being able to give the VDE_PREFIX when we call make.
>>
>> I wonder if this patch could be included in the mainstream kernel, or if there is a better way of doing it.
>>
>> Could you give me your opinion please ?
>
> Please post your patch.
> Otherwise nobody can review it.
>
Damned

thank you for reminding me :)

--------------010502010307010208070008
Content-Type: text/plain;
 name="linux-2.6.33.4-uml_vde_prefix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.6.33.4-uml_vde_prefix.patch"

diff -Nur linux-2.6.26.5.orig/arch/um/drivers/Makefile linux-2.6.26.5.mod/arch/um/drivers/Makefile
--- linux-2.6.26.5.orig/arch/um/drivers/Makefile	2008-08-02 00:58:24.000000000 +0200
+++ linux-2.6.26.5.mod/arch/um/drivers/Makefile	2008-08-06 14:09:04.000000000 +0200
@@ -19,7 +19,12 @@
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
-LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
+ifdef VDE_PREFIX
+  LDFLAGS_vde.o := -r $(VDE_PREFIX)/lib/libvdeplug.a
+  CFLAGS_vde_user.o := -I$(VDE_PREFIX)/include/
+else
+  LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
+endif
 
 targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
 

--------------010502010307010208070008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
--------------010502010307010208070008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------010502010307010208070008--


