Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eed2b-0007Am-Ia for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 10:38:53 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eed2a-0002qI-41
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 10:38:53 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <1132684297.3073.78.camel@ant.internal>
References: <1132683605.3073.77.camel@ant.internal>
	<1132684297.3073.78.camel@ant.internal>
Content-Type: multipart/mixed; boundary="=-zF5tnq3a7aZ0OcZkIC/X"
Message-Id: <1132684721.3073.83.camel@ant.internal>
Mime-Version: 1.0
Subject: [uml-devel] Re: [PATCH?] 2.6.15-rc1 + sf.net patches on x86 needs a
	patch
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
Date: Tue, 22 Nov 2005 18:38:41 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>


--=-zF5tnq3a7aZ0OcZkIC/X
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

This patch attached *does* make it build, but it's not right.
The build moans at me for using the kernel headers... ok I shouldn't.

  CC      arch/um/os-Linux/aio.o
In file included from /usr/src/linux/include/linux/aio_abi.h:30,
                 from arch/um/os-Linux/aio.c:47:
/usr/include/asm/byteorder.h:6:2: warning: #warning using private kernel
header; include <endian.h> instead!

How do I get the new headers for my manually compiled kernel?

Antoine

On Tue, 2005-11-22 at 18:31 +0000, Antoine Martin wrote:
> Ignore that, it does not solve anything. Just delays the problem until
> link time.
> Anyone know why my kernel headers don't have aio_abi.h?
>=20
> Antoine
>=20
> On Tue, 2005-11-22 at 18:20 +0000, Antoine Martin wrote:
> > patch attached, I've no idea what I've done really, but it builds ok =
now.
> >=20
> > This time on an x86 box:
> >=20
> > wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
> > wget ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.15-=
rc1.bz2
> > wget http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.15-r=
c1/patches.tar
> > tar -xf patches.tar
> > tar -jxf linux-2.6.14.tar.bz2
> > mv linux-2.6.14 linux-2.6.15-rc1-uml
> > cd linux-2.6.15-rc1-uml
> > bzcat ../patch-2.6.15-rc1.bz2 | patch -p1
> > for patch in `cat ../patches/series`; do echo $patch; patch -p1 < ../=
patches/$patch;  done
> > find . -type f -size 0 -exec rm {} \;
> > make ARCH=3Dum defconfig
> > make ARCH=3Dum vmlinux
> >   LD      arch/um/drivers/net.o
> >   LD      arch/um/drivers/mconsole.o
> >   LD      arch/um/drivers/ubd.o
> >   CC      arch/um/drivers/null.o
> >   LD      arch/um/drivers/port.o
> >   CC      arch/um/drivers/pty.o
> >   CC      arch/um/drivers/tty.o
> >   CC      arch/um/drivers/cow_user.o
> >   CC      arch/um/drivers/random.o
> >   LD      arch/um/drivers/built-in.o
> >   CC      arch/um/os-Linux/aio.o
> > arch/um/os-Linux/aio.c: In function =91init_aio_26=92:
> > arch/um/os-Linux/aio.c:402: error: =91finish_aio_26=92 undeclared (fi=
rst use in this function)
> > arch/um/os-Linux/aio.c:402: error: (Each undeclared identifier is rep=
orted only once
> > arch/um/os-Linux/aio.c:402: error: for each function it appears in.)
> > make[1]: *** [arch/um/os-Linux/aio.o] Error 1
> > make: *** [arch/um/os-Linux] Error 2
> >=20
> > Antoine

--=-zF5tnq3a7aZ0OcZkIC/X
Content-Disposition: inline; filename=2.6.15-rc1-uml-aioheader-dodgyfix.patch
Content-Type: text/x-patch; name=2.6.15-rc1-uml-aioheader-dodgyfix.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-rc1-uml/arch/um/os-Linux/aio.c	2005-11-22 18:14:55.000000000 +0000
+++ linux-2.6.15-rc1-uml-fixed/arch/um/os-Linux/aio.c	2005-11-22 18:34:24.000000000 +0000
@@ -41,8 +41,10 @@
         return 0;
 }
 
+#define HAVE_AIO_ABI 1
+
 #if defined(HAVE_AIO_ABI)
-#include <linux/aio_abi.h>
+#include </usr/src/linux/include/linux/aio_abi.h>
 
 /* If we have the headers, we are going to build with AIO enabled.
  * If we don't have aio in libc, we define the necessary stubs here.

--=-zF5tnq3a7aZ0OcZkIC/X--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
