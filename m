Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0l3-0002YC-4n for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:34:05 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed0l2-0005T4-LV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:34:05 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511180048.06213.rob@landley.net>
	<200511180826.53596.blaisorblade@yahoo.it>
In-Reply-To: <200511180826.53596.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180133.52547.rob@landley.net>
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
Date: Fri, 18 Nov 2005 01:33:52 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 18 November 2005 01:26, Blaisorblade wrote:
> On Friday 18 November 2005 07:48, Rob Landley wrote:
> > On Thursday 17 November 2005 21:12, Jeff Dike wrote:
> > > On Thu, Nov 17, 2005 at 04:51:33PM -0600, Rob Landley wrote:
> > > > find . -name asm
> > >
> > > This all looks the same as I have here, except for the asm-i386 thing,
> > > which I don't think matters.  ldt.h seems to be at the center of this,
> > > so can you check the following:
> > >  asm-i386/ldt.h contains a struct user_desc
> >
> > Yup.
> >
> > >  asm-um includes asm/arch/ldt.h
> >
> > There's no asm subdirectory under asm-um.
>
> Jeff meant that inside asm-um you should have a "arch" symlink to
> "../asm-i386",

Yeah, that's there, a symlink to ~source/include/asm-i386

> and that include/asm/arch/ldt.h should exist (in the source 
> tree root).

Well, from the obj directory there's include/asm/arch/ldt.h (704 bytes).

> > >  asm-um/ldt.h contains a typedef of uml_ldt_t
> >
> > asm-um/ldt.h is a 0 byte file.
>
> Damnit! Do rm on it and things will work (Makefiles will create a symlink
> to ldt-$(SUBARCH) in its place). We had this problem in the past, and
> exactly for a mis-formed patch with quilt.

Should I delete all of them, then?

find . -size 0b
./arch/um/drivers/ubd_user.c
./arch/um/include/signal_user.h
./arch/um/include/time_user.h
./arch/um/include/umid.h
./arch/um/kernel/irq_user.c
./arch/um/kernel/signal_user.c
./arch/um/kernel/skas/include/mm_id.h
./arch/um/kernel/skas/include/mmu-skas.h
./arch/um/kernel/skas/include/mode-skas.h
./arch/um/kernel/skas/include/proc_mm.h
./arch/um/kernel/skas/include/skas.h
./arch/um/kernel/skas/include/stub-data.h
./arch/um/kernel/skas/include/uaccess-skas.h
./arch/um/kernel/skas/include/mode_kern_skas.h
./arch/um/kernel/skas/mem_user.c
./arch/um/kernel/skas/process.c
./arch/um/kernel/skas/trap_user.c
./arch/um/kernel/time.c
./arch/um/kernel/trap_user.c
./arch/um/kernel/tt/include/debug.h
./arch/um/kernel/tt/include/mmu-tt.h
./arch/um/kernel/tt/include/mode_kern-tt.h
./arch/um/kernel/tt/include/tt.h
./arch/um/kernel/tt/include/uaccess-tt.h
./arch/um/kernel/tty_log.c
./arch/um/kernel/user_util.c
./fs/hostfs/Makefile
./fs/hostfs/hostfs.h
./fs/hostfs/hostfs_kern.c
./fs/hostfs/hostfs_user.c
./include/asm-um/ldt.h

Let's see...

find . -size 0b | xargs rm

Oh that's a _much_ happier build.  It's got various warnings about iplicit 
declarations and unused variables but none of those big long chains of "in 
file included from" and the build made it all the way to the link stage 
before dying: 

  CC      lib/semaphore-sleepers.o
  CC      lib/sha1.o
  CC      lib/string.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/um/sys-i386/built-in.o(.text+0x3b60): In function `load_TLS':
: undefined reference to `indirect_set_thread_area'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make[2]: *** [.tmp_kallsyms1.S] Error 1
make[1]: *** [_all] Error 2
make: *** [all] Error 2

This is progress!

What would you like next from me?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
