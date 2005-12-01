Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ehqum-0005CN-V3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 08:04:08 -0800
Received: from cod.sandelman.ca ([192.139.46.139] helo=lists.sandelman.ca)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Ehque-0004AF-Hw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 08:04:06 -0800
References: <12276.1133324450@sandelman.ottawa.on.ca>
	<200511300739.46148.rob@landley.net>
	<31479.1133368473@sandelman.ottawa.on.ca>
	<200511301127.13494.rob@landley.net>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
In-Reply-To: <200511301127.13494.rob@landley.net> (Rob Landley's message of
	"Wed, 30 Nov 2005 11:27:13 -0600")
Message-ID: <v0k6eo24af.fsf@marajade.sandelman.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Subject: [uml-devel] Re: 2.6.15-rc2
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
Date: Thu, 01 Dec 2005 11:03:20 -0500
To: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

--=-=-=


okay, I don't quite understand, but it seemds that -rc2 is okay, but -rc3 is
failing. (-rc2 was failing as far as I could tell on Monday. Maybe I wasn't
running the kernel I thought I was).

Using git bisect, I've reduced the problem to:
          
          39d730ab87f07592e3a3794353f097d5184cae7a is first bad commit
          diff-tree 39d730ab87f07592e3a3794353f097d5184cae7a (from 18317ab0ca5ac0c654be3eac31ebb781b4a5e9b2)
          Author: Jeff Dike <jdike@addtoit.com>
          Date:   Mon Nov 21 21:32:04 2005 -0800

              [PATCH] uml: eliminate use of local in clone stub
                  
    We have a bug in the i386 stub_syscall6 which pushes ebp before the system
    call and pops it afterwards.  Because we use syscall6 to remap the stack, the
    old contents of the stack (and the former value of ebp) are no longer
    available.  Some versions of gcc make from a real local, accessed through ebp,
    despite my efforts to make it obvious that references to from are really
    constants.  This patch attempts to make it even more obvious by eliminating
    from and using a macro to access the stub's data explicitly with constants.
    
    My original thinking on this was to replace syscall6 with a remap_stack
    interface which saved ebp someplace and restored it afterwards.  The problem
    is that there are no registers to put it in, except for esp.  That could work,
    since we can store a constant in esp after the mmap because we just replaced
    the stack.  However, this approach seems a tad cleaner.
    
    Signed-off-by: Jeff Dike <jdike@addtoit.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


=== Sigh. I know that this was an annoying fix.

The fault that I get:

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1228KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
Stub registers -
        0 - bffff000
        1 - 1000
        2 - 3
        3 - 11
        4 - 3
        5 - 0
        6 - bffff000
        7 - 7b
        8 - 7b
        9 - 0
        10 - 0
        11 - ffffffff
        12 - bfffe092
        13 - 73
        14 - 10246
        15 - bffff7fc
        16 - 7b
Kernel panic - not syncing: copy_context_skas0 : failed to wait for SIGUSR1/SIGTRAP, pid = 32345, n = 32345, errno = 0, status = 0xb7f

(copy of initrd at: http://www.sandelman.ottawa.on.ca/tmp/initrd.uml .
umlroot= is interpreted by it as a hostfs to mount after mounting tmpfs on
/dev) 

marajade-[/mara6/openswan/openswan.git] mcr 1070 %gdb /mara1/git/uml-2.6.15/O/um-01/linux
GNU gdb 6.3-debian
...

(gdb) set args initrd=/mara6/sandboxes/openswan.git/UMLPOOL/initrd.uml umlroot=/mara6/sandboxes/openswan.git/UMLPOOL/east/root root=/dev/root rw ssl=pty umid=east
(gdb) run

(gdb) c
Continuing.

Program received signal SIGUSR1, User defined signal 1.
0xa018c031 in kill () at swab.h:134

(gdb) handle SIGUSR1 nostop noprint
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) c
Continuing

