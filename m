Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eecki-000696-5d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 10:20:24 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eecke-0001F4-K2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 10:20:24 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: multipart/mixed; boundary="=-mKo9u07p8U8ZRt1U10LA"
Message-Id: <1132683605.3073.77.camel@ant.internal>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH?] 2.6.15-rc1 + sf.net patches on x86 needs a patch
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
Date: Tue, 22 Nov 2005 18:20:05 +0000
To: Jeff Dike <jdike@addtoit.com>, UML devel <user-mode-linux-devel@lists.sourceforge.net>


--=-mKo9u07p8U8ZRt1U10LA
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

patch attached, I've no idea what I've done really, but it builds ok now.

This time on an x86 box:

wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.15-rc1.=
bz2
wget http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.15-rc1/p=
atches.tar
tar -xf patches.tar
tar -jxf linux-2.6.14.tar.bz2
mv linux-2.6.14 linux-2.6.15-rc1-uml
cd linux-2.6.15-rc1-uml
bzcat ../patch-2.6.15-rc1.bz2 | patch -p1
for patch in `cat ../patches/series`; do echo $patch; patch -p1 < ../patc=
hes/$patch;  done
find . -type f -size 0 -exec rm {} \;
make ARCH=3Dum defconfig
make ARCH=3Dum vmlinux
  LD      arch/um/drivers/net.o
  LD      arch/um/drivers/mconsole.o
  LD      arch/um/drivers/ubd.o
  CC      arch/um/drivers/null.o
  LD      arch/um/drivers/port.o
  CC      arch/um/drivers/pty.o
  CC      arch/um/drivers/tty.o
  CC      arch/um/drivers/cow_user.o
  CC      arch/um/drivers/random.o
  LD      arch/um/drivers/built-in.o
  CC      arch/um/os-Linux/aio.o
arch/um/os-Linux/aio.c: In function =91init_aio_26=92:
arch/um/os-Linux/aio.c:402: error: =91finish_aio_26=92 undeclared (first =
use in this function)
arch/um/os-Linux/aio.c:402: error: (Each undeclared identifier is reporte=
d only once
arch/um/os-Linux/aio.c:402: error: for each function it appears in.)
make[1]: *** [arch/um/os-Linux/aio.o] Error 1
make: *** [arch/um/os-Linux] Error 2

Antoine

--=-mKo9u07p8U8ZRt1U10LA
Content-Disposition: inline; filename=2.6.15-rc1-uml-ifdefcompilefix.patch
Content-Type: text/x-patch; name=2.6.15-rc1-uml-ifdefcompilefix.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-rc1-uml/arch/um/os-Linux/aio.c	2005-11-22 18:14:55.000000000 +0000
+++ linux-2.6.15-rc1-uml-fixed/arch/um/os-Linux/aio.c	2005-11-22 18:09:35.000000000 +0000
@@ -389,8 +389,6 @@
 	goto out;
 }
 
-#else
-#define DEFAULT_24_AIO 1
 static int submit_aio_26(struct aio_context *aio)
 {
         return -ENOSYS;
@@ -402,6 +400,8 @@
 	finish_proc = finish_aio_26;
         return -ENOSYS;
 }
+#else
+#define DEFAULT_24_AIO 1
 #endif
 
 static int aio_24 = DEFAULT_24_AIO;

--=-mKo9u07p8U8ZRt1U10LA--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
