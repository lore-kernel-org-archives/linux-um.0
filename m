Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWd7y-0000If-AJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 08:02:50 -0800
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWd7w-0001Us-16 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 08:02:50 -0800
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id LAA09919
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Nov 2004 11:07:48 -0500 (EST)
Message-ID: <41A35EF5.4080302@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1DA6A216F45B1645087CD5DD"
Subject: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace
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
Date: Tue, 23 Nov 2004 11:01:57 -0500
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DA6A216F45B1645087CD5DD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hello uml folks,

i know things are hot and heavy in 2.6 but i hope
somebody can spare a thought about this panic i'm
struggling to understand.

i know UML touches shmem.c - lightly and i'd like
to think it's a kernel bug w/ shmem but we run this
2.4.20 kernel on hardware with the same applications
and do not see this failure.

host is RH9 2.4.20-31.9 + skas
guest is UML 2.4.26-3um
backported to 2.4.20-montavista 3.1 pro

(gdb) bt
#0  0x08167aca in nanosleep () at proc_fs.h:154
#1  0x081679cb in sleep () at proc_fs.h:154
#2  0x080e3bc1 in stop () at user_util.c:52
#3  0x080e37ec in panic_waitonerr (self=0x81f77cc, unused1=0, 
unused2=0x8206120) at um_arch.c:457
#4  0x0805eeb2 in notifier_call_chain (n=0xfffffffc, val=0, v=0x8206120) 
at sys.c:131
#5  0x08053bb3 in panic (fmt=0x81c99c0 "Kernel mode fault at addr 0x%lx, 
ip 0x%lx") at panic.c:69
#6  0x080e2efd in segv (address=0, ip=1078054417, is_write=0, is_user=0, 
sc=0x30da82a4) at trap_kern.c:149
#7  0x080e31cd in segv_handler (sig=11, regs=0x30da82a4) at trap_user.c:74
#8  0x080e5611 in sig_handler_common_skas (sig=11, sc_ptr=0x58) at 
trap_user.c:35
#9  0x080e31ee in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, 
__fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 49168, edi = 336, esi = 
818643476, ebp = 819657132, esp = 819657124, ebx = 0, edx = 42, ecx = 
818643560, eax = 0, trapno = 14, err = 4, eip = 134682879, cs = 35, 
__csh = 0, eflags = 2163270, esp_at_signal = 819657124, ss = 43, __ssh = 
0, fpstate = 0x0, oldmask = 134217728, cr2 = 0}) at trap_user.c:109
#10 <signal handler called>
#11 shmem_block (index=42, page=0x0, direct=0x0, indirect=0x30cb8268) at 
shmem.c:149
#12 0x08071984 in shmem_swp_entry (info=0x0, index=42, page=0x0) at 
shmem.c:182
#13 0x08071aa5 in shmem_truncate (inode=0x30cb8100) at shmem.c:349
#14 0x08064772 in vmtruncate (inode=0x30cb8100, offset=172368) at 
memory.c:1128
#15 0x080898b9 in inode_setattr (inode=0x30cb8100, attr=0x30dafb24) at 
attr.c:67
#16 0x08071c16 in shmem_notify_change (dentry=0x0, attr=0x30dafb24) at 
shmem.c:398
#17 0x08089a3d in notify_change (dentry=0x30ed4878, attr=0x30dafb24) at 
attr.c:132
#18 0x08073f4a in do_truncate (dentry=0x30ed4878, length=172368) at 
open.c:113
#19 0x080751bf in do_sys_ftruncate (fd=0, length=172368, small=1) at 
open.c:220
#20 0x08073f8f in sys_ftruncate (fd=21, length=172368) at open.c:229
#21 0x080e5162 in execute_syscall_skas (r=0x2a) at syscall_kern.c:28
#22 0x080e5192 in handle_syscall (regs=0x30da82a4) at syscall_user.c:26
#23 0x080e43c1 in handle_trap (pid=5308, regs=0x30da82a4) at process.c:85
#24 0x080e4693 in userspace (regs=0x30da82a4) at process.c:160
#25 0x080e4dae in fork_handler (sig=10) at process_kern.c:104
#26 <signal handler called>
#27 0x0815a631 in kill () at proc_fs.h:154
#28 0x080e8708 in os_usr1_process (pid=5304) at process.c:98
#29 0x080e4706 in new_thread (stack=Cannot access memory at address 0x8
) at process.c:197

-- 
db


--------------enig1DA6A216F45B1645087CD5DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBo1753XQ4zakZ3z4RAsXcAJ9XL2D/WyOjj3sGiH/HhZVRT/4JswCfTOix
MMPO99Ftc60ciJwCJTBgBwU=
=8gOm
-----END PGP SIGNATURE-----

--------------enig1DA6A216F45B1645087CD5DD--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
