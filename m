Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElWji-000885-KQ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 11:19:54 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ElWjg-0000iG-Mc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Dec 2005 11:19:54 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512111747.30441.blaisorblade@yahoo.it>
References: <1134007824.32598.48.camel@localhost.localdomain>
	<200512111747.30441.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1134328772.29209.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.4.32-bs2
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
Date: Sun, 11 Dec 2005 19:19:32 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, 2005-12-11 at 17:47 +0100, Blaisorblade wrote:
> On Thursday 08 December 2005 03:10, Antoine Martin wrote:
> > All,
> >
> > Talking about tty logging and fake ide reminded of the current state of
> > UML on 2.4 kernels:
> > http://uml.nagafix.co.uk/uml-2.4.32-bs2.patch.bz2
> > Is Blaisorblade's 2.4.28-bs2 patch tweaked to apply cleanly on 2.4.32.
> 
> There should be (I think) just offsets, not even fuzzes, so there should be no 
> problem.
There were some offsets and one empty reject, so no real problem.

> > Plus another tweak to avoid duplicated symbols when linking with newer
> > libc.a, the patch is based on this one:
> > http://seclists.org/lists/linux-kernel/2004/Nov/1048.html
> > But I'm not sure I did it right, so please check it (bottom of this
> > email is the modified Makefile)
> 
> Seems correct for what I can see. Ah, no, there's a 2.4 / 2.6 conversion 
> problem, see below.
> 
> > /usr/lib/libc.a: could not read symbols: Bad value
> 
> I'd like to see the exact cmd line producing this. Possibly seeing also gcc -v 
> output with that cmd line would help.
# gcc -v -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc
-Wl,--wrap,free -Wl,--wrap,calloc         -o linux arch/um/main.o
vmlinux.o -L/usr/lib -lutil
Reading specs from /usr/lib/gcc/i686-pc-linux-gnu/3.4.4/specs
Configured with: /var/tmp/portage/gcc-3.4.4-r1/work/gcc-3.4.4/configure
--prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.4.4
--includedir=/usr/lib/gcc/i686-pc-linux-gnu/3.4.4/include
--datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.4.4
--mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.4.4/man
--infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.4.4/info
--with-gxx-include-dir=/usr/lib/gcc/i686-pc-linux-gnu/3.4.4/include/g
++-v3 --host=i686-pc-linux-gnu --build=i686-pc-linux-gnu
--disable-altivec --enable-nls --without-included-gettext
--with-system-zlib --disable-checking --disable-werror
--disable-libunwind-exceptions --disable-multilib --disable-libmudflap
--disable-libgcj --enable-languages=c,c++ --enable-shared
--enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
Thread model: posix
gcc version 3.4.4 (Gentoo Hardened 3.4.4-r1, HTB-3.4.4-1.00,
ssp-3.4.4-1.0, pie-8.7.8)
 /usr/libexec/gcc/i686-pc-linux-gnu/3.4.4/collect2 -m elf_i386 -static
-z relro -z now -o
linux /usr/lib/gcc/i686-pc-linux-gnu/3.4.4/../../../crt1.o /usr/lib/gcc/i686-pc-linux-gnu/3.4.4/../../../crti.o /usr/lib/gcc/i686-pc-linux-gnu/3.4.4/crtbeginT.o -L/usr/lib -L/usr/lib/gcc/i686-pc-linux-gnu/3.4.4 -L/usr/lib/gcc/i686-pc-linux-gnu/3.4.4 -L/usr/lib/gcc/i686-pc-linux-gnu/3.4.4/../../../../i686-pc-linux-gnu/lib -L/usr/lib/gcc/i686-pc-linux-gnu/3.4.4/../../.. -T arch/um/link.ld --wrap malloc --wrap free --wrap calloc arch/um/main.o vmlinux.o -lutil --start-group -lgcc -lgcc_eh -lc --end-group /usr/lib/gcc/i686-pc-linux-gnu/3.4.4/crtend.o /usr/lib/gcc/i686-pc-linux-gnu/3.4.4/../../../crtn.o
/usr/lib/libc.a: could not read symbols: Bad value
collect2: ld returned 1 exit status

