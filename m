Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkBF2-0007Kn-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 18:10:40 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EkBEz-0005Gb-PR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 18:10:40 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1134007824.32598.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.4.32-bs2
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
Date: Thu, 08 Dec 2005 02:10:24 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>

All,

Talking about tty logging and fake ide reminded of the current state of
UML on 2.4 kernels:
http://uml.nagafix.co.uk/uml-2.4.32-bs2.patch.bz2
Is Blaisorblade's 2.4.28-bs2 patch tweaked to apply cleanly on 2.4.32.
Plus another tweak to avoid duplicated symbols when linking with newer
libc.a, the patch is based on this one:
http://seclists.org/lists/linux-kernel/2004/Nov/1048.html
But I'm not sure I did it right, so please check it (bottom of this
email is the modified Makefile)

/usr/lib/libc.a: could not read symbols: Bad value
Any idea why that is? It happens when I use:
i686-pc-linux-gnu-3.4.4-vanilla
but not with:
i686-pc-linux-gnu-3.3.6-vanilla
Problem is that the resulting kernel cannot be executed!
$ kernel32-2.4.32-bs2: cannot execute binary file

The other problem with this patch is that I can't get it to compile with
SUBARCH=i386 on amd64.
(even though -bs2 contains a SUBARCH fix - maybe I didn't merge it
properly?)

# make ARCH=um SUBARCH=i386 linux
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um && ln
-sf ../asm-i386 arch
cd /uml/kernels/src/linux-2.4.32-bs2/arch/um/include && ln -sf
sysdep-i386 sysdep
cd arch/um && ln -sf os-Linux os
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um/ ; \
ln -sf archparam-i386.h archparam.h
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um/ ; \
ln -sf system-i386.h system.h
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um/ ; \
ln -sf sigcontext-i386.h sigcontext.h
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um/ ; \
ln -sf processor-i386.h processor.h
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um/ ; \
ln -sf ptrace-i386.h ptrace.h
cd /uml/kernels/src/linux-2.4.32-bs2/include/asm-um/ ; \
ln -sf arch-signal-i386.h arch-signal.h
sed 's/ CONFIG/
UML_CONFIG/' /uml/kernels/src/linux-2.4.32-bs2/include/linux/autoconf.h
> arch/um/include/uml-config.h
make -C arch/um/sys-i386/util mk_sc
make[1]: Entering directory
`/uml/kernels/src/linux-2.4.32-bs2/arch/um/sys-i386/util'
gcc -c mk_sc.c
mk_sc.c: In function `main':
mk_sc.c:21: error: structure has no member named `eip'
mk_sc.c:22: error: structure has no member named `esp'
mk_sc.c:25: error: structure has no member named `ds'
mk_sc.c:26: error: structure has no member named `es'
mk_sc.c:27: error: structure has no member named `ss'
mk_sc.c:30: error: structure has no member named `eax'
mk_sc.c:31: error: structure has no member named `ebx'
mk_sc.c:32: error: structure has no member named `ecx'
mk_sc.c:33: error: structure has no member named `edx'
mk_sc.c:34: error: structure has no member named `edi'
mk_sc.c:35: error: structure has no member named `esi'
mk_sc.c:36: error: structure has no member named `ebp'
mk_sc.c:42: error: structure has no member named `cw'
mk_sc.c:43: error: structure has no member named `sw'
mk_sc.c:44: error: structure has no member named `tag'
mk_sc.c:45: error: structure has no member named `ipoff'
mk_sc.c:46: error: structure has no member named `cssel'
mk_sc.c:47: error: structure has no member named `dataoff'
mk_sc.c:48: error: structure has no member named `datasel'
mk_sc.c:50: error: structure has no member named `_fxsr_env'
make[1]: *** [mk_sc.o] Error 1
make[1]: Leaving directory
`/uml/kernels/src/linux-2.4.32-bs2/arch/um/sys-i386/util'
make: *** [arch/um/sys-i386/util/mk_sc] Error 2

Any ideas?

Antoine

Here is the modified Makefile
$ cat linux-2.4.32-bs2/arch/um/kernel/tt/Makefile
#
# Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
# Licensed under the GPL
#

O_TARGET = tt.o

obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o
process_kern.o \
        syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o
\
        uaccess.o uaccess_user.o

extra-y := unmap_fin.o
clean-files := unmap_tmp.o

obj-$(CONFIG_PT_PROXY) += gdb_kern.o

subdir-y = sys-$(SUBARCH)
subdir-$(CONFIG_PT_PROXY) += ptproxy

obj-y += $(join $(subdir-y),$(subdir-y:%=/%.o))

export-objs = ksyms.o

USER_OBJS = $(filter %_user.o,$(obj-y)) gdb.o time.o tracer.o

UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,
$(UNMAP_CFLAGS))

include $(TOPDIR)/Rules.make

$(USER_OBJS) : %.o: %.c
        $(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<

$(O_TARGET) : unmap_fin.o

unmap.o: unmap.c
        $(CC) $(UNMAP_CFLAGS) -c -o $@ $<

unmap_fin.o : unmap.o
        ld -r -o unmap_tmp.o unmap.o -lc -L/usr/lib
        objcopy unmap_tmp.o unmap_fin.o -G switcheroo

clean :



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
