Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeGCm-0005dN-5M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 10:15:52 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EeGCl-0004RX-GB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 10:15:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 77399B0502
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Nov 2005 00:17:43 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08089-14 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Tue, 22 Nov 2005 00:17:40 +0000 (GMT)
Received: from ant.internal (88-96-60-221.dsl.zen.co.uk [88.96.60.221])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 91D76B0501
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Nov 2005 00:17:40 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1132596931.19269.66.camel@ant.internal>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.15-rc1-mm2 on x86_64 build broken / 2.6.15-rc2 ok
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
Date: Mon, 21 Nov 2005 18:15:31 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

FYI, on a 64-bit host:

make ARCH=um defconfig
make ARCH=um vmlinux
  SYMLINK include/asm-um/ldt.h
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding -O2
-fno-omit-frame-pointer -fno-optimize-sibling-calls -g -D__arch_um__
-DSUBARCH=\"x86_64\" -Dvmap=kernel_vmap
-Din6addr_loopback=kernel_in6addr_loopback -Iarch/um/include
-I/usr/src/linux-2.6.15-rc1-mm2-uml/arch/um/kernel/skas/include
-D_FILE_OFFSET_BITS=64 -fno-builtin -D_GNU_SOURCE -D_LARGEFILE64_SOURCE
-S -o arch/um/user-offsets.s arch/um/sys-x86_64/user-offsets.c
  CHK     arch/um/include/user_constants.h
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-um
  SPLIT   include/linux/autoconf.h -> include/config/*
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding -O2
-fno-omit-frame-pointer -fno-optimize-sibling-calls -g  -D__arch_um__
-DSUBARCH=\"x86_64\" -Iarch/um/include
-I/usr/src/linux-2.6.15-rc1-mm2-uml/arch/um/kernel/skas/include
-Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback
-Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
-fno-unit-at-a-time -U__x86_64__ -fno-builtin -D_LARGEFILE64_SOURCE
-Wdeclaration-after-statement   -nostdinc
-isystem /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/include -D__KERNEL__
-Iinclude  -include include/linux/autoconf.h -S -o
arch/um/kernel-offsets.s arch/um/sys-x86_64/kernel-offsets.c
In file included from arch/um/include/um_mmu.h:17,
                 from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-x86_64/kernel-offsets.c:3:
/usr/src/linux-2.6.15-rc1-mm2-uml/arch/um/kernel/skas/include/mmu-skas.h:11:21: asm/ldt.h: No such file or directory
In file included from arch/um/include/um_mmu.h:17,
                 from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-x86_64/kernel-offsets.c:3:
/usr/src/linux-2.6.15-rc1-mm2-uml/arch/um/kernel/skas/include/mmu-skas.h:19: error: syntax error before "uml_ldt_t"
/usr/src/linux-2.6.15-rc1-mm2-uml/arch/um/kernel/skas/include/mmu-skas.h:19: warning: no semicolon at end of struct or union
In file included from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-x86_64/kernel-offsets.c:3:
arch/um/include/um_mmu.h:25: error: field `skas' has incomplete type
make: *** [arch/um/kernel-offsets.s] Error 1


And although 2.6.15-rc1-mm2 builds fine on x86 hosts, I get this when
cross-compiling it:
make ARCH=um SUBARCH=i386 vmlinux
  CC      arch/um/kernel/skas/clone.o
arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
arch/um/include/sysdep/stub.h:41: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:62: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:51: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:84: error: can't find a register in class
`BREG' while reloading `asm'
make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2

Same error that was mentioned before, this one is gcc getting it wrong I
seem to remember.

Also with patches.tar from sourceforge (dated 18/11/2005), I had to
remove the zero length files as suggested by Rob.
x86 build fails with the same gcc problem as above and the amd64 build
fails (from reading previous posts, I guess this is because ldt isn't
done for x86_64):
  CC      arch/um/kernel/exec_kern.o
arch/um/kernel/exec_kern.c: In function `flush_thread':
arch/um/kernel/exec_kern.c:28: error: structure has no member named
`tls_array'
arch/um/kernel/exec_kern.c:28: error: structure has no member named
`tls_array'
make[1]: *** [arch/um/kernel/exec_kern.o] Error 1
make: *** [arch/um/kernel] Error 2

Last, 2.6.15-rc2 has the same gcc problems for x86, and amd64 fails
with:

  CC      arch/um/sys-x86_64/sysrq.o
  SYMLINK arch/um/sys-x86_64/thunk.S
  AS      arch/um/sys-x86_64/thunk.o
  AR      arch/um/sys-x86_64/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../x86_64-pc-linux-gnu/bin/ld: init/built-in.o: relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
init/built-in.o: could not read symbols: Bad value
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

Which can be worked around by enabling TT mode (or just static link?)
I haven't tried to add -fPIC (not sure where it would go)

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