> (After seeing if there's anything strange with the file itself, but I think 
> you can compile on the same box some 
> 
> > Any idea why that is? It happens when I use:
> > i686-pc-linux-gnu-3.4.4-vanilla
> > but not with:
> > i686-pc-linux-gnu-3.3.6-vanilla 
Trying again today with 3.3.6, I get a new warning (bcmp) and the same
error. I have no idea what I've done different!

gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free
-Wl,--wrap,calloc \
        -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
/usr/lib/libc.a(memcmp.o): In function `bcmp':
../sysdeps/i386/i686/memcmp.S:(.text+0x0): multiple definition of
`memcmp'
vmlinux.o:/usr/src/linux-2.4.32-bs2/lib/string.c:452: first defined here
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/../../../../i686-pc-linux-gnu/bin/ld: Warning: size of symbol `memcmp' changed from 53 in vmlinux.o to 128 in /usr/lib/libc.a(memcmp.o)
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/libgcc.a: could not read
symbols: Bad value
collect2: ld returned 1 exit status
make: *** [linux] Error 1


> 
> The first thing I'd do there (since this is the fscking 2.4, not the shining 
> 2.6) is doing a make mrproper ARCH=um between the two compiles... 2.4 kbuild 
> was so erratic that even recently I was bitten from it, too... I started 
> writing a patch (missing export_symbol, I thought) to discover that a) the 
> code seemed right and b) the code _was_ right.
(Good way to waste some time ;) I have used mrproper.

> Afterwards I'd be curious if some strange Gentoo thing is mixing 
> runtime .so/.a libraries of the two compilers (I've had this happening for 
> c++, and programs crashing after linking with both gcc 3.3 and gcc 3.4 stdc++ 
> libraries - fix_libtool_files.sh on Gentoo was my friend in the end). Note 
> that you need to be especially lucky to trigger this - of the whole KDE 
> 3.4.3, most was linked this way, but only "juk" suffered.
fix_libtool_files.sh did fix some libs when I upgraded to 3.4 - but did
not help in this case.

> No idea, I'll look at it a bit (maybe), but it's very strange. Note that I 
> recall compiling that with GCC 3.4.x (.3?) - I wanted to support 3.4 when 
> releasing -bs2.
> 
> > Problem is that the resulting kernel cannot be executed!
> > $ kernel32-2.4.32-bs2: cannot execute binary file
> 
> file vmlinux-* and/or dmesg|tail would maybe help on what was going on.
/home/viper/kernel32-2.4.32-bs2: ELF 32-bit LSB relocatable, Intel
80386, version 1 (SYSV), not stripped

(nothing in dmesg)
> 
> > The other problem with this patch is that I can't get it to compile with
> > SUBARCH=i386 on amd64.
> > (even though -bs2 contains a SUBARCH fix - maybe I didn't merge it
> > properly?)
> 
> Hmm, I never compiled 2.4 kernels on x86_64 machines. Probably I backported 
> just an earlier attempt - in fact I thought I'd done it on 2.6, but until I 
> started testing it, it didn't work.
Not to worry, I just thought it was meant to work.
How would I go about building a 32-bit pcap enabled kernel in the
chroot? Do I copy the pcap.a from outside the chroot?

> For that, I'm sorry but you need a chroot - just too much work and I've not 
> the time to work on this.
2.4 is not worth spending too much time on anyway.

> > Here is the modified Makefile
> 
> Next time send a patch (even cut 'n' paste, but a patch).
I almost did, but the patch was twice as long... will do next time.

> > $ cat linux-2.4.32-bs2/arch/um/kernel/tt/Makefile
> > #
> > # Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
> > # Licensed under the GPL
> > #
> >
> > O_TARGET = tt.o
> >
> > obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o
> > process_kern.o \
> >         syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o
> > \
> >         uaccess.o uaccess_user.o
> 
> > extra-y := unmap_fin.o
> > clean-files := unmap_tmp.o
> 
> Get rid of these lines, they didn't exist. Extra-y must be expressed, but ok, 
> it's already coded (see below). (clean-files is for make clean).
ok

> > obj-$(CONFIG_PT_PROXY) += gdb_kern.o
> >
> > subdir-y = sys-$(SUBARCH)
> > subdir-$(CONFIG_PT_PROXY) += ptproxy
> >
> > obj-y += $(join $(subdir-y),$(subdir-y:%=/%.o))
> >
> > export-objs = ksyms.o
> >
> > USER_OBJS = $(filter %_user.o,$(obj-y)) gdb.o time.o tracer.o
> >
> > UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
> > UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,
> > $(UNMAP_CFLAGS))
> >
> > include $(TOPDIR)/Rules.make
> >
> > $(USER_OBJS) : %.o: %.c
> >         $(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
> 
> USER_CFLAGS and CFLAGS_$@ are in the wrong order, the latter must be able to 
> override the former. Not that it should be a problem here... (and it's even 
> in the original, so don't worry).
I've swapped them.

> > $(O_TARGET) : unmap_fin.o
> 
> The above is the (approximate) equivalent of extra-y setting.
> 
> > unmap.o: unmap.c
> >         $(CC) $(UNMAP_CFLAGS) -c -o $@ $<
> >
> > unmap_fin.o : unmap.o
> >         ld -r -o unmap_tmp.o unmap.o -lc -L/usr/lib
> >         objcopy unmap_tmp.o unmap_fin.o -G switcheroo
I'll send a patch when the whole thing works.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
