Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQVtt-0000e3-HW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 13:43:49 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FQVtq-0003KY-Nx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 13:43:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 336D5B0586
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  3 Apr 2006 21:43:33 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04354-20 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Mon,  3 Apr 2006 21:43:29 +0100 (BST)
Received: from [192.168.0.6] (host-87-74-21-22.bulldogdsl.com [87.74.21.22])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 3C3AE457F7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  3 Apr 2006 21:43:29 +0100 (BST)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ov4y+9KrJUPS2RRyOjEW"
Message-Id: <1144097037.11178.24.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] 2.6.17-rc1 with hardened gcc
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
Date: Mon, 03 Apr 2006 21:43:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net


--=-ov4y+9KrJUPS2RRyOjEW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I thought I'd give it a try.
I guess that these aren't bugs (since switching to non-hardened gcc
fixes most problems) but maybe this is useful to someone?
Otherwise just ignore most issues in this email.
- the configs are available at http://uml.nagafix.co.uk/kernels
- GCC 3.4.5 hardened

First, the good old ASM errors are still here (IIRC there is no easy way
to solve this):
wget
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.17-rc1.tar.bz2
tar -jxf linux-2.6.17-rc1.tar.bz2
mv linux-2.6.17-rc1 linux-2.6.17-rc1-x86
cd linux-2.6.17-rc1-x86
cp ../linux-2.6.16.1-bb1-x86/.config ./
make ARCH=3Dum SUBARCH=3Di386 oldconfig
make ARCH=3Dum SUBARCH=3Di386
(...)
CC      arch/um/kernel/skas/clone.o
arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
arch/um/include/sysdep/stub.h:45: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:66: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:55: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:90: error: can't find a register in class
`BREG' while reloading `asm'
make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2


AMD64 works fully, but there are some warnings during the build:
  CC      arch/um/kernel/uaccess.o
In file included from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:51,
                 from include/linux/prefetch.h:14,
                 from include/linux/list.h:7,
                 from include/linux/wait.h:23,
                 from include/asm/arch/semaphore.h:42,
                 from include/asm/semaphore.h:4,
                 from include/asm/ldt.h:11,
                 from arch/um/include/sysdep/tls.h:25,
                 from arch/um/include/os.h:16,
                 from arch/um/kernel/uaccess.c:12:
include/asm/ptrace.h:82: warning: static declaration of
'arch_switch_to_tt' follows non-static declaration
arch/um/include/kern_util.h:120: warning: previous declaration of
'arch_switch_to_tt' was here
include/asm/ptrace.h:87: warning: static declaration of
'arch_switch_to_skas' follows non-static declaration
arch/um/include/kern_util.h:122: warning: previous declaration of
'arch_switch_to_skas' was here
  CC      arch/um/kernel/um_arch.o
  CC      arch/um/kernel/umid.o
In file included from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:51,
                 from include/linux/prefetch.h:14,
                 from include/linux/list.h:7,
                 from include/linux/wait.h:23,
                 from include/asm/arch/semaphore.h:42,
                 from include/asm/semaphore.h:4,
                 from include/asm/ldt.h:11,
                 from arch/um/include/sysdep/tls.h:25,
                 from arch/um/include/os.h:16,
                 from arch/um/kernel/umid.c:8:
include/asm/ptrace.h:82: warning: static declaration of
'arch_switch_to_tt' follows non-static declaration
arch/um/include/kern_util.h:120: warning: previous declaration of
'arch_switch_to_tt' was here
include/asm/ptrace.h:87: warning: static declaration of
'arch_switch_to_skas' follows non-static declaration
arch/um/include/kern_util.h:122: warning: previous declaration of
'arch_switch_to_skas' was here
  CC      arch/um/kernel/initrd.o
  CC      arch/um/kernel/skas/clone.o
  CC      arch/um/kernel/skas/exec_kern.o
  CC      arch/um/kernel/skas/mem.o
  CC      arch/um/kernel/skas/mmu.o
  CC      arch/um/kernel/skas/process_kern.o
arch/um/kernel/skas/process_kern.c:191:2: warning: #warning Need to look
up userspace_pid by cpu
arch/um/kernel/skas/process_kern.c:197:2: warning: #warning Need to look
up userspace_pid by cpu
arch/um/kernel/skas/process_kern.c:204:2: warning: #warning need to loop
over userspace_pids in kill_off_processes_skas
  CC      arch/um/kernel/skas/syscall.o
(...)
  CC      fs/select.o
fs/select.c: In function `core_sys_select':
fs/select.c:339: warning: assignment from incompatible pointer type
fs/select.c:376: warning: comparison of distinct pointer types lacks a
cast
  CC      fs/fifo.o


Something else I've noticed is that some kernels fail if TT is compiled
in, even though it boots into skas0 or skas3 mode. I guess this isn't
really that important since TT is going to go away.

Finally, congratulations! all the images I have built now work - even
fedora (4 and 5) and opensuse.

Antoine

--=-ov4y+9KrJUPS2RRyOjEW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMYkNrTBrLRG7eDcRAhrJAJ4uLfZ+zFew85z79as3OPJAswymvwCcDxj8
XQ1JAP9NVG9kbZq7VDkmEV0=
=hQ6H
-----END PGP SIGNATURE-----

--=-ov4y+9KrJUPS2RRyOjEW--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
