Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4p9H-0000cO-1a for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 16:13:15 -0700
Received: from mail.stral.net ([61.14.141.91] helo=ns1.stral.net ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C4p9F-0006Lw-IN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 16:13:14 -0700
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
Subject: RE: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0018_01C49584.0534E1F0"
In-reply-to: <20040826020626.GA28471@malice.crymeariver.org>
Message-ID: <E1C4p9F-0006Lw-IN@sc8-sf-mx1.sourceforge.net>
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
Date: Wed, 8 Sep 2004 09:12:38 +1000
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 'David Jeffery' <djeffery@britsys.net>, 'BlaisorBlade' <blaisorblade_spam@yahoo.it>

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C49584.0534E1F0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit

I've been testing out this patch...

It seems it allows me to start a uml-2.6.8.1 with SKAS using libc6-2.3.2.
I'm not sure if programs that make use of NPTL are running correctly though.

Services which I have noticed make good use of NPTL when running on a normal
linux kernel are things such as Bind9 and Java. These both still segfault
when run with this patch.

I have attached strace from bind9 and from trying to start tomcat4 using
blackdown java.

I also reported some problems back in march trying to run bind9 with uml
2.6.4, I'd moved /lib/tls to /lib/notls and Bind9 got stuck in an infinite
loop.

Is there any other information I can provide that may help?

Michael Ralston
Stral.net

> -----Original Message-----
> From: user-mode-linux-devel-admin@lists.sourceforge.net 
> [mailto:user-mode-linux-devel-admin@lists.sourceforge.net] On 
> Behalf Of David Jeffery
> Sent: Thursday, 26 August 2004 12:06 PM
> To: user-mode-linux-devel@lists.sourceforge.net
> Subject: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
> 
> This is a patch against 2.6.8.1-mm4 to fix a skas UML problem 
> with a nptl glibc.
> 
> UML with an nptl enabled glibc causes process creation to 
> fail with this assertion failure in nptl:
> 
> bash: ../nptl/sysdeps/unix/sysv/linux/fork.c:132: 
> __libc_fork: Assertion `({ __typeof (self->tid) __value; if 
> (sizeof (__value) == 1) asm volatile ("movb %%gs:%P2,%b0" : 
> "=q" (__value) : "0" (0), "i" (((size_t) &((struct pthread 
> *)0)->tid))); else if (sizeof (__value) == 4) asm volatile 
> ("movl %%gs:%P1,%0" : "=r" (__value) : "i" (((size_t) 
> &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" 
> (__value) : "i" (((size_t) &((struct pthread *)0)->tid)), "i" 
> (((size_t) &((struct pthread *)0)->tid) + 4)); } __value; }) 
> != ppid' failed.
> 
> The problem is caused by the incorrect implementation of 
> sys_clone().  
> sys_clone() is an ugly beast that has different arguements 
> depending on the architecture.  For i386 and ppc, the child 
> tid is passed as the 5th arguement instead of as the 4th 
> arguement as as some other architectures (like x86-64) do.  
> The 4th arguement on i386 and ppc doesn't look to be used by 
> the kernel.
> 
> With this patch I've been running several UML skas images 
> with a Debian Sarge based systems for several days without 
> problem.  The patch adds a
> sys_clone_5arg() on i386 and ppc which just raps around the current
> sys_clone() so the child tid pointer in the 5th arguement 
> will be passed down correctly.  I don't get any style points 
> for this patch so feel free to pretty it up.
> 
> David Jeffery
> 
> diff -urN linux-2.6.8.1-mm4.orig/arch/um/Makefile 
> linux-2.6.8.1-mm4/arch/um/Makefile
> --- linux-2.6.8.1-mm4.orig/arch/um/Makefile	2004-08-25 
> 20:52:56.000000000 -0400
> +++ linux-2.6.8.1-mm4/arch/um/Makefile	2004-08-22 
> 16:55:52.000000000 -0400
> @@ -59,7 +59,8 @@
>  
>  CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
>  	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
> -	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE)
> +	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE) \
> +	-D__subarch_$(SUBARCH)__
>  
>  CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
>  
> diff -urN 
> linux-2.6.8.1-mm4.orig/arch/um/kernel/sys_call_table.c 
> linux-2.6.8.1-mm4/arch/um/kernel/sys_call_table.c
> --- linux-2.6.8.1-mm4.orig/arch/um/kernel/sys_call_table.c	
> 2004-08-25 20:52:56.000000000 -0400
> +++ linux-2.6.8.1-mm4/arch/um/kernel/sys_call_table.c	
> 2004-08-22 16:55:52.000000000 -0400
> @@ -19,6 +19,12 @@
>  #define NFSSERVCTL sys_ni_syscall
>  #endif
>  
> +#if defined(__subarch_i386__) || defined(__subarch_ppc__) #define 
> +SYS_CLONE sys_clone_5arg #else #define SYS_CLONE sys_clone #endif
> +
>  #define LAST_GENERIC_SYSCALL __NR_vserver
>  
>  #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL @@ -41,6 +47,7 
> @@  extern syscall_handler_t sys_uname;  extern 
> syscall_handler_t sys_ipc;  extern syscall_handler_t sys_sigreturn;
> +extern syscall_handler_t sys_clone_5arg;
>  extern syscall_handler_t sys_clone;
>  extern syscall_handler_t sys_rt_sigreturn;  extern 
> syscall_handler_t sys_rt_sigaction; @@ -177,7 +184,7 @@
>  	[ __NR_ipc ] (syscall_handler_t *) sys_ipc,
>  	[ __NR_fsync ] (syscall_handler_t *) sys_fsync,
>  	[ __NR_sigreturn ] (syscall_handler_t *) sys_sigreturn,
> -	[ __NR_clone ] (syscall_handler_t *) sys_clone,
> +	[ __NR_clone ] (syscall_handler_t *) SYS_CLONE,
>  	[ __NR_setdomainname ] (syscall_handler_t *) sys_setdomainname,
>  	[ __NR_uname ] (syscall_handler_t *) sys_newuname,
>  	[ __NR_adjtimex ] (syscall_handler_t *) sys_adjtimex, 
> diff -urN 
> linux-2.6.8.1-mm4.orig/arch/um/kernel/syscall_kern.c 
> linux-2.6.8.1-mm4/arch/um/kernel/syscall_kern.c
> --- linux-2.6.8.1-mm4.orig/arch/um/kernel/syscall_kern.c	
> 2004-08-25 20:52:56.000000000 -0400
> +++ linux-2.6.8.1-mm4/arch/um/kernel/syscall_kern.c	
> 2004-08-22 16:55:52.000000000 -0400
> @@ -55,6 +55,14 @@
>  	return(ret);
>  }
>  
> +#if defined(__subarch_i386__) || defined(__subarch_ppc__) long 
> +sys_clone_5arg(unsigned long clone_flags, unsigned long newsp,
> +               int *parent_tid, unsigned long unused, int 
> *child_tid) {
> +        return sys_clone(clone_flags, newsp, parent_tid, 
> child_tid); } 
> +#endif
> +
>  long sys_vfork(void)
>  {
>  	long ret;
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on 
> Blank Media 100pk Sonic DVD-R 4x for only $29 -100pk Sonic 
> DVD+R for only $33 Save 50% off Retail on Ink & Toner - Free 
> Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.752 / Virus Database: 503 - Release Date: 3/09/2004
 
    

------=_NextPart_000_0018_01C49584.0534E1F0
Content-Type: text/plain;
	name="blackdown-tomcat-strace.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="blackdown-tomcat-strace.txt"

template:/usr/share/tomcat4/bin# strace -v -F =
/usr/lib/j2se/1.4//bin/java =
-Djava.endorsed.dirs=3D/usr/share/tomcat4/common/endorsed -classpath =
/usr/lib/j2se/1.4//lib/tools.jar:/usr/share/tomcat4/bin/bootstrap.jar =
-Dcatalina.base=3D/usr/share/tomcat4 =
-Dcatalina.home=3D/usr/share/tomcat4 =
-Djava.io.tmpdir=3D/usr/share/tomcat4/temp =
org.apache.catalina.startup.Bootstrap start
execve("/usr/lib/j2se/1.4//bin/java", ["/usr/lib/j2se/1.4//bin/java", =
"-Djava.endorsed.dirs=3D/usr/share/tomcat4/common/endorsed", =
"-classpath", =
"/usr/lib/j2se/1.4//lib/tools.jar:/usr/share/tomcat4/bin/bootstrap.jar", =
"-Dcatalina.base=3D/usr/share/tomcat4", =
"-Dcatalina.home=3D/usr/share/tomcat4", =
"-Djava.io.tmpdir=3D/usr/share/tomcat4/temp", =
"org.apache.catalina.startup.Bootstrap", "start"], [/* 17 vars */]) =3D =
0
uname({sysname=3D"Linux", nodename=3D"template", =
release=3D"2.6.8.1-1um", version=3D"#1 Wed Sep 8 07:58:38 EST 2004", =
machine=3D"i686"}) =3D 0
brk(0)                                  =3D 0x804e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or =
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29113, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D40, st_size=3D17718, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:21:36, =
st_ctime=3D2004/09/07-23:21:36}) =3D 0
old_mmap(NULL, 17718, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40018000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320D\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16316, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D160, st_size=3D78167, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:38, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 60768, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4001d000
old_mmap(0x40029000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xc000) =3D 0x40029000
old_mmap(0x4002a000, 7520, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4002a000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\32"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16305, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D24, st_size=3D9432, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:20, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 12288, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4002c000
old_mmap(0x4002e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x1000) =3D 0x4002e000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340X\1"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16303, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D2506, st_size=3D1279076, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:20, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 1289388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4002f000
old_mmap(0x4015f000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x12f000) =3D 0x4015f000
old_mmap(0x40168000, 7340, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40168000
close(3)                                =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x4016a000
set_thread_area({entry_number:-1 -> -1, base_addr:0x4016a2a0, =
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, =
limit_in_pages:1, seg_not_present:0, useable:1}) =3D -1 ENOSYS (Function =
not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x4016a2a0, limit:1048575, =
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, =
seg_not_present:0, useable:1}, 16) =3D 0
munmap(0x40018000, 17718)               =3D 0
set_tid_address(0x4016a2e8)             =3D 1081
rt_sigaction(SIGRTMIN, {0x40021430, [], SA_RESTORER|SA_SIGINFO, =
0x40027a10}, NULL, 8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, =
rlim_max=3DRLIM_INFINITY}) =3D 0
stat64("/usr/lib/j2se/1.4//bin/java", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29190, st_mode=3DS_IFREG|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D48, st_size=3D20820, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
brk(0)                                  =3D 0x804e000
brk(0x8070000)                          =3D 0x8070000
brk(0)                                  =3D 0x8070000
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29184, st_mode=3DS_IFDIR|0755, st_nlink=3D3, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D1, st_size=3D816, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:28, =
st_ctime=3D2004/09/07-23:33:28}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin/java", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29190, st_mode=3DS_IFREG|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D48, st_size=3D20820, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/proc", {st_dev=3Dmakedev(0, 3), st_ino=3D1, =
st_mode=3DS_IFDIR|0555, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, st_atime=3D0, =
st_mtime=3D0, st_ctime=3D0}) =3D 0
lstat64("/proc/self", {st_dev=3Dmakedev(0, 3), st_ino=3D2, =
st_mode=3DS_IFLNK|0777, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D2, st_size=3D64, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2004/09/07-23:33:35, =
st_ctime=3D2004/09/07-23:33:35}) =3D 0
readlink("/proc/self", "1081", 4096)    =3D 4
lstat64("/proc/1081", {st_dev=3Dmakedev(0, 3), st_ino=3D70844418, =
st_mode=3DS_IFDIR|0555, st_nlink=3D3, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:34:40, =
st_ctime=3D2004/09/07-23:34:40}) =3D 0
lstat64("/proc/1081/exe", {st_dev=3Dmakedev(0, 3), st_ino=3D70844424, =
st_mode=3DS_IFLNK|0777, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:34:40, =
st_ctime=3D2004/09/07-23:34:40}) =3D 0
readlink("/proc/1081/exe", "/usr/lib/j2se/1.4/bin/java", 4096) =3D 26
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29184, st_mode=3DS_IFDIR|0755, st_nlink=3D3, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D1, st_size=3D816, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:28, =
st_ctime=3D2004/09/07-23:33:28}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin/java", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29190, st_mode=3DS_IFREG|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D48, st_size=3D20820, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
access("/usr/lib/j2se/1.4/lib/i386/libjava.so", F_OK) =3D -1 ENOENT (No =
such file or directory)
access("/usr/lib/j2se/1.4/jre/lib/i386/libjava.so", F_OK) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/jvm.cfg", O_RDONLY) =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29218, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D8, st_size=3D671, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2002/07/24-00:34:35, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x4016b000
read(3, "#\n# @(#)jvm.cfg\t1.6 01/12/03\n# \n"..., 131072) =3D 671
read(3, "", 131072)                     =3D 0
close(3)                                =3D 0
munmap(0x4016b000, 131072)              =3D 0
stat64("/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so", =
{st_dev=3Dmakedev(98, 0), st_ino=3D29213, st_mode=3DS_IFREG|0644, =
st_nlink=3D1, st_uid=3D0, st_gid=3D0, st_blksize=3D131072, =
st_blocks=3D9225, st_size=3D4716004, st_atime=3D2004/09/07-23:34:09, =
st_mtime=3D2002/11/01-16:56:12, st_ctime=3D2004/09/07-23:33:13}) =3D 0
execve("/usr/lib/j2se/1.4/bin/java", ["/usr/lib/j2se/1.4//bin/java", =
"-Djava.endorsed.dirs=3D/usr/share/"..., "-classpath", =
"/usr/lib/j2se/1.4//lib/tools.jar"..., =
"-Dcatalina.base=3D/usr/share/tomca"..., =
"-Dcatalina.home=3D/usr/share/tomca"..., =
"-Djava.io.tmpdir=3D/usr/share/tomc"..., =
"org.apache.catalina.startup.Boot"..., "start"], ["TERM=3Dxterm", =
"SHELL=3D/bin/bash", "SSH_CLIENT=3D192.168.0.1 32774 22", =
"OLDPWD=3D/root", "SSH_TTY=3D/dev/pts/0", "USER=3Droot", =
"MAIL=3D/var/mail/root", "PATH=3D/usr/local/sbin:/usr/local/"..., =
"PWD=3D/usr/share/tomcat4/bin", "JAVA_HOME=3D/usr/lib/j2se/1.4/", =
"LANG=3Den_AU", "PS1=3D\\h:\\w\\$ ", "SHLVL=3D1", "HOME=3D/root", =
"LOGNAME=3Droot", "SSH_CONNECTION=3D192.168.0.1 32774"..., =
"_=3D/usr/bin/strace", "LD_LIBRARY_PATH=3D/usr/lib/j2se/1."...]) =3D 0
uname({sysname=3D"Linux", nodename=3D"template", =
release=3D"2.6.8.1-1um", version=3D"#1 Wed Sep 8 07:58:38 EST 2004", =
machine=3D"i686"}) =3D 0
brk(0)                                  =3D 0x804e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/client/tls/i586/libpthread.so.0", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/client/tls/i586", 0xbffff2e8) =3D =
-1 ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/client/tls/libpthread.so.0", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/client/tls", 0xbffff2e8) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/client/i586/libpthread.so.0", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/client/i586", 0xbffff2e8) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libpthread.so.0", O_RDONLY) =
=3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/client", {st_dev=3Dmakedev(98, =
0), st_ino=3D29212, st_mode=3DS_IFDIR|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/tls/i586/libpthread.so.0", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/tls/i586", 0xbffff2e8) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/tls/libpthread.so.0", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/tls", 0xbffff2e8) =3D -1 ENOENT =
(No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/i586/libpthread.so.0", O_RDONLY) =
=3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386/i586", 0xbffff2e8) =3D -1 ENOENT =
(No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libpthread.so.0", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/i386", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29206, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D1, st_size=3D936, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:14, =
st_ctime=3D2004/09/07-23:33:14}) =3D 0
open("/usr/lib/j2se/1.4/jre/../lib/i386/tls/i586/libpthread.so.0", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/../lib/i386/tls/i586", 0xbffff2e8) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/../lib/i386/tls/libpthread.so.0", O_RDONLY) =
=3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/../lib/i386/tls", 0xbffff2e8) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/../lib/i386/i586/libpthread.so.0", O_RDONLY) =
=3D -1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/../lib/i386/i586", 0xbffff2e8) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/../lib/i386/libpthread.so.0", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/../lib/i386", 0xbffff2e8) =3D -1 ENOENT =
(No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29113, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D40, st_size=3D17718, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:21:36, =
st_ctime=3D2004/09/07-23:21:36}) =3D 0
old_mmap(NULL, 17718, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40018000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320D\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16316, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D160, st_size=3D78167, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:38, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 60768, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4001d000
old_mmap(0x40029000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xc000) =3D 0x40029000
old_mmap(0x4002a000, 7520, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4002a000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libdl.so.2", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libdl.so.2", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\32"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16305, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D24, st_size=3D9432, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:20, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 12288, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4002c000
old_mmap(0x4002e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x1000) =3D 0x4002e000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libc.so.6", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libc.so.6", O_RDONLY) =3D -1 ENOENT =
(No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340X\1"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16303, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D2506, st_size=3D1279076, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:20, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 1289388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4002f000
old_mmap(0x4015f000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x12f000) =3D 0x4015f000
old_mmap(0x40168000, 7340, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40168000
close(3)                                =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x4016a000
set_thread_area({entry_number:-1 -> -1, base_addr:0x4016a460, =
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, =
limit_in_pages:1, seg_not_present:0, useable:1}) =3D -1 ENOSYS (Function =
not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x4016a460, limit:1048575, =
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, =
seg_not_present:0, useable:1}, 16) =3D 0
munmap(0x40018000, 17718)               =3D 0
set_tid_address(0x4016a4a8)             =3D 1081
rt_sigaction(SIGRTMIN, {0x40021430, [], SA_RESTORER|SA_SIGINFO, =
0x40027a10}, NULL, 8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, =
rlim_max=3DRLIM_INFINITY}) =3D 0
stat64("/usr/lib/j2se/1.4//bin/java", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29190, st_mode=3DS_IFREG|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D48, st_size=3D20820, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
brk(0)                                  =3D 0x804e000
brk(0x8070000)                          =3D 0x8070000
brk(0)                                  =3D 0x8070000
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29184, st_mode=3DS_IFDIR|0755, st_nlink=3D3, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D1, st_size=3D816, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:28, =
st_ctime=3D2004/09/07-23:33:28}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin/java", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29190, st_mode=3DS_IFREG|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D48, st_size=3D20820, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/proc", {st_dev=3Dmakedev(0, 3), st_ino=3D1, =
st_mode=3DS_IFDIR|0555, st_nlink=3D42, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, st_atime=3D0, =
st_mtime=3D0, st_ctime=3D0}) =3D 0
lstat64("/proc/self", {st_dev=3Dmakedev(0, 3), st_ino=3D2, =
st_mode=3DS_IFLNK|0777, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D2, st_size=3D64, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:33:35, =
st_ctime=3D2004/09/07-23:33:35}) =3D 0
readlink("/proc/self", "1081", 4096)    =3D 4
lstat64("/proc/1081", {st_dev=3Dmakedev(0, 3), st_ino=3D70844418, =
st_mode=3DS_IFDIR|0555, st_nlink=3D3, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:34:40, =
st_ctime=3D2004/09/07-23:34:40}) =3D 0
lstat64("/proc/1081/exe", {st_dev=3Dmakedev(0, 3), st_ino=3D70844424, =
st_mode=3DS_IFLNK|0777, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:34:40, =
st_ctime=3D2004/09/07-23:34:40}) =3D 0
readlink("/proc/1081/exe", "/usr/lib/j2se/1.4/bin/java", 4096) =3D 26
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29184, st_mode=3DS_IFDIR|0755, st_nlink=3D3, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D1, st_size=3D816, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:28, =
st_ctime=3D2004/09/07-23:33:28}) =3D 0
lstat64("/usr/lib/j2se/1.4/bin/java", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29190, st_mode=3DS_IFREG|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D48, st_size=3D20820, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
access("/usr/lib/j2se/1.4/lib/i386/libjava.so", F_OK) =3D -1 ENOENT (No =
such file or directory)
access("/usr/lib/j2se/1.4/jre/lib/i386/libjava.so", F_OK) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/jvm.cfg", O_RDONLY) =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29218, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D8, st_size=3D671, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/07/24-00:34:35, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x4016b000
read(3, "#\n# @(#)jvm.cfg\t1.6 01/12/03\n# \n"..., 131072) =3D 671
read(3, "", 131072)                     =3D 0
close(3)                                =3D 0
munmap(0x4016b000, 131072)              =3D 0
stat64("/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so", =
{st_dev=3Dmakedev(98, 0), st_ino=3D29213, st_mode=3DS_IFREG|0644, =
st_nlink=3D1, st_uid=3D0, st_gid=3D0, st_blksize=3D131072, =
st_blocks=3D9225, st_size=3D4716004, st_atime=3D2004/09/07-23:34:09, =
st_mtime=3D2002/11/01-16:56:12, st_ctime=3D2004/09/07-23:33:13}) =3D 0
futex(0x4002effc, FUTEX_WAKE, 2147483647) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220M\16"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29213, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D9225, st_size=3D4716004, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:12, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
old_mmap(NULL, 4788152, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4016b000
old_mmap(0x405cf000, 118784, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED, 3, 0x463000) =3D 0x405cf000
old_mmap(0x405ec000, 65464, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x405ec000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libnsl.so.1", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libnsl.so.1", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29113, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D40, st_size=3D17718, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:21:36, =
st_ctime=3D2004/09/07-23:21:36}) =3D 0
old_mmap(NULL, 17718, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x405fc000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libnsl.so.1", O_RDONLY)  =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3209\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16308, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D152, st_size=3D74264, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:20, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 85600, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40601000
old_mmap(0x40613000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x11000) =3D 0x40613000
old_mmap(0x40614000, 7776, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40614000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libm.so.6", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libm.so.6", O_RDONLY) =3D -1 ENOENT =
(No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libm.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0006\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D16306, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D280, st_size=3D141312, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/08/09-19:30:20, =
st_ctime=3D2004/09/07-22:06:21}) =3D 0
old_mmap(NULL, 139712, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40616000
old_mmap(0x40638000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x22000) =3D 0x40638000
close(3)                                =3D 0
munmap(0x405fc000, 17718)               =3D 0
getpid()                                =3D 1081
open("/etc/mtab", O_RDONLY)             =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D1497, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D8, st_size=3D158, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2004/09/07-23:00:37, =
st_ctime=3D2004/09/07-23:00:37}) =3D 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x40639000
read(3, "/dev/ubd/disc0/disc / reiserfs r"..., 131072) =3D 158
close(3)                                =3D 0
munmap(0x40639000, 131072)              =3D 0
open("/proc/stat", O_RDONLY)            =3D 3
fstat64(3, {st_dev=3Dmakedev(0, 3), st_ino=3D4026531853, =
st_mode=3DS_IFREG|0444, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:34:40, =
st_ctime=3D2004/09/07-23:34:40}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x40639000
read(3, "cpu  3778 0 12749 187703 79 35 4"..., 1024) =3D 203
read(3, "", 1024)                       =3D 0
close(3)                                =3D 0
munmap(0x40639000, 4096)                =3D 0
open("/etc/mtab", O_RDONLY)             =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D1497, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D8, st_size=3D158, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:00:37, =
st_ctime=3D2004/09/07-23:00:37}) =3D 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x40639000
read(3, "/dev/ubd/disc0/disc / reiserfs r"..., 131072) =3D 158
close(3)                                =3D 0
munmap(0x40639000, 131072)              =3D 0
open("/proc/meminfo", O_RDONLY)         =3D 3
fstat64(3, {st_dev=3Dmakedev(0, 3), st_ino=3D4026531842, =
st_mode=3DS_IFREG|0444, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D1024, st_blocks=3D0, st_size=3D0, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2004/09/07-23:34:40, =
st_ctime=3D2004/09/07-23:34:40}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x40639000
read(3, "MemTotal:        61240 kB\nMemFre"..., 1024) =3D 572
close(3)                                =3D 0
munmap(0x40639000, 4096)                =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, =
rlim_max=3DRLIM_INFINITY}) =3D 0
gettimeofday({1094600080, 836499}, NULL) =3D 0
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29201, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D368, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29204, st_mode=3DS_IFDIR|0755, st_nlink=3D13, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D2, st_size=3D1088, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/i386", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29206, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D1, st_size=3D936, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:14, =
st_ctime=3D2004/09/07-23:33:14}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/i386/client", {st_dev=3Dmakedev(98, =
0), st_ino=3D29212, st_mode=3DS_IFDIR|0755, st_nlink=3D2, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so", =
{st_dev=3Dmakedev(98, 0), st_ino=3D29213, st_mode=3DS_IFREG|0644, =
st_nlink=3D1, st_uid=3D0, st_gid=3D0, st_blksize=3D131072, =
st_blocks=3D9225, st_size=3D4716004, st_atime=3D2004/09/07-23:34:40, =
st_mtime=3D2002/11/01-16:56:12, st_ctime=3D2004/09/07-23:33:13}) =3D 0
access("/etc/debian_version", F_OK)     =3D 0
open(".hotspotrc", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT (No such file or =
directory)
open("/usr/share/tomcat4/common/endorsed", =
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D32314, =
st_mode=3DS_IFDIR|0755, st_nlink=3D2, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D48, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2004/08/13-11:40:58, =
st_ctime=3D2004/09/07-22:55:41}) =3D 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
mmap2(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x40639000
getdents64(3, {{d_ino=3D32314, d_off=3D2, d_type=3DDT_UNKNOWN, =
d_reclen=3D24, d_name=3D"."} {d_ino=3D32312, d_off=3D3, =
d_type=3DDT_UNKNOWN, d_reclen=3D24, d_name=3D".."}}, 131072) =3D 48
getdents64(3, {}, 131072)               =3D 0
munmap(0x40639000, 135168)              =3D 0
close(3)                                =3D 0
rt_sigaction(SIGSEGV, NULL, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGSEGV, {0x4041d358, ~[RTMIN], =
SA_RESTORER|SA_STACK|SA_RESTART|SA_SIGINFO, 0x40027a10}, {SIG_DFL}, 8) =
=3D 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGPIPE, {0x4041d358, ~[RTMIN], =
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x40027a10}, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGCHLD, {0x4041d358, ~[RTMIN], =
SA_RESTORER|SA_RESTART|SA_SIGINFO|SA_NOCLDSTOP, 0x40027a10}, {SIG_DFL}, =
8) =3D 0
rt_sigaction(SIGBUS, NULL, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGBUS, {0x4041d358, ~[RTMIN], =
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x40027a10}, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGILL, NULL, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGILL, {0x4041d358, ~[RTMIN], =
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x40027a10}, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGFPE, NULL, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGFPE, {0x4041d358, ~[RTMIN], =
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x40027a10}, {SIG_DFL}, 8) =3D 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  =3D 0
rt_sigaction(SIGUSR2, {0x4041bb5c, [], =
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x40027a10}, NULL, 8) =3D 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=3D1024, rlim_max=3D1024}) =3D 0
setrlimit(RLIMIT_NOFILE, {rlim_cur=3D1024, rlim_max=3D1024}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/native_threads/libhpi.so", =
O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200@\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29208, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D80, st_size=3D39384, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:13, =
st_ctime=3D2004/09/07-23:33:12}) =3D 0
old_mmap(NULL, 43420, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40639000
mprotect(0x40642000, 6556, PROT_NONE)   =3D 0
old_mmap(0x40643000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x9000) =3D 0x40643000
close(3)                                =3D 0
mmap2(0xbfe0e000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xbfe0e000
mprotect(0xbfe0e000, 12288, PROT_NONE)  =3D 0
getpid()                                =3D 1081
mmap2(0xbfe04000, 40960, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xbfe04000
sigaltstack({ss_sp=3D0xbfe04000, ss_flags=3D0, ss_size=3D40960}, NULL) =
=3D 0
rt_sigprocmask(SIG_UNBLOCK, [HUP INT QUIT USR2 TERM CHLD], NULL, 8) =3D =
0
open("/usr/lib/j2se/1.4/jre/lib/i386/libverify.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260!\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29216, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D136, st_size=3D65608, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:11, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
old_mmap(NULL, 68592, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40644000
old_mmap(0x40653000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xe000) =3D 0x40653000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220M\16"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29213, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D9225, st_size=3D4716004, =
st_atime=3D2004/09/07-23:34:40, st_mtime=3D2002/11/01-16:56:12, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/libjava.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \212\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29217, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D256, st_size=3D130480, =
st_atime=3D2004/09/07-23:34:41, st_mtime=3D2002/11/01-16:56:11, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
old_mmap(NULL, 133580, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40655000
old_mmap(0x40674000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x1e000) =3D 0x40674000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libverify.so", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libverify.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260!\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29216, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D136, st_size=3D65608, =
st_atime=3D2004/09/07-23:34:41, st_mtime=3D2002/11/01-16:56:11, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/libzip.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\'\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29219, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D184, st_size=3D92024, =
st_atime=3D2004/09/07-23:34:41, st_mtime=3D2002/11/01-16:56:11, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
old_mmap(NULL, 95424, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40676000
old_mmap(0x4068b000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x14000) =3D 0x4068b000
close(3)                                =3D 0
open("/usr/lib/j2se/1.4/jre/lib/i386/client/libjava.so", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
open("/usr/lib/j2se/1.4/jre/lib/i386/libjava.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \212\0"..., =
512) =3D 512
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29217, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D256, st_size=3D130480, =
st_atime=3D2004/09/07-23:34:41, st_mtime=3D2002/11/01-16:56:11, =
st_ctime=3D2004/09/07-23:33:13}) =3D 0
close(3)                                =3D 0
stat64("/usr/lib/j2se/1.4/jre/lib/rt.jar", {st_dev=3Dmakedev(98, 0), =
st_ino=3D34114, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D46741, st_size=3D23908228, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2002/07/24-01:00:37, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29201, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D368, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29204, st_mode=3DS_IFDIR|0755, st_nlink=3D13, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D2, st_size=3D1088, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/rt.jar", {st_dev=3Dmakedev(98, 0), =
st_ino=3D34114, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D46741, st_size=3D23908228, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2002/07/24-01:00:37, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/rt.jar", O_RDONLY|O_LARGEFILE) =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D34114, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D46741, st_size=3D23908228, =
st_atime=3D2004/09/07-23:34:09, st_mtime=3D2002/07/24-01:00:37, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
_llseek(3, 0, [23908228], SEEK_END)     =3D 0
mmap2(NULL, 23908228, PROT_READ, MAP_SHARED, 3, 0) =3D 0x4068e000
close(3)                                =3D 0
mmap2(NULL, 274432, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x41d5b000
stat64("/usr/lib/j2se/1.4/jre/lib/i18n.jar", 0xbfffd8c0) =3D -1 ENOENT =
(No such file or directory)
stat64("/usr/lib/j2se/1.4/jre/lib/sunrsasign.jar", {st_dev=3Dmakedev(98, =
0), st_ino=3D29262, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D184, st_size=3D90973, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:43, =
st_ctime=3D2004/09/07-23:33:14}) =3D 0
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29201, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D368, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29204, st_mode=3DS_IFDIR|0755, st_nlink=3D13, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D2, st_size=3D1088, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/sunrsasign.jar", =
{st_dev=3Dmakedev(98, 0), st_ino=3D29262, st_mode=3DS_IFREG|0644, =
st_nlink=3D1, st_uid=3D0, st_gid=3D0, st_blksize=3D131072, =
st_blocks=3D184, st_size=3D90973, st_atime=3D2004/09/07-23:34:10, =
st_mtime=3D2002/07/24-00:32:43, st_ctime=3D2004/09/07-23:33:14}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/sunrsasign.jar", O_RDONLY|O_LARGEFILE) =
=3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29262, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D184, st_size=3D90973, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:43, =
st_ctime=3D2004/09/07-23:33:14}) =3D 0
_llseek(3, 0, [90973], SEEK_END)        =3D 0
mmap2(NULL, 90973, PROT_READ, MAP_SHARED, 3, 0) =3D 0x41d9e000
close(3)                                =3D 0
stat64("/usr/lib/j2se/1.4/jre/lib/jsse.jar", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29267, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D904, st_size=3D462284, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:45, =
st_ctime=3D2004/09/07-23:33:15}) =3D 0
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29201, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D368, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29204, st_mode=3DS_IFDIR|0755, st_nlink=3D13, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D2, st_size=3D1088, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/jsse.jar", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29267, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D904, st_size=3D462284, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:45, =
st_ctime=3D2004/09/07-23:33:15}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/jsse.jar", O_RDONLY|O_LARGEFILE) =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29267, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D904, st_size=3D462284, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:45, =
st_ctime=3D2004/09/07-23:33:15}) =3D 0
_llseek(3, 0, [462284], SEEK_END)       =3D 0
mmap2(NULL, 462284, PROT_READ, MAP_SHARED, 3, 0) =3D 0x41db5000
close(3)                                =3D 0
stat64("/usr/lib/j2se/1.4/jre/lib/jce.jar", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29263, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D152, st_size=3D76355, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:45, =
st_ctime=3D2004/09/07-23:33:15}) =3D 0
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29201, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D368, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29204, st_mode=3DS_IFDIR|0755, st_nlink=3D13, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D2, st_size=3D1088, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/jce.jar", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29263, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D152, st_size=3D76355, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:45, =
st_ctime=3D2004/09/07-23:33:15}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/jce.jar", O_RDONLY|O_LARGEFILE) =3D 3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D29263, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D152, st_size=3D76355, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:32:45, =
st_ctime=3D2004/09/07-23:33:15}) =3D 0
_llseek(3, 0, [76355], SEEK_END)        =3D 0
mmap2(NULL, 76355, PROT_READ, MAP_SHARED, 3, 0) =3D 0x41e26000
close(3)                                =3D 0
stat64("/usr/lib/j2se/1.4/jre/lib/charsets.jar", {st_dev=3Dmakedev(98, =
0), st_ino=3D34063, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D5605, st_size=3D2863340, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:51:28, =
st_ctime=3D2004/09/07-23:33:19}) =3D 0
lstat64("/usr", {st_dev=3Dmakedev(98, 0), st_ino=3D113, =
st_mode=3DS_IFDIR|0755, st_nlink=3D12, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D312, =
st_atime=3D2004/09/07-23:33:55, st_mtime=3D2004/09/07-22:53:02, =
st_ctime=3D2004/09/07-22:53:02}) =3D 0
lstat64("/usr/lib", {st_dev=3Dmakedev(98, 0), st_ino=3D143, =
st_mode=3DS_IFDIR|0755, st_nlink=3D41, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D22, st_size=3D11424, =
st_atime=3D2004/09/07-23:33:56, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se", {st_dev=3Dmakedev(98, 0), st_ino=3D29181, =
st_mode=3DS_IFDIR|0755, st_nlink=3D4, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D96, =
st_atime=3D2004/09/07-23:33:57, st_mtime=3D2004/09/07-23:33:11, =
st_ctime=3D2004/09/07-23:33:11}) =3D 0
lstat64("/usr/lib/j2se/1.4", {st_dev=3Dmakedev(98, 0), st_ino=3D29183, =
st_mode=3DS_IFDIR|0755, st_nlink=3D6, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D0, st_size=3D144, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:29, =
st_ctime=3D2004/09/07-23:33:29}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29201, st_mode=3DS_IFDIR|0755, st_nlink=3D5, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D0, st_size=3D368, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib", {st_dev=3Dmakedev(98, 0), =
st_ino=3D29204, st_mode=3DS_IFDIR|0755, st_nlink=3D13, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D2, st_size=3D1088, =
st_atime=3D2004/09/07-23:33:07, st_mtime=3D2004/09/07-23:33:23, =
st_ctime=3D2004/09/07-23:33:23}) =3D 0
lstat64("/usr/lib/j2se/1.4/jre/lib/charsets.jar", {st_dev=3Dmakedev(98, =
0), st_ino=3D34063, st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, =
st_gid=3D0, st_blksize=3D131072, st_blocks=3D5605, st_size=3D2863340, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:51:28, =
st_ctime=3D2004/09/07-23:33:19}) =3D 0
open("/usr/lib/j2se/1.4/jre/lib/charsets.jar", O_RDONLY|O_LARGEFILE) =3D =
3
fstat64(3, {st_dev=3Dmakedev(98, 0), st_ino=3D34063, =
st_mode=3DS_IFREG|0644, st_nlink=3D1, st_uid=3D0, st_gid=3D0, =
st_blksize=3D131072, st_blocks=3D5605, st_size=3D2863340, =
st_atime=3D2004/09/07-23:34:10, st_mtime=3D2002/07/24-00:51:28, =
st_ctime=3D2004/09/07-23:33:19}) =3D 0
_llseek(3, 0, [2863340], SEEK_END)      =3D 0
mmap2(NULL, 2863340, PROT_READ, MAP_SHARED, 3, 0) =3D 0x41e39000
close(3)                                =3D 0
stat64("/usr/lib/j2se/1.4/jre/classes", 0xbfffd8c0) =3D -1 ENOENT (No =
such file or directory)
mmap2(NULL, 33554432, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x420f5000
mmap2(0x420f5000, 163840, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x420f5000
mmap2(NULL, 524288, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x440f5000
mmap2(0x440f5000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x440f5000
mmap2(NULL, 163840, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x44175000
mmap2(NULL, 134217728, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x4419d000
munmap(0x4419d000, 134217728)           =3D 0
mmap2(NULL, 134283264, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x4419d000
munmap(0x4419d000, 12288)               =3D 0
munmap(0x4c1a0000, 53248)               =3D 0
mmap2(NULL, 266240, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x4c1a0000
mmap2(0x4c1e0000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4c1e0000
mmap2(0x441a0000, 655360, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x441a0000
mmap2(0x4c1a0000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4c1a0000
mmap2(0x44680000, 1441792, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x44680000
mmap2(NULL, 122880, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x4c1e1000
mmap2(0x4c1e1000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4c1e1000
mmap2(0x4c1a2000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4c1a2000
mmap2(0x481a0000, 4194304, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x481a0000
mmap2(NULL, 135168, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x4c1ff000
mmap2(0x4c1ff000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4c1ff000
mmap2(0x4c1c0000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4c1c0000
mmap2(0x4211d000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4211d000
gettimeofday({1094600081, 441035}, NULL) =3D 0
brk(0)                                  =3D 0x8070000
brk(0x8092000)                          =3D 0x8092000
gettimeofday({1094600081, 472003}, NULL) =3D 0
mmap2(0x42125000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x42125000
mmap2(0x4212d000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4212d000
mmap2(0x42135000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x42135000
mmap2(0x440f6000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x440f6000
mmap2(0x4213d000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4213d000
mmap2(0x42145000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x42145000
mmap2(0x4214d000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4214d000
mmap2(0x42155000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x42155000
mmap2(0x4215d000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4215d000
mmap2(0x42165000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x42165000
open(".hotspot_compiler", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT (No such =
file or directory)
mmap2(NULL, 524288, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x4c220000
mprotect(0x4c220000, 4096, PROT_NONE)   =3D 0
clone(
An unexpected exception has been detected in native code outside the VM.
Unexpected Signal : 11 occurred at PC=3D0x0
Function=3D[Unknown.]
Library=3D(N/A)

NOTE: We are unable to locate the function name symbol for the error
      just occurred. Please refer to release documentation for possible
      reason and solutions.


Current Java thread:

Dynamic libraries:
08048000-0804d000 r-xp 00000000 62:00 29190      =
/usr/lib/j2se/1.4/bin/java
0804d000-0804e000 rw-p 00004000 62:00 29190      =
/usr/lib/j2se/1.4/bin/java
40000000-40016000 r-xp 00000000 62:00 16275      /lib/ld-2.3.2.so
40016000-40017000 rw-p 00015000 62:00 16275      /lib/ld-2.3.2.so
4001d000-40029000 r-xp 00000000 62:00 16316      =
/lib/tls/libpthread-0.60.so
40029000-4002a000 rw-p 0000c000 62:00 16316      =
/lib/tls/libpthread-0.60.so
4002c000-4002e000 r-xp 00000000 62:00 16305      /lib/tls/libdl-2.3.2.so
4002e000-4002f000 rw-p 00001000 62:00 16305      /lib/tls/libdl-2.3.2.so
4002f000-4015f000 r-xp 00000000 62:00 16303      /lib/tls/libc-2.3.2.so
4015f000-40168000 rw-p 0012f000 62:00 16303      /lib/tls/libc-2.3.2.so
4016b000-405cf000 r-xp 00000000 62:00 29213      =
/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so
405cf000-405ec000 rw-p 00463000 62:00 29213      =
/usr/lib/j2se/1.4/jre/lib/i386/client/libjvm.so
40601000-40613000 r-xp 00000000 62:00 16308      =
/lib/tls/libnsl-2.3.2.so
40613000-40614000 rw-p 00011000 62:00 16308      =
/lib/tls/libnsl-2.3.2.so
40616000-40638000 r-xp 00000000 62:00 16306      /lib/tls/libm-2.3.2.so
40638000-40639000 rw-p 00022000 62:00 16306      /lib/tls/libm-2.3.2.so
40639000-40642000 r-xp 00000000 62:00 29208      =
/usr/lib/j2se/1.4/jre/lib/i386/native_threads/libhpi.so
40642000-40643000 ---p 00009000 62:00 29208      =
/usr/lib/j2se/1.4/jre/lib/i386/native_threads/libhpi.so
40643000-40644000 rw-p 00009000 62:00 29208      =
/usr/lib/j2se/1.4/jre/lib/i386/native_threads/libhpi.so
40644000-40653000 r-xp 00000000 62:00 29216      =
/usr/lib/j2se/1.4/jre/lib/i386/libverify.so
40653000-40655000 rw-p 0000e000 62:00 29216      =
/usr/lib/j2se/1.4/jre/lib/i386/libverify.so
40655000-40674000 r-xp 00000000 62:00 29217      =
/usr/lib/j2se/1.4/jre/lib/i386/libjava.so
40674000-40676000 rw-p 0001e000 62:00 29217      =
/usr/lib/j2se/1.4/jre/lib/i386/libjava.so
40676000-4068b000 r-xp 00000000 62:00 29219      =
/usr/lib/j2se/1.4/jre/lib/i386/libzip.so
4068b000-4068e000 rw-p 00014000 62:00 29219      =
/usr/lib/j2se/1.4/jre/lib/i386/libzip.so
4068e000-41d5b000 r--s 00000000 62:00 34114      =
/usr/lib/j2se/1.4/jre/lib/rt.jar
41d9e000-41db5000 r--s 00000000 62:00 29262      =
/usr/lib/j2se/1.4/jre/lib/sunrsasign.jar
41db5000-41e26000 r--s 00000000 62:00 29267      =
/usr/lib/j2se/1.4/jre/lib/jsse.jar
41e26000-41e39000 r--s 00000000 62:00 29263      =
/usr/lib/j2se/1.4/jre/lib/jce.jar
41e39000-420f5000 r--s 00000000 62:00 34063      =
/usr/lib/j2se/1.4/jre/lib/charsets.jar

Local Time =3D Tue Sep  7 23:34:41 2004
Elapsed Time =3D 0
#
# The exception above was detected in native code outside the VM
#
# Java VM: Java HotSpot(TM) Client VM (Blackdown-1.4.1-beta mixed mode)
#
# An error report file has been saved as hs_err_pid1081.log.
# Please refer to the file for further information.
#
child_stack=3D0x4c29fb48, =
flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHE=
D, parent_tidptr=3D0x4c29fbf8, {entry_number:0, base_addr:0x4c29fbb0, =
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, =
limit_in_pages:1, seg_not_present:0, useable:1}, =
child_tidptr=3D0x4c29fbf8) =3D 1082
--- SIGABRT (Aborted) @ 0 (0) ---
+++ killed by SIGABRT +++
template:/usr/share/tomcat4/bin#

------=_NextPart_000_0018_01C49584.0534E1F0
Content-Type: text/plain;
	name="bind-strace.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bind-strace.txt"

template:~# strace named -g
execve("/usr/sbin/named", ["named", "-g"], [/* 15 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"template", ...}) =3D 0
brk(0)                                  =3D 0x808e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or =
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D17124, ...}) =3D 0
old_mmap(NULL, 17124, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40018000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/liblwres.so.1", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P$\0\000"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D57548, ...}) =3D 0
old_mmap(NULL, 60616, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4001d000
old_mmap(0x4002b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xd000) =3D 0x4002b000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/libdns.so.11", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\"\1"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D1038536, ...}) =3D 0
old_mmap(NULL, 1042992, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4002c000
old_mmap(0x40127000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xfa000) =3D 0x40127000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/i586/libcrypto.so.0.9.7", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\271"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D942856, ...}) =3D 0
old_mmap(NULL, 960824, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4012b000
old_mmap(0x40201000, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xd5000) =3D 0x40201000
old_mmap(0x40212000, 14648, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40212000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/libisccfg.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360=3D\0"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D61288, ...}) =3D 0
old_mmap(NULL, 63432, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40216000
old_mmap(0x40223000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xd000) =3D 0x40223000
old_mmap(0x40225000, 1992, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40225000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/libisccc.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\35\0\000"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D26832, ...}) =3D 0
old_mmap(NULL, 29908, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40226000
old_mmap(0x4022d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x6000) =3D 0x4022d000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/usr/lib/libisc.so.7", O_RDONLY)  =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240z\0"..., =
512) =3D 512
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x4022e000
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D225192, ...}) =3D 0
old_mmap(NULL, 228604, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4022f000
old_mmap(0x40266000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x36000) =3D 0x40266000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libnsl.so.1", O_RDONLY)  =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3209\0"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D74264, ...}) =3D 0
old_mmap(NULL, 85600, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x40267000
old_mmap(0x40279000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x11000) =3D 0x40279000
old_mmap(0x4027a000, 7776, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4027a000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320D\0"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D78167, ...}) =3D 0
old_mmap(NULL, 60768, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4027c000
old_mmap(0x40288000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0xc000) =3D 0x40288000
old_mmap(0x40289000, 7520, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40289000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340X\1"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D1279076, ...}) =3D 0
old_mmap(NULL, 1289388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x4028b000
old_mmap(0x403bb000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x12f000) =3D 0x403bb000
old_mmap(0x403c4000, 7340, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x403c4000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\32"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D9432, ...}) =3D 0
old_mmap(NULL, 12288, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0x403c6000
old_mmap(0x403c8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, =
3, 0x1000) =3D 0x403c8000
close(3)                                =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x403c9000
set_thread_area({entry_number:-1 -> -1, base_addr:0x403c98a0, =
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, =
limit_in_pages:1, seg_not_present:0, useable:1}) =3D -1 ENOSYS (Function =
not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x403c98a0, limit:1048575, =
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, =
seg_not_present:0, useable:1}, 16) =3D 0
munmap(0x40018000, 17124)               =3D 0
set_tid_address(0x403c98e8)             =3D 476
rt_sigaction(SIGRTMIN, {0x40280430, [], SA_RESTORER|SA_SIGINFO, =
0x40286a10}, NULL, 8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, =
rlim_max=3DRLIM_INFINITY}) =3D 0
socket(PF_FILE, SOCK_DGRAM, 0)          =3D 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
connect(3, {sa_family=3DAF_FILE, path=3D"/dev/log"}, 16) =3D 0
getuid32()                              =3D 0
capset(0x19980330, 0, =
{CAP_DAC_READ_SEARCH|CAP_SETGID|CAP_SETUID|CAP_NET_BIND_SERVICE|CAP_SYS_C=
HROOT|CAP_SYS_RESOURCE, =
CAP_DAC_READ_SEARCH|CAP_SETGID|CAP_SETUID|CAP_NET_BIND_SERVICE|CAP_SYS_CH=
ROOT|CAP_SYS_RESOURCE, =
CAP_DAC_READ_SEARCH|CAP_SETGID|CAP_SETUID|CAP_NET_BIND_SERVICE|CAP_SYS_CH=
ROOT|CAP_SYS_RESOURCE}) =3D 0
getpid()                                =3D 476
rt_sigaction(SIGXFSZ, {SIG_IGN}, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGINT, {0x4024eab0, ~[RTMIN], SA_RESTORER, 0x40286a18}, =
NULL, 8) =3D 0
rt_sigaction(SIGTERM, {0x4024eab0, ~[RTMIN], SA_RESTORER, 0x40286a18}, =
NULL, 8) =3D 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) =3D 0
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) =3D 0
rt_sigprocmask(SIG_BLOCK, [HUP INT TERM], NULL, 8) =3D 0
brk(0)                                  =3D 0x808e000
brk(0x80af000)                          =3D 0x80af000
brk(0)                                  =3D 0x80af000
open("/usr/share/locale/en_AU/libdns.cat", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
open("/usr/share/locale/en_AU/LC_MESSAGES/libdns.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
open("/usr/share/locale/en/libdns.cat", O_RDONLY) =3D -1 ENOENT (No such =
file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libdns.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
futex(0x4012a590, FUTEX_WAKE, 2147483647) =3D 0
open("/usr/share/locale/en_AU/libisc.cat", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
open("/usr/share/locale/en_AU/LC_MESSAGES/libisc.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
open("/usr/share/locale/en/libisc.cat", O_RDONLY) =3D -1 ENOENT (No such =
file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libisc.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
futex(0x40266c40, FUTEX_WAKE, 2147483647) =3D 0
futex(0x40266c60, FUTEX_WAKE, 2147483647) =3D 0
futex(0x4012a59c, FUTEX_WAKE, 2147483647) =3D 0
open("/usr/share/locale/en_AU/libdst.cat", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
open("/usr/share/locale/en_AU/LC_MESSAGES/libdst.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
open("/usr/share/locale/en/libdst.cat", O_RDONLY) =3D -1 ENOENT (No such =
file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libdst.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
futex(0x4012a9e0, FUTEX_WAKE, 2147483647) =3D 0
futex(0x4012a9e4, FUTEX_WAKE, 2147483647) =3D 0
open("/usr/share/locale/en_AU/libisccc.cat", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
open("/usr/share/locale/en_AU/LC_MESSAGES/libisccc.cat", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)
open("/usr/share/locale/en/libisccc.cat", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libisccc.cat", O_RDONLY) =3D -1 =
ENOENT (No such file or directory)
futex(0x4022d4c8, FUTEX_WAKE, 2147483647) =3D 0
futex(0x4022d4cc, FUTEX_WAKE, 2147483647) =3D 0
open("/etc/localtime", O_RDONLY)        =3D 4
fstat64(4, {st_mode=3DS_IFREG|0644, st_size=3D56, ...}) =3D 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x403ca000
read(4, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0"..., =
131072) =3D 56
close(4)                                =3D 0
munmap(0x403ca000, 131072)              =3D 0
open("/dev/null", O_RDWR)               =3D 4
prctl(0x8, 0x1, 0, 0, 0)                =3D 0
getuid32()                              =3D 0
getuid32()                              =3D 0
capset(0x19980330, 0, {CAP_NET_BIND_SERVICE|CAP_SYS_RESOURCE, =
CAP_NET_BIND_SERVICE|CAP_SYS_RESOURCE, =
CAP_NET_BIND_SERVICE|CAP_SYS_RESOURCE}) =3D 0
gettimeofday({1094598191, 321928}, NULL) =3D 0
write(2, "Sep 07 23:03:11.321 starting BIN"..., 46Sep 07 23:03:11.321 =
starting BIND 9.2.4rc7 -g
) =3D 46
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, =
rlim_max=3DRLIM_INFINITY}) =3D 0
getrlimit(RLIMIT_DATA, {rlim_cur=3DRLIM_INFINITY, =
rlim_max=3DRLIM_INFINITY}) =3D 0
getrlimit(RLIMIT_CORE, {rlim_cur=3D0, rlim_max=3DRLIM_INFINITY}) =3D 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=3D1024, rlim_max=3D1024}) =3D 0
open("/etc/mtab", O_RDONLY)             =3D 5
fstat64(5, {st_mode=3DS_IFREG|0644, st_size=3D158, ...}) =3D 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x403ca000
read(5, "/dev/ubd/disc0/disc / reiserfs r"..., 131072) =3D 158
close(5)                                =3D 0
munmap(0x403ca000, 131072)              =3D 0
open("/proc/stat", O_RDONLY)            =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x403ca000
read(5, "cpu  339 0 3420 12020 19 35 28\nc"..., 1024) =3D 186
read(5, "", 1024)                       =3D 0
close(5)                                =3D 0
munmap(0x403ca000, 4096)                =3D 0
gettimeofday({1094598191, 389117}, NULL) =3D 0
write(2, "Sep 07 23:03:11.389 using 1 CPU\n", 32Sep 07 23:03:11.389 =
using 1 CPU
) =3D 32
mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x403ca000
mprotect(0x403ca000, 4096, PROT_NONE)   =3D 0
clone(child_stack=3D0x40bc9b48, =
flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SY=
SVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHE=
D, parent_tidptr=3D0x40bc9bf8ptrace: umoven: No such process
, tls=3D0xbffffb70, child_tidptr=3D0x40bc9bf8) =3D 477
trace: ptrace(PTRACE_SYSCALL, ...): No such process
template:~#

------=_NextPart_000_0018_01C49584.0534E1F0--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
