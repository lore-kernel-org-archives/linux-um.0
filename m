Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EShQh-0004Qc-9A	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Oct 2005 13:54:27 -0700
Received: from mail12.syd.optusnet.com.au ([211.29.132.193])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EShQf-00080d-Pv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Oct 2005 13:54:27 -0700
Received: from [192.168.1.20] (c210-49-175-223.mckinn1.vic.optusnet.com.au
	[210.49.175.223])j9KKsFMP024317
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Oct 2005 06:54:15 +1000
Subject: Re: [uml-devel] 2.6.13.4-bs4 released - fixes for SKAS0 problems -
	careful about COW
From: Phill Wombat <uml@webwombat.com>
In-Reply-To: <200510151325.50461.blaisorblade@yahoo.it>
References: <200510151325.50461.blaisorblade@yahoo.it>
Content-Type: text/plain; charset="utf-8"
Message-Id: <1129841654.10146.14.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Fri, 21 Oct 2005 06:54:14 +1000
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi List,

Start the process of compiling 2.6.13.4-bs4.

x86_64 host, i386 UML.

Using same config as successful 2.6.12.5-bb12-skas0.

Some compile errors encountered:

================ SNIP ======================
  SYMLINK arch/um/sys-i386/bitops.c
  CC      arch/um/sys-i386/bitops.o
  CC      arch/um/sys-i386/bugs.o
  AS      arch/um/sys-i386/checksum.o
  CC      arch/um/sys-i386/delay.o
  CC      arch/um/sys-i386/fault.o
  CC      arch/um/sys-i386/ksyms.o
  CC      arch/um/sys-i386/ldt.o
  CC      arch/um/sys-i386/ptrace.o
  CC      arch/um/sys-i386/ptrace_user.o
  SYMLINK arch/um/sys-i386/semaphore.c
  CC      arch/um/sys-i386/semaphore.o
  CC      arch/um/sys-i386/signal.o
  CC      arch/um/sys-i386/sigcontext.o
  AS      arch/um/sys-i386/stub.o
  CC      arch/um/sys-i386/stub_segv.o
In file included from /usr/include/asm/sigcontext.h:7,
                 from arch/um/sys-i386/stub_segv.c:7:
/usr/include/asm-i386/sigcontext.h:18: error: redefinition of ‘struct _fpreg’
/usr/include/asm-i386/sigcontext.h:23: error: redefinition of ‘struct _fpxreg’
/usr/include/asm-i386/sigcontext.h:29: error: redefinition of ‘struct _xmmreg’
/usr/include/asm-i386/sigcontext.h:33: error: redefinition of ‘struct _fpstate’
/usr/include/asm-i386/sigcontext.h:57: error: redefinition of ‘struct sigcontext’
make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 1
make: *** [arch/um/sys-i386] Error 2
  CHK     include/linux/version.h
make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.
gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fno-omit-frame-pointer -fno-optimize-sibling-calls -g  -D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include  -I/home/phill/linux-2.6.13/arch/um/kernel/tt/include  -I/home/phill/linux-2.6.13/arch/um/kernel/skas/include -Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time -m32 -U__i386__ -Ui386  -D_LARGEFILE64_SOURCE -Wdeclaration-after-statement -Wno-pointer-sign  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.0.1/include -D__KERNEL__ -Iinclude  -S -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
  CHK     arch/um/kernel-offsets.h
make[1]: `arch/um/sys-i386/util/mk_thread' is up to date.
  CC [M]  arch/um/drivers/hostaudio_kern.o
  LD [M]  arch/um/drivers/hostaudio.o
================ SNIP ======================

Regards
Phill.

On Sat, 2005-10-15 at 13:25 +0200, Blaisorblade wrote:
> Ok, I've batched together the existing fixes and released -bs4.
> It's really nice, it fixes various problems, as indicated on the website. But 
> it also restores the 2.6.12 COW format (see below) - so please beware to your 
> COW files!
> 
> Changelog follows
> 
> * -bs3 didn't apply on top of 2.6.13.3, because one of his patches was merged 
> in it. So remove it from -bs. 
> 
> * CAREFUL : 2.6.13 kernel changed the COW format from all previous kernels in 
> an unintended way (and it wasn't our fault). -bs4 restores the previous 
> format, but this means you likely won't be able to use the same COW files 
> when switching from any 2.6.13 to -bs4; but -bs4 has the same format as any 
> <= 2.6.12 or >= 2.6.14 UML kernel. 
> 
> *  fix compilation of UML on x86_64 with SKAS0 
> 
> * fix compilation of UML on i386 without SKAS mode 
> 
> * fix SKAS0 mode assembly code - this could stop it from working on some old 
> GCC compilers (this happened, for instance, on GCC 3.2.3, and on RH 9).
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
