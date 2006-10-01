Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU3DL-00020v-VM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:26:48 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GU3DJ-0003kd-BR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:26:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 1 Oct 2006 17:23:53 +0200
References: <efn1e9$46l$1@sea.gmane.org>
In-Reply-To: <efn1e9$46l$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J29HFMK8BJM9+MX"
Message-Id: <200610011723.53869.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.18 compile problem: undefined reference to
	crypto_tfm_ctx_offset
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?utf-8?q?K=C3=B6hler?= <skoehler@upb.de>

--Boundary-00=_J29HFMK8BJM9+MX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 01 October 2006 02:17, Sven K=F6hler wrote:
> I get this error:

> # LANG=3DC make ARCH=3Dum vmlinux
> make[1]: `arch/um/sys-i386/user-offsets.s' is up to date.
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHK     include/linux/compile.h
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/i386/crypto/built-in.o: In function `aes_enc_blk':
> aes.c:(.text+0xd): undefined reference to `crypto_tfm_ctx_offset'
> arch/i386/crypto/built-in.o: In function `aes_dec_blk':
> aes.c:(.text+0xb95): undefined reference to `crypto_tfm_ctx_offset'
> aes.c:(.text+0xb9c): undefined reference to `crypto_tfm_ctx_offset'
> collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1
>
>
>
> I guess, i just have to disable some crypto-stuff, but i wanted to
> inform you about that.

I fixed this a few days ago, and the fix is in 2.6.18-bb1 (tell me if I for=
got=20
to upload it). It is the one attached but I do not remember if it applies b=
y=20
itself or has dependencies, so try -bb1.
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_J29HFMK8BJM9+MX
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="um-64-arch-crypto"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="um-64-arch-crypto"

Index: linux-2.6.git/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.git.orig/arch/um/Makefile-x86_64
+++ linux-2.6.git/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-core-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/ arch/x86_64/crypto/
 START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
Index: linux-2.6.git/arch/um/include/common-offsets.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/common-offsets.h
+++ linux-2.6.git/arch/um/include/common-offsets.h
@@ -15,3 +15,4 @@ DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
Index: linux-2.6.git/arch/um/include/sysdep-i386/kernel-offsets.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/sysdep-i386/kernel-offsets.h
+++ linux-2.6.git/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/mman.h>
 
 #define DEFINE(sym, val) \
Index: linux-2.6.git/arch/um/include/sysdep-x86_64/kernel-offsets.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ linux-2.6.git/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -2,6 +2,7 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/page.h>
 #include <asm/mman.h>
 

--Boundary-00=_J29HFMK8BJM9+MX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_J29HFMK8BJM9+MX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_J29HFMK8BJM9+MX--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

