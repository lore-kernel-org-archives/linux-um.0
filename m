Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dg4xa-0000ny-78	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 11:07:26 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Dg4xU-0006qT-MY	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Jun 2005 11:07:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
	<200506080234.29043.blaisorblade@yahoo.it> <87mzq03g1d.fsf@amaterasu.srvr.nix>
In-Reply-To: <87mzq03g1d.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jSzpCo2am1yf2gw"
Message-Id: <200506082010.43040.blaisorblade@yahoo.it>
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
Date: Wed, 8 Jun 2005 20:10:42 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>

--Boundary-00=_jSzpCo2am1yf2gw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 08 June 2005 19:38, Nix wrote:
> On Wed, 8 Jun 2005, blaisorblade@yahoo.it said:
> > On Tuesday 07 June 2005 21:47, Nix wrote:
> >> On Tue, 7 Jun 2005, blaisorblade@yahoo.it suggested tentatively:
> >> > On Tuesday 07 June 2005 18:21, Nix wrote:
> >> >> OK, so it's a -static TT build that's failing?
> >> >
> >> > Exactly.
> >>
> >> Built, with a randomly selected .config (that is, a .config I use for
> >> other things, not a .config with the values set at random!)
> >
> > Hmm, broken-out in the archives works perfectly (with patch-scripts). Go
> > until uml-link-tt-mode-against-nptl.patch and retry, and possibly even
> > with the previous one... please.
>
> OK, will do.
>
> >> With that applied, it builds...
> >>
> >> ... and segfaults almost at once on invocation:
> >>
> >> execve("./vmlinux", ["./vmlinux"], [/* 49 vars */]) = 0
> >> uname({sys="Linux", node="hades", ...}) = 0
> >> brk(0)                                  = 0xa0343000
> >> brk(0xa0343834)                         = 0xa0343834
> >> set_thread_area({entry_number:-1 -> 6, base_addr:0xa034381c,
> >> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
> >> limit_in_pages:1,
> >> seg_not_present:0, useable:1}) = 0 --- SIGSEGV (Segmentation fault) @ 0
> >> (0)
> >
> > Hmm, gdb would be more helpful... I was getting a SIGBUS somewhere on
> > x86_64 (with a native binary) here, and maybe it could be the same thing
> > (no, it can't, your error is different, so I'm talking to myself):
>
> Unlikely: this isn't an x86-64 box ;}
No, I thought it was a general error...

> > And here is the memory map... whoops! The code is trying to read from
> > 60c00000, which is mapped... but from an absurd address! And from a
> > different file from all the rest!

> [snip]
>
> > 60c00000-a2000000 rwxs ffffffffc0c00000 00:0e
> > 1383102                    /tmp/vm_file-JmW1nY (deleted)

> Whaa?
Yes, strange offset... it's what I noted too.

> >> Looks like a thread initialization problem to *me*. And there be very
> >> serious and nasty snarling dragons with sharp pointy carborundum teeth

> > This kind of problems is normally caused from wrong alignments in the
> > linker script.

> I'm not surprised it dies: even ld can see that something's wrong. With
> V=1 we see this:

>         gcc -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc -o
> vmlinux -Wl,-T,arch/um/kernel/vmlinux.lds   init/built-in.o
> -Wl,--start-group  usr/built-in.o  arch/um/kernel/built-in.o 
> arch/um/drivers/built-in.o  arch/um/os-Linux/built-in.o 
> arch/um/sys-i386/built-in.o  arch/i386/crypto/built-in.o  kernel/built-in.o
>  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o 
> crypto/built-in.o  lib/lib.a  lib/built-in.o  drivers/built-in.o 
> sound/built-in.o  net/built-in.o -Wl,--end-group -lutil .tmp_kallsyms3.o ;
> rm -f linux /usr/bin/ld: BFD 2.16.90.0.3 20050510 assertion fail elf.c:3833
Only with V=1 the error is shown? Strange! Also, why the hell is this 
assertion failing, in normal words? Is he complaining for the (now 
missing) .thread_private section?

Also, would you be able to fix problems like "allocated 5 headers, needed 6" 
or such? What are the criteria for choosing how many headers to allocate?

