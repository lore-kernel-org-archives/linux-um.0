Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak6wj-00009F-Fh for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 11:26:25 -0800
Received: from hannover-internet.com ([217.160.140.99])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak6S3-0007zC-4D for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 10:54:43 -0800
Received: from alex (dsl-213-023-235-086.arcor-ip.net [213.23.235.86])
	(authenticated bits=0)
	by hannover-internet.com (8.12.9/SQL-8.12.9-18/8.12.9/8.12.9) with
	ESMTP id i0NItdCE027203
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Fri, 23 Jan 2004 19:55:40 +0100
Message-ID: <028501c3e1e2$aefcd6d0$6f01a8c0@alex>
From: "Alexander Newald" <alexander@newald.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel 2.6.1 uml 2.6.1-1 build failed with module support
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
Date: Fri, 23 Jan 2004 19:57:00 +0100
To: User-mode-linux-devel@lists.sourceforge.net

Hello,

I've updated to the latest uml patch, enabled module support and got the
fullowing error:

my .config file http://linux.newald.de/uml/.config
Sources: linux-2.6.1.tar.bz2 uml-patch-2.6.1-1

make ARCH=um
...
ln -sf
/home/alexander/VServer/Build/linux-2.6.1/arch/i386/kernel/semaphore.c
arch/um/sys-i386/semaphore.c
  CC      arch/um/sys-i386/semaphore.o
gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-comm
on -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE 
  -Iarch/um/include -I/home/alexander/VServer/Build/linux-2.6.1/arch/um/kern
el/tt/include -I/home/alexander/VServer/Build/linux-2.6.1/arch/um/kernel/ska
s/include -D_GNU_SOURCE -c -o arch/um/sys-i386/sigcontext.o
arch/um/sys-i386/sigcontext.c
  CC      arch/um/sys-i386/syscalls.o
  CC      arch/um/sys-i386/sysrq.o
  CC      arch/um/sys-i386/time.o
rm -f arch/um/sys-i386/module.c
ln -sf /home/alexander/VServer/Build/linux-2.6.1/arch/i386/kernel/module.c
arch/um/sys-i386/module.c
  CC      arch/um/sys-i386/module.o
arch/um/sys-i386/module.c: In function `apply_relocate':
arch/um/sys-i386/module.c:79: `R_386_32' undeclared (first use in this
function)
arch/um/sys-i386/module.c:79: (Each undeclared identifier is reported only
once
arch/um/sys-i386/module.c:79: for each function it appears in.)
arch/um/sys-i386/module.c:83: `R_386_PC32' undeclared (first use in this
function)
make[1]: *** [arch/um/sys-i386/module.o] Error 1
make: *** [arch/um/sys-i386] Error 2

Any hints?

Alexander Newald



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
