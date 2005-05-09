Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVE4T-0008Fn-4y	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 12:37:41 -0700
Received: from www.scgiservices.com ([198.107.3.66] helo=www.sterlingcgi.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DVE4R-0001Qa-JC	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 12:37:40 -0700
Message-ID: <20050509123731.5baibbl64rkgw0c8@www.scgiservices.com>
From: Anthony Brock <brocka@sterlingcgi.com>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
References: <s27f5807.086@ORANGE.OUS.EDU>
In-Reply-To: <s27f5807.086@ORANGE.OUS.EDU>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
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
Date: Mon,  9 May 2005 12:37:31 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Okay, I've downloaded Jeff's patches at applied them (I believe) using "quilt
push -a". I hope that this is the correct command.

I then encountered:


   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   CC      arch/um/kernel/mem.o
arch/um/kernel/mem.c:17:2: invalid preprocessing directive #incldue
arch/um/kernel/mem.c: In function `fixaddr_user_init':
arch/um/kernel/mem.c:203: error: `FIXADDR_USER_END' undeclared (first use in
this function)
arch/um/kernel/mem.c:203: error: (Each undeclared identifier is reported only
once
arch/um/kernel/mem.c:203: error: for each function it appears in.)
arch/um/kernel/mem.c:203: error: `FIXADDR_USER_START' undeclared (first use in
this function)
make[1]: *** [arch/um/kernel/mem.o] Error 1
make: *** [arch/um/kernel] Error 2


I then by-passed this with:

--- arch/um/kernel/mem.c.orig   2005-05-09 12:30:25.000000000 -0700
+++ arch/um/kernel/mem.c        2005-05-09 12:25:03.000000000 -0700
@@ -14,6 +14,7 @@
  #include "asm/fixmap.h"
  #include "asm/pgalloc.h"
  #include "asm/elf.h"
+#include "asm-um/elf-i386.h"
  #include "user_util.h"
  #include "kern_util.h"
  #include "kern.h"

However, I now encounter the following:


   CC      arch/um/sys-i386/ldt.o
arch/um/sys-i386/ldt.c:71:2: warning: #warning Need to look up 
userspace_pid by
cpu
arch/um/sys-i386/ldt.c:123:2: warning: #warning Need to look up 
userspace_pid by
cpu
arch/um/sys-i386/ldt.c: In function `ldt_get_host_info':
arch/um/sys-i386/ldt.c:350: warning: implicit declaration of function
`modify_ldt'
   CC      arch/um/sys-i386/ptrace.o
arch/um/sys-i386/ptrace.c:403: error: parse error before "elf_fpregset_t"
arch/um/sys-i386/ptrace.c:404: warning: function declaration isn't a prototype
arch/um/sys-i386/ptrace.c: In function `dump_fpu':
arch/um/sys-i386/ptrace.c:405: error: `regs' undeclared (first use in this
function)
arch/um/sys-i386/ptrace.c:405: error: (Each undeclared identifier is reported
only once
arch/um/sys-i386/ptrace.c:405: error: for each function it appears in.)
arch/um/sys-i386/ptrace.c:405: error: `fpu' undeclared (first use in this
function)
make[1]: *** [arch/um/sys-i386/ptrace.o] Error 1
make: *** [arch/um/sys-i386] Error 2


Any ideas?

Tony

Quoting Anthony Brock <brocka@sterlingcgi.com>:
> First, I would appreciate it if someone can remind me of where to 
> download the
> '-mm' tree.
>
> Second, I downloaded at attempted to compile 2.6.12-rc4. Unfortunately, I'm
> unable to compile it due to the following error:
>
>    HOSTCC  scripts/kallsyms
>    HOSTCC  scripts/bin2c
>    CC      init/main.o
> In file included from arch/um/include/um_uaccess.h:17,
>                   from include/asm/uaccess.h:33,
>                   from include/asm/unistd.h:11,
>                   from include/linux/unistd.h:9,
>                   from init/main.c:46:
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h: In
> function `verify_area_skas':
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24:
> error:
> `FIXADDR_USER_START' undeclared (first use in this function)
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24:
> error:
> (Each undeclared identifier is reported only once
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24:
> error:
> for each function it appears in.)
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24:
> error:
> `FIXADDR_USER_END' undeclared (first use in this function)
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
>
> Pointers are appreciated! In the mean time, I'll see if I can figure out a
> work-around.
>
> Tony



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