> which is the assertion here, inside
> bfd/elf.c:map_sections_to_segments():
>
>   /* If there are any SHF_TLS output sections, add PT_TLS segment.  */
>   if (tls_count > 0)
>     {
>       int i;
>
>       amt = sizeof (struct elf_segment_map);
>       amt += (tls_count - 1) * sizeof (asection *);
>       m = bfd_zalloc (abfd, amt);
>       if (m == NULL)
> 	goto error_return;
>       m->next = NULL;
>       m->p_type = PT_TLS;
>       m->count = tls_count;
>       /* Mandated PF_R.  */
>       m->p_flags = PF_R;
>       m->p_flags_valid = 1;
>       for (i = 0; i < tls_count; ++i)
> 	{
> 	  BFD_ASSERT (first_tls->flags & SEC_THREAD_LOCAL);
> 	  m->sections[i] = first_tls;
> 	  first_tls = first_tls->next;
> 	}
>
>       *pm = m;
>       pm = &m->next;
>     }

> > Btw, I forgot that broken-out is in perfect state and would help more for
> > debug...
>
> I'll try that next.
Here I've attached the patch that today worked for me; it replaces the one 
with the same name, and I applied until it.

Please, take care that there is no dependency yet from unmap_fin.o to vmlinux, 
so modifying that file won't show up in the final result unless you either 
tocuh arch/um/kernel/vmlinux.lds or (untested) rm .tmp_vmlinux1.

> > Global warming, isn't it? However don't worry, the Gulf Current is going
> > to stop so you'll get refreshed of -10 degrees...

> Excellent. Bring back the ice age!

> (Hm. My house wouldn't stand up well under a kilometre of ice...)
Everybody gets a free new house! Global warming is the next killer application 
for house building!
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_jSzpCo2am1yf2gw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-link-tt-mode-against-nptl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-link-tt-mode-against-nptl.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

To make sure switcheroo() can execute when we remap all the executable image,
we used a trick to make it use a local copy of errno... this trick does not
work with NPTL glibc, only with LinuxThreads, so use another (simpler) one to
make it work anyway.

Hopefully, a lot improved thanks to merging with the version of Al Viro (which
had his part of problems, though, i.e. removing a fix to another bug and not
fixing the problem on i386).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Makefile               |    2 -
 linux-2.6.git-paolo/arch/um/kernel/tt/Makefile     |   15 ----------
 linux-2.6.git-paolo/arch/um/kernel/uml.lds.S       |   15 ++--------
 linux-2.6.git-paolo/arch/um/scripts/Makefile.rules |    6 ++++
 linux-2.6.git-paolo/arch/um/scripts/Makefile.unmap |   22 ++++++++++++++
 linux-2.6.git-paolo/arch/um/sys-i386/Makefile      |    2 +
 linux-2.6.git-paolo/arch/um/sys-i386/unmap.c       |   25 ++++++++++++++++
 linux-2.6.git-paolo/arch/um/sys-x86_64/Makefile    |    2 +
 linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c     |   25 ++++++++++++++++
 linux-2.6.git/arch/um/kernel/tt/unmap.c            |   31 ---------------------
 10 files changed, 86 insertions(+), 59 deletions(-)

diff -L arch/um/kernel/tt/unmap.c -puN arch/um/kernel/tt/unmap.c~uml-link-tt-mode-against-nptl /dev/null
--- linux-2.6.git/arch/um/kernel/tt/unmap.c
+++ /dev/null	2005-03-04 21:12:55.000000000 +0100
@@ -1,31 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <sys/mman.h>
-
-int switcheroo(int fd, int prot, void *from, void *to, int size)
-{
-	if(munmap(to, size) < 0){
-		return(-1);
-	}
-	if(mmap(to, size, prot,	MAP_SHARED | MAP_FIXED, fd, 0) != to){
-		return(-1);
-	}
-	if(munmap(from, size) < 0){
-		return(-1);
-	}
-	return(0);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/uml.lds.S~uml-link-tt-mode-against-nptl arch/um/kernel/uml.lds.S
--- linux-2.6.git/arch/um/kernel/uml.lds.S~uml-link-tt-mode-against-nptl	2005-06-07 19:10:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/uml.lds.S	2005-06-07 19:10:51.000000000 +0200
@@ -14,19 +14,10 @@ SECTIONS
   /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
    * is remapped.*/
   __binary_start = .;
-#ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
-  . = ALIGN(4096);
-  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
 
-  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
-   * is off the resulting binary segfaults.*/
+#ifdef MODE_TT
+  .remap_data : { arch/um/sys-SUBARCH/unmap_fin.o (.data .bss) }
+  .remap : { arch/um/sys-SUBARCH/unmap_fin.o (.text) }
 
   . = ALIGN(4096);		/* Init code and data */
 #endif
diff -puN /dev/null arch/um/sys-i386/unmap.c
--- /dev/null	2005-03-04 21:12:55.000000000 +0100
+++ linux-2.6.git-paolo/arch/um/sys-i386/unmap.c	2005-06-07 19:10:51.000000000 +0200
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/mman.h>
+#include <asm/unistd.h>
+
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+int switcheroo(int fd, int prot, void *from, void *to, int size)
+{
+	if(munmap(to, size) < 0){
+		return(-1);
+	}
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+		return(-1);
+	}
+	if(munmap(from, size) < 0){
+		return(-1);
+	}
+	return(0);
+}
diff -puN /dev/null arch/um/sys-x86_64/unmap.c
--- /dev/null	2005-03-04 21:12:55.000000000 +0100
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c	2005-06-07 19:10:51.000000000 +0200
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/mman.h>
+#include <asm/unistd.h>
+
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+int switcheroo(int fd, int prot, void *from, void *to, int size)
+{
+	if(munmap(to, size) < 0){
+		return(-1);
+	}
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+		return(-1);
+	}
+	if(munmap(from, size) < 0){
+		return(-1);
+	}
+	return(0);
+}
diff -puN arch/um/kernel/tt/Makefile~uml-link-tt-mode-against-nptl arch/um/kernel/tt/Makefile
--- linux-2.6.git/arch/um/kernel/tt/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 19:10:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/Makefile	2005-06-07 19:10:51.000000000 +0200
@@ -3,10 +3,6 @@
 # Licensed under the GPL
 #
 
