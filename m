Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-user] Re: [uml-devel] UML patches against vanilla 2.6.0
In-Reply-To: <3FEF045C.90204@libero.it>
Message-ID: <Pine.LNX.4.58.0312290134530.7861@boston.corp.fedex.com>
References: <200312261905.48277.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0312280851350.2434@boston.corp.fedex.com> <3FEF045C.90204@libero.it>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-625012358-1072633584=:7861"
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
Date: Mon, 29 Dec 2003 01:46:24 +0800 (SGT)
To: Domenico Andreoli <cavok@libero.it>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net



--0-625012358-1072633584=:7861
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Sun, 28 Dec 2003, Domenico Andreoli wrote:

> > Here's my patch against Ingo Molnar's uml-combo-2.6.0-A5 patch to make the
> > patch works if you use reiser4 ...
> ehm... i was not able to apply this patch...

sorry, 1st wasn't a "diff -u". Attached should be the correct one
(uml-combo-2.6.0-A5b.patch). Again, apply this patch to
uml-combo-2.6.0-A5, then patch the kernel.


> > After that patch, it'll be followed by another patch pointed out by
> > BlaisorBlade ...
> ... and also this. maybe it's a problem with cut&paste...

Ok, second patch is attached as well (uml-combo-2.6.0-A5b.uml)

I've also attached my uml .config. CONFIG_MODVERSIONS works. SKAS works
too.


Jeff

--0-625012358-1072633584=:7861
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="uml-combo-2.6.0-A5b.patch"
Content-ID: <Pine.LNX.4.58.0312290146240.7861@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename="uml-combo-2.6.0-A5b.patch"
Content-Transfer-Encoding: quoted-printable

--- uml-combo-2.6.0-A5	Tue Dec 23 20:48:31 2003
+++ uml-combo-2.6.0-A5b	Sun Dec 28 09:03:59 2003
@@ -157,7 +157,7 @@
  	}
 =20
 -	down=5Fwrite(&current->mm->mmap=5Fsem);
--	error =3D do=5Fmmap=5Fpgoff(file, addr, len, prot, flags, pgoff);
+-	error =3D do=5Fmmap=5Fpgoff(current->mm, file, addr, len, prot, flags, p=
goff);
 -	up=5Fwrite(&current->mm->mmap=5Fsem);
 +	down=5Fwrite(&mm->mmap=5Fsem);
 +	error =3D do=5Fmmap=5Fpgoff(mm, file, addr, len, prot, flags, pgoff);
