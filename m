Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbOgX-0004h3-Vf
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 10:33:41 -0800
Received: from deliver.epitech.net ([163.5.0.25])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AbOgX-0008Ly-FX
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 10:33:41 -0800
Received: from epita.fr ([10.42.1.60])
 by deliver.epitech.net (SAVSMTP 3.1.2.35) with SMTP id M2003123019322723777
 for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Dec 2003 19:32:27 +0100
Received: from carpediem (carpediem.epita.fr [10.42.42.5])
	by epita.fr id hBUIXWh20561 for user-mode-linux-devel@lists.sourceforge.net 
	EPITA Paris France Tue, 30 Dec 2003 19:33:32 +0100 (CET)
From: jeremie le-hen <le-hen_j@epita.fr>
Message-ID: <20031230183331.GB2845@carpediem.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UML + skas
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 30 Dec 2003 19:33:31 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I have just subscribed to this list because I found a strange bug while
compiling an UML within an SKAS'd host.  Here is the problem :

(my host is a 2.4.23 kernel with the SKAS patch released on 2002/11/11)

--- cut here ---

droopy:tmp$ wget -q http://heanet.dl.sourceforge.net/sourceforge/user-mode-linux/uml-patch-2.4.23-1.bz2
droopy:tmp$ bzip2 -d uml-patch-2.4.23-1.bz2 
droopy:tmp$ wget -q http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.23.tar.bz2
droopy:tmp$ tar xfj linux-2.4.23.tar.bz2 
droopy:tmp$ cd linux-2.4.23
droopy:linux-2.4.23$ patch -p1 < ../uml-patch-2.4.23-1 
[... no error ...]
droopy:linux-2.4.23$ make menuconfig ARCH=um
[... do not change anything, just quit ...]
droopy:linux-2.4.23$ make dep ARCH=um
[...]
droopy:linux-2.4.23$ make linux ARCH=um
[...]
gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  -I/space/kernel/tmp/linux-2.4.23/arch/um/include -I/space/kernel/tmp/linux-2.4.23/arch/um/kernel/tt/include -I/space/kernel/tmp/linux-2.4.23/arch/um/kernel/skas/include -D_GNU_SOURCE -c -o process.o process.c
[...]
In file included from process.c:27:
/space/kernel/tmp/linux-2.4.23/arch/um/include/skas_ptrace.h:9: redefinition of `struct ptrace_faultinfo'
/space/kernel/tmp/linux-2.4.23/arch/um/include/skas_ptrace.h:14: redefinition of `struct ptrace_ldt'
make[3]: *** [process.o] Error 1
[...]

--- cut here ---


After preprocessing the process.c file, I found that
`struct ptrace_faultinfo' and `struct ptrace_ldt' were first defined
in file `/usr/include/asm/ptrace.h' and then in
`arch/um/include/skas_ptrace.h'.  Since `/usr/include/asm/' is a symlink
in  `/usr/src/linux/` which in turn points to my kernel source, I thought
that it was maybe due to some tricky patch I have applied on my host's
kernel.  So I used a clean kernel source instead, and I made
`/usr/include/asm/' point in it.  And everything compiled perfectly.

Therefore I went through my various patches to see which one modified
`asm-i386/ptrace.h'.  And what a surprise when I saw the following in
`host-skas3.patch' :


--- cut here ---

diff -urN linux-2.4.23/include/asm-i386/ptrace.h linux-2.4.23-host_skas3_20031111/include/asm-i386/ptrace.h
--- linux-2.4.23/include/asm-i386/ptrace.h      2001-09-14 23:04:08.000000000 +0200
+++ linux-2.4.23-host_skas3_20031111/include/asm-i386/ptrace.h  2003-12-04 21:08:46.000000000 +0100
@@ -51,6 +51,22 @@
 
 #define PTRACE_SETOPTIONS         21
 
+struct ptrace_faultinfo {
+       int is_write;
+       unsigned long addr;
+};
+
+struct ptrace_ldt {
+       int func;
+       void *ptr;
+       unsigned long bytecount;
+};
+
+#define PTRACE_FAULTINFO 52
+#define PTRACE_SIGPENDING 53
+#define PTRACE_LDT 54
+#define PTRACE_SWITCH_MM 55

--- cut here ---

This is *exactly* the same content as `arch/um/include/skas_ptrace.h'.
From what I googled, it seems to be a known bug.  But it think it would
not be very difficult to make some #define protection around theses
structures to prevent from changing the destination of `/usr/src/linux/'
to a source without the SKAS patch applied.

Regards,
-- 
Jeremie LE HEN aka TtZ/TataZ                          jeremie.le-hen@epita.fr
                                                                 ttz@epita.fr
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