-extra-y := unmap_fin.o
-targets := unmap.o
-clean-files := unmap_tmp.o
-
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
 	uaccess.o uaccess_user.o
@@ -16,14 +12,3 @@ obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptp
 USER_OBJS := gdb.o time.o tracer.o
 
 include arch/um/scripts/Makefile.rules
-
-UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
-UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,$(UNMAP_CFLAGS))
-
-#XXX: partially copied from arch/um/scripts/Makefile.rules
-$(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)
-
-$(obj)/unmap_fin.o : $(obj)/unmap.o
-	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a)
-	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
-
diff -puN arch/um/sys-i386/Makefile~uml-link-tt-mode-against-nptl arch/um/sys-i386/Makefile
--- linux-2.6.git/arch/um/sys-i386/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 19:10:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/Makefile	2005-06-07 19:10:51.000000000 +0200
@@ -15,3 +15,5 @@ bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
+
+include arch/um/scripts/Makefile.unmap
diff -puN arch/um/sys-x86_64/Makefile~uml-link-tt-mode-against-nptl arch/um/sys-x86_64/Makefile
--- linux-2.6.git/arch/um/sys-x86_64/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 19:10:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/Makefile	2005-06-07 19:10:51.000000000 +0200
@@ -29,3 +29,5 @@ thunk.S-dir = lib
 module.c-dir = kernel
 
 subdir- := util
+
+include arch/um/scripts/Makefile.unmap
diff -puN /dev/null arch/um/scripts/Makefile.unmap
--- /dev/null	2005-03-04 21:12:55.000000000 +0100
+++ linux-2.6.git-paolo/arch/um/scripts/Makefile.unmap	2005-06-07 19:10:51.000000000 +0200
@@ -0,0 +1,22 @@
+clean-files += unmap_tmp.o unmap_fin.o unmap.o
+
+ifdef CONFIG_MODE_TT
+
+#Always build unmap_fin.o
+extra-y += unmap_fin.o
+#Do dependency tracking for unmap.o (it will be always built, but won't get the tracking unless we use this).
+targets += unmap.o
+
+#XXX: partially copied from arch/um/scripts/Makefile.rules
+$(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
+
+quiet_cmd_wrapld = LD      $@
+define cmd_wrapld
+	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a); \
+	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
+endef
+
+$(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
+	$(call if_changed,wrapld)
+
+endif
diff -puN arch/um/Makefile~uml-link-tt-mode-against-nptl arch/um/Makefile
--- linux-2.6.git/arch/um/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 19:10:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Makefile	2005-06-07 19:10:51.000000000 +0200
@@ -118,7 +118,7 @@ endif
 CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE-y) \
-	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
+	-DKERNEL_STACK_SIZE=$(STACK_SIZE) -DSUBARCH=$(SUBARCH))
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff -puN arch/um/scripts/Makefile.rules~uml-link-tt-mode-against-nptl arch/um/scripts/Makefile.rules
--- linux-2.6.git/arch/um/scripts/Makefile.rules~uml-link-tt-mode-against-nptl	2005-06-07 19:10:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/scripts/Makefile.rules	2005-06-07 19:10:51.000000000 +0200
@@ -10,6 +10,12 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 $(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	$(CFLAGS_$(notdir $@))
 
+# The stubs and unmap.o can't try to call mcount or update basic block data
+define unprofile
+	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
+endef
+
+
 quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
 
_

--Boundary-00=_jSzpCo2am1yf2gw--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