@@ -6706,47 +6706,6 @@
    .data    :
    {
      . =3D ALIGN(KERNEL=5FSTACK=5FSIZE);		/* init=5Ftask */
---- linux/include/linux/mm.h.orig=09
-+++ linux/include/linux/mm.h=09
-@@ -487,6 +487,9 @@ static inline int set=5Fpage=5Fdirty(struct=20
- 	return =5F=5Fset=5Fpage=5Fdirty=5Fbuffers(page);
- }
-=20
-+extern long do=5Fmprotect(struct mm=5Fstruct *mm, unsigned long start,=20
-+			size=5Ft len, unsigned long prot);
-+
- /*
-  * On a two-level page table, this ends up being trivial. Thus the
-  * inlining and the symmetry break with pte=5Falloc=5Fmap() that does all
-@@ -517,9 +520,15 @@ extern void exit=5Fmmap(struct mm=5Fstruct *
-=20
- extern unsigned long get=5Funmapped=5Farea(struct file *, unsigned long, =
unsigned long, unsigned long, unsigned long);
-=20
--extern unsigned long do=5Fmmap=5Fpgoff(struct file *file, unsigned long a=
ddr,
--	unsigned long len, unsigned long prot,
--	unsigned long flag, unsigned long pgoff);
-+extern long do=5Fmmap2(struct mm=5Fstruct *mm, unsigned long addr,
-+		     unsigned long len, unsigned long prot,
-+		     unsigned long flags, unsigned long fd,
-+		     unsigned long pgoff);
-+
-+extern unsigned long do=5Fmmap=5Fpgoff(struct mm=5Fstruct *mm, struct fil=
e *file,=20
-+				   unsigned long addr, unsigned long len,
-+				   unsigned long prot, unsigned long flag,
-+				   unsigned long pgoff);
-=20
- static inline unsigned long do=5Fmmap(struct file *file, unsigned long ad=
dr,
- 	unsigned long len, unsigned long prot,
-@@ -529,7 +538,8 @@ static inline unsigned long do=5Fmmap(stru
- 	if ((offset + PAGE=5FALIGN(len)) < offset)
- 		goto out;
- 	if (!(offset & ~PAGE=5FMASK))
--		ret =3D do=5Fmmap=5Fpgoff(file, addr, len, prot, flag, offset >> PAGE=
=5FSHIFT);
-+		ret =3D do=5Fmmap=5Fpgoff(current->mm, file, addr, len, prot, flag,=20
-+				    offset >> PAGE=5FSHIFT);
- out:
- 	return ret;
- }
 --- linux/include/linux/proc=5Fmm.h.orig=09
 +++ linux/include/linux/proc=5Fmm.h=09
 @@ -0,0 +1,48 @@
@@ -9756,93 +9715,8 @@
  obj-$(CONFIG=5FSWAP)	+=3D page=5Fio.o swap=5Fstate.o swapfile.o
 +obj-$(CONFIG=5FPROC=5FMM)	+=3D proc=5Fmm.o
 +
---- linux/mm/memory.c.orig=09
-+++ linux/mm/memory.c=09
-@@ -44,6 +44,7 @@
- #include <linux/highmem.h>
- #include <linux/pagemap.h>
- #include <linux/rmap-locking.h>
-+#include <linux/init.h>
- #include <linux/module.h>
-=20
- #include <asm/pgalloc.h>
-@@ -680,6 +681,24 @@ static inline struct page *get=5Fpage=5Fmap(
- }
-=20
-=20
-+static struct vm=5Farea=5Fstruct fixmap=5Fvma =3D {
-+	/* Catch users - if there are any valid
-+	   ones, we can make this be "&init=5Fmm" or
-+	   something.  */
-+	.vm=5Fmm =3D NULL,
-+	.vm=5Fpage=5Fprot =3D PAGE=5FREADONLY,
-+	.vm=5Fflags =3D VM=5FREAD | VM=5FEXEC,
-+};
-+
-+static int init=5Ffixmap=5Fvma(void)
-+{
-+	fixmap=5Fvma.vm=5Fstart =3D FIXADDR=5FSTART;
-+	fixmap=5Fvma.vm=5Fend =3D FIXADDR=5FTOP;
-+	return(0);
-+}
-+
-+=5F=5Finitcall(init=5Ffixmap=5Fvma);
-+
- int get=5Fuser=5Fpages(struct task=5Fstruct *tsk, struct mm=5Fstruct *mm,
- 		unsigned long start, int len, int write, int force,
- 		struct page **pages, struct vm=5Farea=5Fstruct **vmas)
-@@ -700,19 +719,8 @@ int get=5Fuser=5Fpages(struct task=5Fstruct *t
-=20
- 		vma =3D find=5Fextend=5Fvma(mm, start);
-=20
--#ifdef FIXADDR=5FUSER=5FSTART
--		if (!vma &&
--		    start >=3D FIXADDR=5FUSER=5FSTART && start < FIXADDR=5FUSER=5FEND) {
--			static struct vm=5Farea=5Fstruct fixmap=5Fvma =3D {
--				/* Catch users - if there are any valid
--				   ones, we can make this be "&init=5Fmm" or
--				   something.  */
--				.vm=5Fmm =3D NULL,
--				.vm=5Fstart =3D FIXADDR=5FUSER=5FSTART,
--				.vm=5Fend =3D FIXADDR=5FUSER=5FEND,
--				.vm=5Fpage=5Fprot =3D PAGE=5FREADONLY,
--				.vm=5Fflags =3D VM=5FREAD | VM=5FEXEC,
--			};
-+#ifdef FIXADDR=5FSTART
-+		if (!vma && start >=3D FIXADDR=5FSTART && start < FIXADDR=5FTOP) {
- 			unsigned long pg =3D start & PAGE=5FMASK;
- 			pgd=5Ft *pgd;
- 			pmd=5Ft *pmd;
---- linux/mm/mmap.c.orig=09
-+++ linux/mm/mmap.c=09
-@@ -462,11 +462,11 @@ static int vma=5Fmerge(struct mm=5Fstruct *m
-  * The caller must hold down=5Fwrite(current->mm->mmap=5Fsem).
-  */
-=20
--unsigned long do=5Fmmap=5Fpgoff(struct file * file, unsigned long addr,
--			unsigned long len, unsigned long prot,
--			unsigned long flags, unsigned long pgoff)
-+unsigned long do=5Fmmap=5Fpgoff(struct mm=5Fstruct *mm, struct file * fil=
e,=20
-+			    unsigned long addr, unsigned long len,
-+			    unsigned long prot, unsigned long flags,
-+			    unsigned long pgoff)
- {
--	struct mm=5Fstruct * mm =3D current->mm;
- 	struct vm=5Farea=5Fstruct * vma, * prev;
- 	struct inode *inode;
- 	unsigned int vm=5Fflags;
 --- linux/mm/mprotect.c.orig=09
 +++ linux/mm/mprotect.c=09
-@@ -222,7 +222,8 @@ fail:
- }
-=20
- asmlinkage long
--sys=5Fmprotect(unsigned long start, size=5Ft len, unsigned long prot)
-+do=5Fmprotect(struct mm=5Fstruct *mm, unsigned long start, size=5Ft len, =

-+	     unsigned long prot)
- {
- 	unsigned long vm=5Fflags, nstart, end, tmp;
- 	struct vm=5Farea=5Fstruct * vma, * next, * prev;
 @@ -245,9 +246,9 @@ sys=5Fmprotect(unsigned long start, size=5Ft
 =20
  	vm=5Fflags =3D calc=5Fvm=5Fprot=5Fbits(prot);
@@ -9855,19 +9729,6 @@
  	error =3D -ENOMEM;
  	if (!vma)
  		goto out;
-@@ -326,6 +327,11 @@ sys=5Fmprotect(unsigned long start, size=5Ft
- 		prev->vm=5Fmm->map=5Fcount--;
- 	}
- out:
--	up=5Fwrite(&current->mm->mmap=5Fsem);
-+	up=5Fwrite(&mm->mmap=5Fsem);
- 	return error;
- }
-+
-+asmlinkage long sys=5Fmprotect(unsigned long start, size=5Ft len, unsigne=
d long prot)
-+{
-+        return(do=5Fmprotect(current->mm, start, len, prot));
-+}
 --- linux/mm/proc=5Fmm.c.orig=09
 +++ linux/mm/proc=5Fmm.c=09
 @@ -0,0 +1,163 @@

--0-625012358-1072633584=:7861
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="uml-combo-2.6.0-A5b.uml"
Content-ID: <Pine.LNX.4.58.0312290146241.7861@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename="uml-combo-2.6.0-A5b.uml"
Content-Transfer-Encoding: quoted-printable

--- uml/include/asm/ptrace-generic.h	Sat Dec 27 23:18:48 2003
+++ uml.good/include/asm/ptrace-generic.h	Sat Dec 27 11:42:52 2003
@@ -15,7 +15,7 @@
 #define pt=5Fregs pt=5Fregs=5Fsubarch
 #define show=5Fregs show=5Fregs=5Fsubarch
=20
-#include "asm/arch/ptrace.h"
+//#include "asm/arch/ptrace.h"
=20
 #undef pt=5Fregs
 #undef show=5Fregs
--- uml/arch/um/sys-i386/bugs.c.org	Sat Dec 27 23:28:01 2003
+++ uml/arch/um/sys-i386/bugs.c	Sat Dec 27 23:29:19 2003
@@ -16,6 +16,9 @@
=20
 #define MAXTOKEN 64
=20
+extern int modify=5Fldt(int func, void *ptr, unsigned long bytecount);
+
+
 /* Set during early boot */
 int host=5Fhas=5Fcmov =3D 1;
 int host=5Fhas=5Fxmm =3D 0;
@@ -107,7 +110,7 @@
=20
 static void disable=5Flcall(void)
 {
-	struct modify=5Fldt=5Fldt=5Fs ldt;
+	struct user=5Fdesc ldt;
 	int err;
=20
 	bzero(&ldt, sizeof(ldt));
--- uml/arch/um/sys-i386/ptrace=5Fuser.c	Thu Dec 18 10:58:28 2003
+++ uml.good/arch/um/sys-i386/ptrace=5Fuser.c	Sat Dec 27 11:57:03 2003
@@ -15,6 +15,28 @@
 #include "user.h"
 #include "os.h"
=20
+#define PTRACE=5FTRACEME             0
+#define PTRACE=5FPEEKTEXT            1
+#define PTRACE=5FPEEKDATA            2
+#define PTRACE=5FPEEKUSR             3
+#define PTRACE=5FPOKETEXT            4
+#define PTRACE=5FPOKEDATA            5
+#define PTRACE=5FPOKEUSR             6
+#define PTRACE=5FCONT                7
+#define PTRACE=5FKILL                8
+#define PTRACE=5FSINGLESTEP          9
+
+#define PTRACE=5FATTACH           0x10
+#define PTRACE=5FDETACH           0x11
+
+#define PTRACE=5FSYSCALL            24
+
+#define PTRACE=5FFAULTINFO          52
+#define PTRACE=5FSIGPENDING         53
+#define PTRACE=5FLDT                54
+#define PTRACE=5FSWITCH=5FMM          55
+
+
 int ptrace=5Fgetregs(long pid, unsigned long *regs=5Fout)
 {
 	return(ptrace(PTRACE=5FGETREGS, pid, 0, regs=5Fout));
--- uml/arch/um/sys-i386/ptrace=5Fuser.c.org	Sat Dec 27 23:47:53 2003
+++ uml/arch/um/sys-i386/ptrace=5Fuser.c	Sat Dec 27 23:48:49 2003
@@ -7,8 +7,9 @@
 #include <errno.h>
 #include <unistd.h>
 #include <linux/stddef.h>
-#include <sys/ptrace.h>
-#include <asm/ptrace.h>
+//#include <sys/ptrace.h>
+#include <linux/ptrace.h>
+//#include <asm/ptrace.h>
 #include <asm/user.h>
 #include "kern=5Futil.h"
 #include "sysdep/thread.h"
--- uml/arch/um/kernel/syscall=5Fkern.c.org	Sat Dec 27 23:59:53 2003
+++ uml/arch/um/kernel/syscall=5Fkern.c	Sun Dec 28 00:07:54 2003
@@ -76,7 +76,7 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flag,
 				unsigned long pgoff) {
-	return do=5Fmmap=5Fpgoff(file, addr, len, prot, flag, pgoff);
+	return do=5Fmmap=5Fpgoff(mm, file, addr, len, prot, flag, pgoff);
 }
 #endif
=20
--- uml/arch/i386/kernel/sys=5Fi386.c.org	Sun Dec 28 00:12:31 2003
+++ uml/arch/i386/kernel/sys=5Fi386.c	Sun Dec 28 00:12:54 2003
@@ -40,15 +40,6 @@
 }
=20
 /* See this definition in arch/um/kernel/syscall=5Fkern.c for comments.*/
-#ifndef CONFIG=5FPROC=5FMM
-static inline unsigned long =5F=5Fdo=5Fmmap=5Fpgoff(
-				struct mm=5Fstruct *mm, struct file *file,=20
-				unsigned long addr, unsigned long len,
-				unsigned long prot, unsigned long flag,
-				unsigned long pgoff) {
-	return do=5Fmmap=5Fpgoff(file, addr, len, prot, flag, pgoff);
-}
-#endif
=20
 /* common code for old and new mmaps */
 long do=5Fmmap2(struct mm=5Fstruct *mm,
--- uml/mm/mmap.c.org	Sun Dec 28 00:17:14 2003
+++ uml/mm/mmap.c	Sun Dec 28 00:17:43 2003
@@ -714,7 +714,7 @@
 	return error;
 }
=20
-EXPORT=5FSYMBOL(=5F=5Fdo=5Fmmap=5Fpgoff);
+EXPORT=5FSYMBOL(do=5Fmmap=5Fpgoff);
=20
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=3D0.

--0-625012358-1072633584=:7861
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=".config"
Content-ID: <Pine.LNX.4.58.0312290146242.7861@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG=5FUSERMODE=3Dy
CONFIG=5FMMU=3Dy
CONFIG=5FUID16=3Dy
CONFIG=5FRWSEM=5FGENERIC=5FSPINLOCK=3Dy

#
# UML-specific options
#
# CONFIG=5FMODE=5FTT is not set
# CONFIG=5FSTATIC=5FLINK is not set
CONFIG=5FMODE=5FSKAS=3Dy
CONFIG=5FNET=3Dy
CONFIG=5FBINFMT=5FELF=3Dy
CONFIG=5FBINFMT=5FMISC=3Dm
CONFIG=5FHOSTFS=3Dy
CONFIG=5FHPPFS=3Dy
CONFIG=5FMCONSOLE=3Dy
# CONFIG=5FMAGIC=5FSYSRQ is not set
# CONFIG=5FHOST=5F2G=5F2G is not set
# CONFIG=5FUML=5FSMP is not set
# CONFIG=5FSMP is not set
CONFIG=5FNEST=5FLEVEL=3D0
CONFIG=5FKERNEL=5FHALF=5FGIGS=3D1
# CONFIG=5FHIGHMEM is not set
# CONFIG=5FPROC=5FMM is not set
CONFIG=5FKERNEL=5FSTACK=5FORDER=3D2

#
# Code maturity level options
#
CONFIG=5FEXPERIMENTAL=3Dy
CONFIG=5FCLEAN=5FCOMPILE=3Dy
CONFIG=5FSTANDALONE=3Dy
CONFIG=5FBROKEN=5FON=5FSMP=3Dy

#
# General setup
#
CONFIG=5FSWAP=3Dy
CONFIG=5FSYSVIPC=3Dy
# CONFIG=5FBSD=5FPROCESS=5FACCT is not set
CONFIG=5FSYSCTL=3Dy
CONFIG=5FLOG=5FBUF=5FSHIFT=3D14
# CONFIG=5FIKCONFIG is not set
# CONFIG=5FEMBEDDED is not set
CONFIG=5FKALLSYMS=3Dy
CONFIG=5FFUTEX=3Dy
CONFIG=5FEPOLL=3Dy
CONFIG=5FIOSCHED=5FNOOP=3Dy
CONFIG=5FIOSCHED=5FAS=3Dy
CONFIG=5FIOSCHED=5FDEADLINE=3Dy

#
# Loadable module support
#
CONFIG=5FMODULES=3Dy
CONFIG=5FMODULE=5FUNLOAD=3Dy
CONFIG=5FMODULE=5FFORCE=5FUNLOAD=3Dy
CONFIG=5FOBSOLETE=5FMODPARM=3Dy
CONFIG=5FMODVERSIONS=3Dy
CONFIG=5FKMOD=3Dy

#
# Generic Driver Options
#

#
# Character Devices
#
CONFIG=5FSTDIO=5FCONSOLE=3Dy
CONFIG=5FSSL=3Dy
CONFIG=5FFD=5FCHAN=3Dy
CONFIG=5FNULL=5FCHAN=3Dy
CONFIG=5FPORT=5FCHAN=3Dy
CONFIG=5FPTY=5FCHAN=3Dy
CONFIG=5FTTY=5FCHAN=3Dy
CONFIG=5FXTERM=5FCHAN=3Dy
CONFIG=5FCON=5FZERO=5FCHAN=3D"fd:0,fd:1"
CONFIG=5FCON=5FCHAN=3D"xterm"
CONFIG=5FSSL=5FCHAN=3D"pty"
CONFIG=5FUNIX98=5FPTYS=3Dy
CONFIG=5FUNIX98=5FPTY=5FCOUNT=3D256
# CONFIG=5FWATCHDOG is not set
CONFIG=5FUML=5FSOUND=3Dy
CONFIG=5FSOUND=3Dy
CONFIG=5FHOSTAUDIO=3Dy

#
# Block Devices
#
CONFIG=5FBLK=5FDEV=5FUBD=3Dy
# CONFIG=5FBLK=5FDEV=5FUBD=5FSYNC is not set
CONFIG=5FBLK=5FDEV=5FCOW=5FCOMMON=3Dy
CONFIG=5FBLK=5FDEV=5FLOOP=3Dm
# CONFIG=5FBLK=5FDEV=5FNBD is not set
CONFIG=5FBLK=5FDEV=5FRAM=3Dy
CONFIG=5FBLK=5FDEV=5FRAM=5FSIZE=3D32768
CONFIG=5FBLK=5FDEV=5FINITRD=3Dy
# CONFIG=5FMMAPPER is not set
CONFIG=5FNETDEVICES=3Dy

#
# UML Network Devices
#
CONFIG=5FUML=5FNET=3Dy
CONFIG=5FUML=5FNET=5FETHERTAP=3Dy
CONFIG=5FUML=5FNET=5FTUNTAP=3Dy
# CONFIG=5FUML=5FNET=5FSLIP is not set
CONFIG=5FUML=5FNET=5FDAEMON=3Dy
CONFIG=5FUML=5FNET=5FMCAST=3Dy
# CONFIG=5FUML=5FNET=5FPCAP is not set
# CONFIG=5FUML=5FNET=5FSLIRP is not set

#
# Networking support
#

#
# Networking options
#
CONFIG=5FPACKET=3Dy
CONFIG=5FPACKET=5FMMAP=3Dy
# CONFIG=5FNETLINK=5FDEV is not set
CONFIG=5FUNIX=3Dy
# CONFIG=5FNET=5FKEY is not set
CONFIG=5FINET=3Dy
CONFIG=5FIP=5FMULTICAST=3Dy
CONFIG=5FIP=5FADVANCED=5FROUTER=3Dy
CONFIG=5FIP=5FMULTIPLE=5FTABLES=3Dy
CONFIG=5FIP=5FROUTE=5FFWMARK=3Dy
CONFIG=5FIP=5FROUTE=5FNAT=3Dy
# CONFIG=5FIP=5FROUTE=5FMULTIPATH is not set
# CONFIG=5FIP=5FROUTE=5FTOS is not set
CONFIG=5FIP=5FROUTE=5FVERBOSE=3Dy
# CONFIG=5FIP=5FPNP is not set
CONFIG=5FNET=5FIPIP=3Dm
# CONFIG=5FNET=5FIPGRE is not set
# CONFIG=5FIP=5FMROUTE is not set
# CONFIG=5FARPD is not set
CONFIG=5FINET=5FECN=3Dy
CONFIG=5FSYN=5FCOOKIES=3Dy
# CONFIG=5FINET=5FAH is not set
# CONFIG=5FINET=5FESP is not set
# CONFIG=5FINET=5FIPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG=5FIP=5FVS is not set
# CONFIG=5FIPV6 is not set
# CONFIG=5FDECNET is not set
# CONFIG=5FBRIDGE is not set
CONFIG=5FNETFILTER=3Dy
# CONFIG=5FNETFILTER=5FDEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG=5FIP=5FNF=5FCONNTRACK=3Dm
CONFIG=5FIP=5FNF=5FFTP=3Dm
CONFIG=5FIP=5FNF=5FIRC=3Dm
CONFIG=5FIP=5FNF=5FTFTP=3Dm
# CONFIG=5FIP=5FNF=5FAMANDA is not set
# CONFIG=5FIP=5FNF=5FQUEUE is not set
CONFIG=5FIP=5FNF=5FIPTABLES=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FLIMIT=3Dm
# CONFIG=5FIP=5FNF=5FMATCH=5FIPRANGE is not set
CONFIG=5FIP=5FNF=5FMATCH=5FMAC=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FPKTTYPE=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FMARK=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FMULTIPORT=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FTOS=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FRECENT=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FECN=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FDSCP=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FAH=5FESP=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FLENGTH=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FTTL=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FTCPMSS=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FHELPER=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FSTATE=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FCONNTRACK=3Dm
CONFIG=5FIP=5FNF=5FMATCH=5FOWNER=3Dm
CONFIG=5FIP=5FNF=5FFILTER=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FREJECT=3Dm
CONFIG=5FIP=5FNF=5FNAT=3Dm
CONFIG=5FIP=5FNF=5FNAT=5FNEEDED=3Dy
CONFIG=5FIP=5FNF=5FTARGET=5FMASQUERADE=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FREDIRECT=3Dm
# CONFIG=5FIP=5FNF=5FTARGET=5FNETMAP is not set
# CONFIG=5FIP=5FNF=5FTARGET=5FSAME is not set
CONFIG=5FIP=5FNF=5FNAT=5FLOCAL=3Dy
# CONFIG=5FIP=5FNF=5FNAT=5FSNMP=5FBASIC is not set
CONFIG=5FIP=5FNF=5FNAT=5FIRC=3Dm
CONFIG=5FIP=5FNF=5FNAT=5FFTP=3Dm
CONFIG=5FIP=5FNF=5FNAT=5FTFTP=3Dm
CONFIG=5FIP=5FNF=5FMANGLE=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FTOS=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FECN=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FDSCP=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FMARK=3Dm
# CONFIG=5FIP=5FNF=5FTARGET=5FCLASSIFY is not set
CONFIG=5FIP=5FNF=5FTARGET=5FLOG=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FULOG=3Dm
CONFIG=5FIP=5FNF=5FTARGET=5FTCPMSS=3Dm
# CONFIG=5FIP=5FNF=5FARPTABLES is not set
# CONFIG=5FIP=5FNF=5FCOMPAT=5FIPCHAINS is not set
# CONFIG=5FIP=5FNF=5FCOMPAT=5FIPFWADM is not set
CONFIG=5FXFRM=3Dy
# CONFIG=5FXFRM=5FUSER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG=5FIPV6=5FSCTP=5F=5F=3Dy
# CONFIG=5FIP=5FSCTP is not set
# CONFIG=5FATM is not set
# CONFIG=5FVLAN=5F8021Q is not set
# CONFIG=5FLLC2 is not set
# CONFIG=5FIPX is not set
# CONFIG=5FATALK is not set
# CONFIG=5FX25 is not set
# CONFIG=5FLAPB is not set
# CONFIG=5FNET=5FDIVERT is not set
# CONFIG=5FECONET is not set
# CONFIG=5FWAN=5FROUTER is not set
# CONFIG=5FNET=5FFASTROUTE is not set
# CONFIG=5FNET=5FHW=5FFLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG=5FNET=5FSCHED is not set

#
# Network testing
#
# CONFIG=5FNET=5FPKTGEN is not set
CONFIG=5FDUMMY=3Dm
CONFIG=5FBONDING=3Dm
CONFIG=5FEQUALIZER=3Dm
CONFIG=5FTUN=3Dm

#
# Ethernet (10 or 100Mbit)
#
# CONFIG=5FNET=5FETHERNET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#
# CONFIG=5FPPP is not set
# CONFIG=5FSLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG=5FNET=5FRADIO is not set

#
# Token Ring devices
#
# CONFIG=5FSHAPER is not set

#
# Wan interfaces
#
# CONFIG=5FWAN is not set

#
# Amateur Radio support
#
# CONFIG=5FHAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG=5FIRDA is not set

#
# Bluetooth support
#
# CONFIG=5FBT is not set

#
# File systems
#
CONFIG=5FEXT2=5FFS=3Dy
# CONFIG=5FEXT2=5FFS=5FXATTR is not set
CONFIG=5FEXT3=5FFS=3Dm
CONFIG=5FEXT3=5FFS=5FXATTR=3Dy
# CONFIG=5FEXT3=5FFS=5FPOSIX=5FACL is not set
# CONFIG=5FEXT3=5FFS=5FSECURITY is not set
CONFIG=5FJBD=3Dm
# CONFIG=5FJBD=5FDEBUG is not set
CONFIG=5FFS=5FMBCACHE=3Dy
CONFIG=5FREISER4=5FFS=3Dy
# CONFIG=5FREISER4=5FFS=5FSYSCALL is not set
CONFIG=5FREISER4=5FLARGE=5FKEY=3Dy
# CONFIG=5FREISER4=5FCHECK is not set
CONFIG=5FREISER4=5FUSE=5FEFLUSH=3Dy
# CONFIG=5FREISER4=5FCOPY=5FON=5FCAPTURE is not set
# CONFIG=5FREISER4=5FBADBLOCKS is not set
CONFIG=5FREISERFS=5FFS=3Dy
# CONFIG=5FREISERFS=5FCHECK is not set
# CONFIG=5FREISERFS=5FPROC=5FINFO is not set
# CONFIG=5FJFS=5FFS is not set
CONFIG=5FFS=5FPOSIX=5FACL=3Dy
# CONFIG=5FXFS=5FFS is not set
# CONFIG=5FMINIX=5FFS is not set
# CONFIG=5FROMFS=5FFS is not set
# CONFIG=5FQUOTA is not set
# CONFIG=5FAUTOFS=5FFS is not set
# CONFIG=5FAUTOFS4=5FFS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG=5FISO9660=5FFS=3Dm
CONFIG=5FJOLIET=3Dy
# CONFIG=5FZISOFS is not set
CONFIG=5FUDF=5FFS=3Dm

#
# DOS/FAT/NT Filesystems
#
CONFIG=5FFAT=5FFS=3Dm
CONFIG=5FMSDOS=5FFS=3Dm
CONFIG=5FVFAT=5FFS=3Dm
CONFIG=5FNTFS=5FFS=3Dm
# CONFIG=5FNTFS=5FDEBUG is not set
CONFIG=5FNTFS=5FRW=3Dy

#
# Pseudo filesystems
#
CONFIG=5FPROC=5FFS=3Dy
CONFIG=5FPROC=5FKCORE=3Dy
# CONFIG=5FDEVFS=5FFS is not set
CONFIG=5FDEVPTS=5FFS=3Dy
# CONFIG=5FDEVPTS=5FFS=5FXATTR is not set
CONFIG=5FTMPFS=3Dy
# CONFIG=5FHUGETLB=5FPAGE is not set
CONFIG=5FRAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG=5FADFS=5FFS is not set
# CONFIG=5FAFFS=5FFS is not set
# CONFIG=5FHFS=5FFS is not set
# CONFIG=5FBEFS=5FFS is not set
# CONFIG=5FBFS=5FFS is not set
# CONFIG=5FEFS=5FFS is not set
# CONFIG=5FCRAMFS is not set
# CONFIG=5FVXFS=5FFS is not set
# CONFIG=5FHPFS=5FFS is not set
# CONFIG=5FQNX4FS=5FFS is not set
# CONFIG=5FSYSV=5FFS is not set
# CONFIG=5FUFS=5FFS is not set

#
# Network File Systems
#
CONFIG=5FNFS=5FFS=3Dm
CONFIG=5FNFS=5FV3=3Dy
# CONFIG=5FNFS=5FV4 is not set
# CONFIG=5FNFS=5FDIRECTIO is not set
CONFIG=5FNFSD=3Dm
CONFIG=5FNFSD=5FV3=3Dy
# CONFIG=5FNFSD=5FV4 is not set
CONFIG=5FNFSD=5FTCP=3Dy
CONFIG=5FLOCKD=3Dm
CONFIG=5FLOCKD=5FV4=3Dy
CONFIG=5FEXPORTFS=3Dm
CONFIG=5FSUNRPC=3Dm
# CONFIG=5FSUNRPC=5FGSS is not set
CONFIG=5FSMB=5FFS=3Dm
CONFIG=5FSMB=5FNLS=5FDEFAULT=3Dy
CONFIG=5FSMB=5FNLS=5FREMOTE=3D"cp437"
# CONFIG=5FCIFS is not set
# CONFIG=5FNCP=5FFS is not set
CONFIG=5FCODA=5FFS=3Dm
# CONFIG=5FCODA=5FFS=5FOLD=5FAPI is not set
# CONFIG=5FINTERMEZZO=5FFS is not set
# CONFIG=5FAFS=5FFS is not set

#
# Partition Types
#
CONFIG=5FPARTITION=5FADVANCED=3Dy
# CONFIG=5FACORN=5FPARTITION is not set
# CONFIG=5FOSF=5FPARTITION is not set
# CONFIG=5FAMIGA=5FPARTITION is not set
# CONFIG=5FATARI=5FPARTITION is not set
# CONFIG=5FMAC=5FPARTITION is not set
CONFIG=5FMSDOS=5FPARTITION=3Dy
# CONFIG=5FBSD=5FDISKLABEL is not set
# CONFIG=5FMINIX=5FSUBPARTITION is not set
# CONFIG=5FSOLARIS=5FX86=5FPARTITION is not set
# CONFIG=5FUNIXWARE=5FDISKLABEL is not set
# CONFIG=5FLDM=5FPARTITION is not set
# CONFIG=5FNEC98=5FPARTITION is not set
# CONFIG=5FSGI=5FPARTITION is not set
# CONFIG=5FULTRIX=5FPARTITION is not set
# CONFIG=5FSUN=5FPARTITION is not set
# CONFIG=5FEFI=5FPARTITION is not set
CONFIG=5FSMB=5FNLS=3Dy
CONFIG=5FNLS=3Dy

#
# Native Language Support
#
CONFIG=5FNLS=5FDEFAULT=3D"iso8859-1"
CONFIG=5FNLS=5FCODEPAGE=5F437=3Dm
# CONFIG=5FNLS=5FCODEPAGE=5F737 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F775 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F850 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F852 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F855 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F857 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F860 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F861 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F862 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F863 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F864 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F865 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F866 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F869 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F936 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F950 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F932 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F949 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F874 is not set
# CONFIG=5FNLS=5FISO8859=5F8 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F1250 is not set
# CONFIG=5FNLS=5FCODEPAGE=5F1251 is not set
CONFIG=5FNLS=5FISO8859=5F1=3Dm
# CONFIG=5FNLS=5FISO8859=5F2 is not set
# CONFIG=5FNLS=5FISO8859=5F3 is not set
# CONFIG=5FNLS=5FISO8859=5F4 is not set
# CONFIG=5FNLS=5FISO8859=5F5 is not set
# CONFIG=5FNLS=5FISO8859=5F6 is not set
# CONFIG=5FNLS=5FISO8859=5F7 is not set
# CONFIG=5FNLS=5FISO8859=5F9 is not set
# CONFIG=5FNLS=5FISO8859=5F13 is not set
# CONFIG=5FNLS=5FISO8859=5F14 is not set
# CONFIG=5FNLS=5FISO8859=5F15 is not set
# CONFIG=5FNLS=5FKOI8=5FR is not set
# CONFIG=5FNLS=5FKOI8=5FU is not set
# CONFIG=5FNLS=5FUTF8 is not set

#
# Security options
#
# CONFIG=5FSECURITY is not set

#
# Cryptographic options
#
# CONFIG=5FCRYPTO is not set

#
# Library routines
#
CONFIG=5FCRC32=3Dm

#
# SCSI support
#
# CONFIG=5FSCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG=5FMD=3Dy
# CONFIG=5FBLK=5FDEV=5FMD is not set
CONFIG=5FBLK=5FDEV=5FDM=3Dm
# CONFIG=5FDM=5FIOCTL=5FV4 is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG=5FMTD is not set

#
# Kernel hacking
#
# CONFIG=5FDEBUG=5FSLAB is not set
# CONFIG=5FDEBUG=5FSPINLOCK is not set
# CONFIG=5FDEBUG=5FINFO is not set

--0-625012358-1072633584=:7861--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
