Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7ehW-00066R-6U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 14:26:10 -0800
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J7ehU-0007BR-N4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 14:26:10 -0800
Received: by py-out-1112.google.com with SMTP id a25so4849956pyi.11
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Dec 2007 14:26:07 -0800 (PST)
Message-ID: <4772D501.6050306@gmail.com>
Date: Wed, 26 Dec 2007 14:26:09 -0800
From: Quantum Skyline <quantum.skyline@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] __attribute_used__ error on 2.6.23.9
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I've been trying to modify the UML makefiles in the 2.6.23.9 kernel to =

compile against a different C library, but I'm running into trouble =

getting parts of UML to compile with GCC 4.2.1.  In particular, files in =

os-Linux that use functions like __uml_setup are causing GCC to throw =

errors.

For example, when I try to compile arch/um/os-Linux/aio.c in my =

environment, I get the following:

gcc-4.2.1-rev -Wp,-MD,arch/um/os-Linux/.aio.o.d  -Wall -Wundef =

-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common =

-Werror-implicit-function-declaration -Os -D__arch_um__ =

-DSUBARCH=3D\"i386\" -Dvmap=3Dkernel_vmap =

-Din6addr_loopback=3Dkernel_in6addr_loopback =

-Din6addr_any=3Dkernel_in6addr_any -march=3Di686 =

-mpreferred-stack-boundary=3D2 -ffreestanding -D_LARGEFILE64_SOURCE =

-fno-unit-at-a-time -fno-omit-frame-pointer -fno-optimize-sibling-calls =

-g -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign =

-Iarch/um/include =

-I/home/tmjackso/build/orchestra/uml/linux-2.6.23.9/arch/um/include/skas =

-D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE =

-DHAVE_AIO_ABI -v -nostdinc -I../../dietlibc/trunk/include -isystem =

/usr/local/gcc-4.2.1-rev/include -c -o arch/um/os-Linux/aio.o =

arch/um/os-Linux/aio.c
arch/um/os-Linux/aio.c:307: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =

=91__attribute__=92 before =91__attribute_used__=92
arch/um/os-Linux/aio.c:307: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =

=91__attribute__=92 before =91__attribute_used__=92
arch/um/os-Linux/aio.c:350: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =

=91__attribute__=92 before =91__attribute_used__=92
arch/um/os-Linux/aio.c:360: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =

=91__attribute__=92 before =91__attribute_used__=92

I know that __uml_setup and friends are defined in =

arch/um/include/init.h and it is being included, but it seems like GCC =

is not using it.  If I comment out __uml_setup, other files which have =

functions starting with two underscores like __uml_initcall also cause =

compilation to fail.

Can anyone give some hints to solve this problem?

Cheers,

Todd Jackson

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