Program received signal SIGSEGV, Segmentation fault.
zlib_inflateInit2_ (z=0xa0309360, w=15, 
    version=0xa280005c <Address 0xa280005c out of bounds>, stream_size=48)
    at /mara1/git/uml-2.6.15/lib/zlib_inflate/inflate.c:57
57        z->state->blocks = NULL;
(gdb) bt
#0  zlib_inflateInit2_ (z=0xa0309360, w=15, 
    version=0xa280005c <Address 0xa280005c out of bounds>, stream_size=48)
    at /mara1/git/uml-2.6.15/lib/zlib_inflate/inflate.c:57
#1  0xa00ec858 in zlib_inflateInit_ (z=0xa280005c, 
    version=0xa280005c <Address 0xa280005c out of bounds>, 
    stream_size=-1568669604)
    at /mara1/git/uml-2.6.15/lib/zlib_inflate/inflate.c:109
#2  0xa00cb122 in cramfs_uncompress_init ()
    at /mara1/git/uml-2.6.15/fs/cramfs/uncompress.c:66
#3  0xa000e07b in init_cramfs_fs ()
    at /mara1/git/uml-2.6.15/fs/cramfs/inode.c:548
#4  0xa000170b in do_initcalls () at /mara1/git/uml-2.6.15/init/main.c:578
#5  0xa00017d1 in do_basic_setup () at /mara1/git/uml-2.6.15/init/main.c:620
#6  0xa0014221 in init (unused=0x0) at /mara1/git/uml-2.6.15/init/main.c:693
#7  0xa0031c49 in run_kernel_thread (fn=0xa00141e0 <init>, arg=0x0, 
    jmp_ptr=0xa280005c) at /mara1/git/uml-2.6.15/arch/um/os-Linux/process.c:216
#8  0xa0022ed3 in new_thread_handler (sig=10) at thread_info.h:47
#9  <signal handler called>
#10 0xa018c031 in kill () at swab.h:134
#11 0x00000000 in ?? ()
#12 0x00000000 in ?? ()
#13 0x00000000 in ?? ()
#14 0x00000000 in ?? ()
#15 0xa021b574 in init_thread_union ()
#16 0xa021cf2c in init_task ()
#17 0xa09caaf8 in ?? ()
#18 0xa021b6c0 in init_thread_union ()
#19 0xa00229e0 in new_thread (stack=0xa021cf2c, switch_buf_ptr=0x0, 
    fork_buf_ptr=0x0, handler=0xa00229e0 <new_thread+96>)
    at /mara1/git/uml-2.6.15/arch/um/kernel/skas/process.c:454

gcc version 3.3.5 (Debian 1:3.3.5-13)

%objdump --disassemble -S O/um-01/arch/um/kernel/skas/clone.o >|clone.S
O/um-01/arch/um/kernel/skas/clone.o:     file format elf32-i386

Disassembly of section .__syscall_stub:

00000000 <stub_clone_handler>:
#define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)

