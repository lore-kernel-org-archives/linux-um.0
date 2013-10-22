Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <526696BF.6050909@gmx.de>
Date: Tue, 22 Oct 2013 17:16:15 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: fuzz tested 32 bit user mode linux image hangs at in histfs
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


When I fuzz testing a 32 bit UML at a 32 bit host (guest 3.12.-rc6-x, h=
ost 3.11.6) with trinity
and use hostfs for the victom files for trinity. then trintiy often han=
gs while trying to finish.

At the host I do have 1 process eating 100% CPU power of 1 core. A back=
 trace of thet linux process at the hosts gives :

tfoerste@n22 ~ $ sudo gdb /usr/local/bin/linux-v3.12-rc6-57-g69c88dc 16=
749 -n -batch -ex bt
radix_tree_next_chunk (root=3D0x21, iter=3D0x47647c60, flags=3D12) at l=
ib/radix-tree.c:769
769                                     while (++offset < RADIX_TREE_MA=
P_SIZE) {
#0  radix_tree_next_chunk (root=3D0x21, iter=3D0x47647c60, flags=3D12) =
at lib/radix-tree.c:769
#1  0x080cc13e in find_get_pages (mapping=3D0x483ed240, start=3D0, nr_p=
ages=3D14, pages=3D0xc) at mm/filemap.c:844
#2  0x080d5caa in pagevec_lookup (pvec=3D0x47647cc4, mapping=3D0x21, st=
art=3D33, nr_pages=3D33) at mm/swap.c:914
#3  0x080d609a in truncate_inode_pages_range (mapping=3D0x483ed240, lst=
art=3D0, lend=3D-1) at mm/truncate.c:241
#4  0x080d643f in truncate_inode_pages (mapping=3D0x21, lstart=3D515396=
07585) at mm/truncate.c:358
#5  0x08260838 in hostfs_evict_inode (inode=3D0x483ed188) at fs/hostfs/=
hostfs_kern.c:242
#6  0x0811a8cf in evict (inode=3D0x483ed188) at fs/inode.c:549
#7  0x0811b2ad in iput_final (inode=3D<optimized out>) at fs/inode.c:13=
91
#8  iput (inode=3D0x483ed188) at fs/inode.c:1409
#9  0x08117648 in dentry_iput (dentry=3D<optimized out>) at fs/dcache.c=
:331
#10 d_kill (dentry=3D0x47d6d580, parent=3D0x47d95d10) at fs/dcache.c:47=
7
#11 0x08118068 in dentry_kill (dentry=3D<optimized out>, unlock_on_fail=
ure=3D<optimized out>) at fs/dcache.c:586
#12 dput (dentry=3D0x47d6d580) at fs/dcache.c:641
#13 0x08104903 in __fput (file=3D0x47471840) at fs/file_table.c:264
#14 0x0810496b in ____fput (work=3D0x47471840) at fs/file_table.c:282
#15 0x08094496 in task_work_run () at kernel/task_work.c:123
#16 0x0807efd2 in exit_task_work (task=3D<optimized out>) at include/li=
nux/task_work.h:21
#17 do_exit (code=3D1196535808) at kernel/exit.c:787
#18 0x0807f5dd in do_group_exit (exit_code=3D0) at kernel/exit.c:920
#19 0x0807f649 in SYSC_exit_group (error_code=3D<optimized out>) at ker=
nel/exit.c:931
#20 SyS_exit_group (error_code=3D0) at kernel/exit.c:929
#21 0x08062984 in handle_syscall (r=3D0x4763b1d4) at arch/um/kernel/ska=
s/syscall.c:35
#22 0x08074fb5 in handle_trap (local_using_sysemu=3D<optimized out>, re=
gs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas/p=
rocess.c:198
#23 userspace (regs=3D0x4763b1d4) at arch/um/os-Linux/skas/process.c:43=
1
#24 0x0805f750 in fork_handler () at arch/um/kernel/process.c:160
#25 0x00000000 in ?? ()


Last message of trinity's watchdog are :

=2E..
[watchdog] exit_reason=3D2, but 2 children still running.
Bailing main loop. Exit reason: Reached maximum syscall count.
[watchdog] Reached limit 10001. Telling children to exit.
[watchdog] [1516] Watchdog exiting


I'm unsure if this is only UML specific, interesting for the fs people =
or mm or ... ?


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

