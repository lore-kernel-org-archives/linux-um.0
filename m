Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1WfZ68-0001BH-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 18:19:12 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfZ67-00050e-4Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Apr 2014 18:19:12 +0000
Message-ID: <53613E96.2030006@gmx.de>
Date: Wed, 30 Apr 2014 20:19:02 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] trinity commit 23dc478aba breaks syscall "mremap" at a
 32 bit user mode linux
To: trinity@vger.kernel.org
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

-or- it uncovers a bug in kernel v3.15-rc3 for UML:



commit 23dc478aba4134db51584d19e4783ec87ce87b88
Author: Dave Jones <davej@redhat.com>
Date:   Tue Apr 29 16:42:45 2014 -0400

    non-biarch arches aren't necessarily 32-bit.

diff --git a/children/random-syscalls.c b/children/random-syscalls.c
index 82e49f5..1d7e7ce 100644
--- a/children/random-syscalls.c
+++ b/children/random-syscalls.c
@@ -32,7 +32,6 @@ static bool choose_syscall_table(void)

        if (biarch == FALSE) {
                active_syscalls = shm->active_syscalls;
-               do32 = TRUE;
        } else {

                /* First, check that we have syscalls enabled in either table. */




I do get :


Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed, errno = 3

CPU: 0 PID: 1303 Comm: trinity-c0 Not tainted 3.15.0-rc3 #1
Stack:
 085a4f54 085a4f54 4841fc48 00000004 086c8547 00002b58 00000003 00000011
 4841fc58 084eae75 00000000 00000000 4841fc80 084e72e0 085b08e8 08700960
 085ad7b4 4841fc90 00000000 00002b58 00000003 00000011 4841fcb4 080734c5
Call Trace:
 [<080734c5>] ? run_syscall_stub+0x125/0x2c0
 [<084eae75>] dump_stack+0x26/0x28
 [<084e72e0>] panic+0x7a/0x194
 [<080734c5>] run_syscall_stub+0x125/0x2c0
 [<08073b15>] unmap+0xf5/0x110
 [<08061047>] do_ops+0xb7/0x160
 [<080615f8>] fix_range_common+0x448/0x480
 [<080e50f4>] ? vma_interval_tree_insert+0x74/0x80
 [<0806193e>] flush_tlb_range+0x3e/0x40
 [<080f045e>] move_page_tables+0x24e/0x280
 [<080f0577>] move_vma+0xe7/0x230
 [<080eda20>] ? get_unmapped_area+0xa0/0xc0
 [<080f08b8>] SyS_mremap+0x1f8/0x4c0
 [<08062ab4>] handle_syscall+0x64/0x80
 [<0849d4f1>] ? ptrace+0x31/0x80
 [<080797a2>] ? get_fp_registers+0x22/0x40
 [<08074815>] userspace+0x475/0x5f0
 [<0849d4f1>] ? ptrace+0x31/0x80
 [<08079d06>] ? os_set_thread_area+0x26/0x40
 [<08078cd0>] ? do_set_thread_area+0x20/0x50
 [<08078e48>] ? arch_switch_tls+0xb8/0x100
 [<0805f770>] fork_handler+0x60/0x70

/home/tfoerste/workspace/bin/start_uml.sh: line 110:  9558 Aborted                 (core dumped) $LINUX earlyprintk ubda=$ROOTFS ubdb=$SWAP eth0=$NET mem=$MEM $TTY umid=uml_$NAME rootfstype=ext4 "$ARGS"


-- 
Toralf


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