void __attribute__ ((__section__ (".__syscall_stub")))
stub_clone_handler(void)
{
   0:	55                   	push   %ebp
   1:	ba 78 00 00 00       	mov    $0x78,%edx
   6:	89 e5                	mov    %esp,%ebp
   8:	b9 fc f7 ff bf       	mov    $0xbffff7fc,%ecx
   d:	89 d0                	mov    %edx,%eax
   f:	83 ec 18             	sub    $0x18,%esp
  12:	89 5d f4             	mov    %ebx,0xfffffff4(%ebp)
  15:	bb 11 84 00 00       	mov    $0x8411,%ebx
  1a:	89 75 f8             	mov    %esi,0xfffffff8(%ebp)
  1d:	89 7d fc             	mov    %edi,0xfffffffc(%ebp)
  20:	cd 80                	int    $0x80
  22:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
	long err;

	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 -
			    sizeof(void *));
	if(err != 0)
  25:	85 c0                	test   %eax,%eax
  27:	75 6c                	jne    95 <stub_clone_handler+0x95>
  29:	8b 5d f0             	mov    0xfffffff0(%ebp),%ebx
  2c:	bf 1a 00 00 00       	mov    $0x1a,%edi
  31:	89 f8                	mov    %edi,%eax
  33:	89 d9                	mov    %ebx,%ecx
  35:	89 da                	mov    %ebx,%edx
  37:	89 de                	mov    %ebx,%esi
  39:	cd 80                	int    $0x80
  3b:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
		goto out;

	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
	if(err)
  3e:	85 c0                	test   %eax,%eax
  40:	75 53                	jne    95 <stub_clone_handler+0x95>
  42:	be 68 00 00 00       	mov    $0x68,%esi
  47:	bb 01 00 00 00       	mov    $0x1,%ebx
  4c:	8b 55 f0             	mov    0xfffffff0(%ebp),%edx
  4f:	b9 08 f0 ff bf       	mov    $0xbffff008,%ecx
  54:	89 f0                	mov    %esi,%eax
  56:	cd 80                	int    $0x80
  58:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
		goto out;

	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
			    (long) &STUB_DATA(timer), 0);
	if(err)
  5b:	85 c0                	test   %eax,%eax
  5d:	75 36                	jne    95 <stub_clone_handler+0x95>
  5f:	8b 35 04 f0 ff bf    	mov    0xbffff004,%esi
  65:	bb 00 f0 ff bf       	mov    $0xbffff000,%ebx
  6a:	b9 00 10 00 00       	mov    $0x1000,%ecx
  6f:	ba 03 00 00 00       	mov    $0x3,%edx
  74:	89 75 ec             	mov    %esi,0xffffffec(%ebp)
  77:	8b 3d 00 f0 ff bf    	mov    0xbffff000,%edi
  7d:	be 11 00 00 00       	mov    $0x11,%esi
  82:	89 f8                	mov    %edi,%eax
  84:	8b 7d ec             	mov    0xffffffec(%ebp),%edi
  87:	55                   	push   %ebp
  88:	89 c5                	mov    %eax,%ebp
  8a:	b8 c0 00 00 00       	mov    $0xc0,%eax
  8f:	cd 80                	int    $0x80
  91:	5d                   	pop    %ebp
  92:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
		goto out;

	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
			    STUB_DATA(fd), STUB_DATA(offset));
 out:
	/* save current result. Parent: pid; child: retcode of mmap */
	STUB_DATA(err) = err;
  95:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
  98:	a3 18 f0 ff bf       	mov    %eax,0xbffff018
  9d:	cc                   	int3   
	trap_myself();
}
  9e:	8b 5d f4             	mov    0xfffffff4(%ebp),%ebx
  a1:	8b 75 f8             	mov    0xfffffff8(%ebp),%esi
  a4:	8b 7d fc             	mov    0xfffffffc(%ebp),%edi
  a7:	89 ec                	mov    %ebp,%esp
  a9:	5d                   	pop    %ebp
  aa:	c3                   	ret    



-- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQ48ey4CLcPvd0N1lAQKEogf8C3hV1EFyFCI11LUy9AFoOz6BZ5cgkuRJ
btiUtIS6XHBBtsD7ScepQyjW47WAiaRmHW0ysstfIsHgockQfWt4OuCM9zX5LoAj
NV8tF55KiHSP63USzFpeyVeStYQXeptzwqaMto4Wa7kl0luRYRgivF6uY3pr9k5i
f0vfNLeW1VnCDX5HsUF/lKlWimvSYPkxKl2nBXcir6PVQCaqHHxXzUdfk8a2aO8L
4VMrPNY4LM88m10XSqtDU/JZJ3dzQAJ60bUGhL6ou+siFh+WVKlpb/+OA5mMa/Io
Nkd6o/KCIhKv0DUDA7hYe8oBOKuBwepCgdVqSKnq40V371O6+HRCkg==
=8F/p
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
