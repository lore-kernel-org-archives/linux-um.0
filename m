Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <527FA2BE.6090307@gmx.de>
Date: Sun, 10 Nov 2013 16:14:06 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <526696BF.6050909@gmx.de>	<CAFLxGvy3NeRKu+KQCCm0j4LS60PYhH0bC8WWjfiPvpstPBjAkA@mail.gmail.com>	<5266A698.10400@gmx.de>	<5266B60A.1000005@nod.at>	<52715AD1.7000703@gmx.de> <CALYGNiPvJF1u8gXNcX1AZR5-VkGqJnaose84KBbdaoBAq8aoGQ@mail.gmail.com> <527AB23D.2060305@gmx.de> <527AB51B.1020005@nod.at>
In-Reply-To: <527AB51B.1020005@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] fuzz tested 32 bit user mode linux image hangs in
 radix_tree_next_chunk()
To: Richard Weinberger <richard@nod.at>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 11/06/2013 10:31 PM, Richard Weinberger wrote:
> Am 06.11.2013 22:18, schrieb Toralf F=C3=B6rster:
>> On 11/06/2013 05:06 PM, Konstantin Khlebnikov wrote:
>>> In this case it must stop after scanning whole tree in line:
>>> /* Overflow after ~0UL */
>>> if (!index)
>>>   return NULL;
>>>
>>
>> A fresh current example with latest git tree shows that lines 769 an=
d 770 do alternate :
>=20
> Can you please ask gdb for the value of offset?
>=20
> Thanks,
> //richard
>=20

With this change=20

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 7811ed3..b2e9db5 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -767,6 +767,7 @@ restart:
                                                offset + 1);
                        else
                                while (++offset < RADIX_TREE_MAP_SIZE) =
{
+                                       printk ("node->slots[offset] %p=
 offeset %lu\n", node->slots[offset], offset);
                                        if (node->slots[offset])
                                                break;
                                }

against v3.12-48-gbe408cd these are the last lines in the syslog of the=
 UML
(command: ssh root@trinity "tail -f /var/log/messages")

=2E..
Nov 10 13:26:32 trinity kernel: node->slots[offset]   (null) offeset 23
Nov 10 13:26:32 trinity kernel: node->slots[offset]   (null) offeset 24
Nov 10 13:26:32 trinity kernel: node->slots[offset]   (null) offeset 25
Nov 10 13:26:32 trinity kernel: node->slots[offset]   (null) offeset 26
Nov 10 13:26:32 trinity kernel: node->slots[offset]   (null) offeset 27
=2E..
Nov 10 13:49:11 trinity sshd[3628]: pam_unix(sshd:session): session clo=
sed for user tfoerste
Nov 10 13:49:15 trinity sshd[3858]: pam_unix(sshd:session): session ope=
ned for user tfoerste by (uid=3D0)
Nov 10 13:49:15 trinity su[3862]: Successful su for root by root
Nov 10 13:49:15 trinity su[3862]: + ??? root:root
Nov 10 13:49:15 trinity su[3862]: pam_unix(su:session): session opened =
for user root by (uid=3D0)
Nov 10 13:49:15 trinity su[3862]: pam_unix(su:session): session closed =
for user root
Nov 10 13:49:15 trinity tfoerste: M=3D/mnt/hostfs


It is now at (I left the computer for a while) and I gdo et this output=
 of 3 subsequent calls of the gdb back trace at the host system :


tfoerste@n22 ~/devel/linux $ sudo gdb /home/tfoerste/devel/linux/linux =
8946 -n -batch -ex bt
string (buf=3D0x8609ef9 <textbuf.25662+25> "ll) offeset 4\n", end=3D0x8=
60a2c0 <cont> "4721fffc:  [<00000000>] 0x0k_handler+0x60/0x700360d/0x4e=
00ffff 00000000 4721fc0c:  [<0805f8cc>] __switch_to+0x5c/0xf0", s=3D0x8=
4c0980 <null+3> "ll)", spec=3D...) at lib/vsprintf.c:524
524                             *buf =3D *s;
#0  string (buf=3D0x8609ef9 <textbuf.25662+25> "ll) offeset 4\n", end=3D=
0x860a2c0 <cont> "4721fffc:  [<00000000>] 0x0k_handler+0x60/0x700360d/0=
x4e00ffff 00000000 4721fc0c:  [<0805f8cc>] __switch_to+0x5c/0xf0", s=3D=
0x84c0980 <null+3> "ll)", spec=3D...) at lib/vsprintf.c:524
#1  0x0829ac42 in pointer (fmt=3D0x75 <Address 0x75 out of bounds>, buf=
=3D0x8609ef4 <textbuf.25662+20> "  (null) offeset 4\n", end=3D0x5 <Addr=
ess 0x5 out of bounds>, ptr=3D0x0, spec=3D...) at lib/vsprintf.c:1239
#2  0x0829a9dd in vsnprintf (buf=3D0x8609ee0 <textbuf.25662> "node->slo=
ts[offset]   (null) offeset 4\n", size=3D992, fmt=3D0x8609efc <textbuf.=
25662+28> " offeset 4\n", args=3D0x4370fc10 "") at lib/vsprintf.c:1667
#3  0x0829b0f7 in vscnprintf (buf=3D0x75 <Address 0x75 out of bounds>, =
size=3D992, fmt=3D0x75 <Address 0x75 out of bounds>, args=3D0x75 <Addre=
ss 0x75 out of bounds>) at lib/vsprintf.c:1776
#4  0x080a6968 in vprintk_emit (facility=3D0, level=3D-1, dict=3D0x0, d=
ictlen=3D0, fmt=3D0x75 <Address 0x75 out of bounds>, args=3D0x75 <Addre=
ss 0x75 out of bounds>) at kernel/printk/printk.c:1548
#5  0x08419b05 in printk (fmt=3D0x75 <Address 0x75 out of bounds>) at k=
ernel/printk/printk.c:1690
#6  0x08296a8d in radix_tree_next_chunk (root=3D0x75, iter=3D0x4370fc54=
, flags=3D0) at lib/radix-tree.c:770
#7  0x080cc1fe in find_get_pages (mapping=3D0x44bb707c, start=3D0, nr_p=
ages=3D14, pages=3D0x5) at mm/filemap.c:844
#8  0x080d5d6a in pagevec_lookup (pvec=3D0x4370fcb8, mapping=3D0x75, st=
art=3D117, nr_pages=3D117) at mm/swap.c:914
#9  0x080d615a in truncate_inode_pages_range (mapping=3D0x44bb707c, lst=
art=3D32809, lend=3D-1) at mm/truncate.c:241
#10 0x080d64ff in truncate_inode_pages (mapping=3D0x75, lstart=3D214748=
36597) at mm/truncate.c:358
#11 0x080d6a0d in truncate_pagecache (inode=3D0x75, newsize=3D32809) at=
 mm/truncate.c:597
#12 0x081d9118 in nfs_vmtruncate (offset=3D<optimized out>, inode=3D<op=
timized out>) at fs/nfs/inode.c:554
#13 nfs_setattr_update_inode (inode=3D0x44bb6fc4, attr=3D0x8029) at fs/=
nfs/inode.c:585
#14 0x081e73ba in nfs_proc_setattr (dentry=3D0x75, fattr=3D0x0, sattr=3D=
0x4370fe1c) at fs/nfs/proc.c:142
#15 0x081da99c in nfs_setattr (dentry=3D0x47fb5b00, attr=3D0x4370fe1c) =
at fs/nfs/inode.c:523
#16 0x0811c256 in notify_change (dentry=3D0x47fb5b00, attr=3D0x4370fe1c=
) at fs/attr.c:248
#17 0x081011bb in do_truncate (dentry=3D0x47fb5b00, length=3D5025112064=
41, time_attrs=3D5, filp=3D0x8609efc <textbuf.25662+28>) at fs/open.c:6=
0
#18 0x081013f2 in do_sys_ftruncate (fd=3D117, length=3D32809, small=3D1=
) at fs/open.c:190
#19 0x081016da in SYSC_ftruncate (length=3D<optimized out>, fd=3D<optim=
ized out>) at fs/open.c:200
#20 SyS_ftruncate (fd=3D129, length=3D32809) at fs/open.c:198
#21 0x08062974 in handle_syscall (r=3D0x473c9fd4) at arch/um/kernel/ska=
s/syscall.c:35
#22 0x08074fa5 in handle_trap (local_using_sysemu=3D<optimized out>, re=
gs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas/p=
rocess.c:198
#23 userspace (regs=3D0x473c9fd4) at arch/um/os-Linux/skas/process.c:43=
1
#24 0x0805f740 in fork_handler () at arch/um/kernel/process.c:160
#25 0x00000000 in ?? ()

tfoerste@n22 ~/devel/linux $ sudo gdb /home/tfoerste/devel/linux/linux =
8946 -n -batch -ex bt
0x082995e7 in string (buf=3D0x8609ef8 <textbuf.25662+24> "ull) offeset =
57\n", end=3D0x860a2c0 <cont> "4721fffc:  [<00000000>] 0x0k_handler+0x6=
0/0x700360d/0x4e00ffff 00000000 4721fc0c:  [<0805f8cc>] __switch_to+0x5=
c/0xf0", s=3D0x84c097f <null+2> "ull)", spec=3D...) at lib/vsprintf.c:5=
24
524                             *buf =3D *s;
#0  0x082995e7 in string (buf=3D0x8609ef8 <textbuf.25662+24> "ull) offe=
set 57\n", end=3D0x860a2c0 <cont> "4721fffc:  [<00000000>] 0x0k_handler=
+0x60/0x700360d/0x4e00ffff 00000000 4721fc0c:  [<0805f8cc>] __switch_to=
+0x5c/0xf0", s=3D0x84c097f <null+2> "ull)", spec=3D...) at lib/vsprintf=
=2Ec:524
#1  0x0829ac42 in pointer (fmt=3D0x75 <Address 0x75 out of bounds>, buf=
=3D0x8609ef4 <textbuf.25662+20> "  (null) offeset 57\n", end=3D0x5 <Add=
ress 0x5 out of bounds>, ptr=3D0x0, spec=3D...) at lib/vsprintf.c:1239
#2  0x0829a9dd in vsnprintf (buf=3D0x8609ee0 <textbuf.25662> "node->slo=
ts[offset]   (null) offeset 57\n", size=3D992, fmt=3D0x8609efc <textbuf=
=2E25662+28> " offeset 57\n", args=3D0x4370fc10 "") at lib/vsprintf.c:1=
667
#3  0x0829b0f7 in vscnprintf (buf=3D0x75 <Address 0x75 out of bounds>, =
size=3D992, fmt=3D0x75 <Address 0x75 out of bounds>, args=3D0x75 <Addre=
ss 0x75 out of bounds>) at lib/vsprintf.c:1776
#4  0x080a6968 in vprintk_emit (facility=3D0, level=3D-1, dict=3D0x0, d=
ictlen=3D0, fmt=3D0x75 <Address 0x75 out of bounds>, args=3D0x75 <Addre=
ss 0x75 out of bounds>) at kernel/printk/printk.c:1548
#5  0x08419b05 in printk (fmt=3D0x75 <Address 0x75 out of bounds>) at k=
ernel/printk/printk.c:1690
#6  0x08296a8d in radix_tree_next_chunk (root=3D0x75, iter=3D0x4370fc54=
, flags=3D0) at lib/radix-tree.c:770
#7  0x080cc1fe in find_get_pages (mapping=3D0x44bb707c, start=3D0, nr_p=
ages=3D14, pages=3D0x5) at mm/filemap.c:844
#8  0x080d5d6a in pagevec_lookup (pvec=3D0x4370fcb8, mapping=3D0x75, st=
art=3D117, nr_pages=3D117) at mm/swap.c:914
#9  0x080d615a in truncate_inode_pages_range (mapping=3D0x44bb707c, lst=
art=3D32809, lend=3D-1) at mm/truncate.c:241
#10 0x080d64ff in truncate_inode_pages (mapping=3D0x75, lstart=3D214748=
36597) at mm/truncate.c:358
#11 0x080d6a0d in truncate_pagecache (inode=3D0x75, newsize=3D32809) at=
 mm/truncate.c:597
#12 0x081d9118 in nfs_vmtruncate (offset=3D<optimized out>, inode=3D<op=
timized out>) at fs/nfs/inode.c:554
#13 nfs_setattr_update_inode (inode=3D0x44bb6fc4, attr=3D0x8029) at fs/=
nfs/inode.c:585
#14 0x081e73ba in nfs_proc_setattr (dentry=3D0x75, fattr=3D0x0, sattr=3D=
0x4370fe1c) at fs/nfs/proc.c:142
#15 0x081da99c in nfs_setattr (dentry=3D0x47fb5b00, attr=3D0x4370fe1c) =
at fs/nfs/inode.c:523
#16 0x0811c256 in notify_change (dentry=3D0x47fb5b00, attr=3D0x4370fe1c=
) at fs/attr.c:248
#17 0x081011bb in do_truncate (dentry=3D0x47fb5b00, length=3D5025112064=
41, time_attrs=3D5, filp=3D0x8609efc <textbuf.25662+28>) at fs/open.c:6=
0
#18 0x081013f2 in do_sys_ftruncate (fd=3D117, length=3D32809, small=3D1=
) at fs/open.c:190
#19 0x081016da in SYSC_ftruncate (length=3D<optimized out>, fd=3D<optim=
ized out>) at fs/open.c:200
#20 SyS_ftruncate (fd=3D129, length=3D32809) at fs/open.c:198
#21 0x08062974 in handle_syscall (r=3D0x473c9fd4) at arch/um/kernel/ska=
s/syscall.c:35
#22 0x08074fa5 in handle_trap (local_using_sysemu=3D<optimized out>, re=
gs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas/p=
rocess.c:198
#23 userspace (regs=3D0x473c9fd4) at arch/um/os-Linux/skas/process.c:43=
1
#24 0x0805f740 in fork_handler () at arch/um/kernel/process.c:160
#25 0x00000000 in ?? ()


tfoerste@n22 ~/devel/linux $ sudo gdb /home/tfoerste/devel/linux/linux =
8946 -n -batch -ex bt
string (buf=3D0x8609efb <textbuf.25662+27> ") offeset 20\n", end=3D0x86=
0a2c0 <cont> "4721fffc:  [<00000000>] 0x0k_handler+0x60/0x700360d/0x4e0=
0ffff 00000000 4721fc0c:  [<0805f8cc>] __switch_to+0x5c/0xf0", s=3D0x84=
c0982 <null+5> ")", spec=3D...) at lib/vsprintf.c:524
524                             *buf =3D *s;
#0  string (buf=3D0x8609efb <textbuf.25662+27> ") offeset 20\n", end=3D=
0x860a2c0 <cont> "4721fffc:  [<00000000>] 0x0k_handler+0x60/0x700360d/0=
x4e00ffff 00000000 4721fc0c:  [<0805f8cc>] __switch_to+0x5c/0xf0", s=3D=
0x84c0982 <null+5> ")", spec=3D...) at lib/vsprintf.c:524
#1  0x0829ac42 in pointer (fmt=3D0x6c <Address 0x6c out of bounds>, buf=
=3D0x8609ef4 <textbuf.25662+20> "  (null) offeset 20\n", end=3D0x5 <Add=
ress 0x5 out of bounds>, ptr=3D0x0, spec=3D...) at lib/vsprintf.c:1239
#2  0x0829a9dd in vsnprintf (buf=3D0x8609ee0 <textbuf.25662> "node->slo=
ts[offset]   (null) offeset 20\n", size=3D992, fmt=3D0x8609efc <textbuf=
=2E25662+28> " offeset 20\n", args=3D0x4370fc10 "") at lib/vsprintf.c:1=
667
#3  0x0829b0f7 in vscnprintf (buf=3D0x6c <Address 0x6c out of bounds>, =
size=3D992, fmt=3D0x6c <Address 0x6c out of bounds>, args=3D0x6c <Addre=
ss 0x6c out of bounds>) at lib/vsprintf.c:1776
#4  0x080a6968 in vprintk_emit (facility=3D0, level=3D-1, dict=3D0x0, d=
ictlen=3D0, fmt=3D0x6c <Address 0x6c out of bounds>, args=3D0x6c <Addre=
ss 0x6c out of bounds>) at kernel/printk/printk.c:1548
#5  0x08419b05 in printk (fmt=3D0x6c <Address 0x6c out of bounds>) at k=
ernel/printk/printk.c:1690
#6  0x08296a8d in radix_tree_next_chunk (root=3D0x6c, iter=3D0x4370fc54=
, flags=3D0) at lib/radix-tree.c:770
#7  0x080cc1fe in find_get_pages (mapping=3D0x44bb707c, start=3D0, nr_p=
ages=3D14, pages=3D0x5) at mm/filemap.c:844
#8  0x080d5d6a in pagevec_lookup (pvec=3D0x4370fcb8, mapping=3D0x6c, st=
art=3D108, nr_pages=3D108) at mm/swap.c:914
#9  0x080d615a in truncate_inode_pages_range (mapping=3D0x44bb707c, lst=
art=3D32809, lend=3D-1) at mm/truncate.c:241
#10 0x080d64ff in truncate_inode_pages (mapping=3D0x6c, lstart=3D214748=
36588) at mm/truncate.c:358
#11 0x080d6a0d in truncate_pagecache (inode=3D0x6c, newsize=3D32809) at=
 mm/truncate.c:597
#12 0x081d9118 in nfs_vmtruncate (offset=3D<optimized out>, inode=3D<op=
timized out>) at fs/nfs/inode.c:554
#13 nfs_setattr_update_inode (inode=3D0x44bb6fc4, attr=3D0x8029) at fs/=
nfs/inode.c:585
#14 0x081e73ba in nfs_proc_setattr (dentry=3D0x6c, fattr=3D0x0, sattr=3D=
0x4370fe1c) at fs/nfs/proc.c:142
#15 0x081da99c in nfs_setattr (dentry=3D0x47fb5b00, attr=3D0x4370fe1c) =
at fs/nfs/inode.c:523
#16 0x0811c256 in notify_change (dentry=3D0x47fb5b00, attr=3D0x4370fe1c=
) at fs/attr.c:248
#17 0x081011bb in do_truncate (dentry=3D0x47fb5b00, length=3D4638565007=
77, time_attrs=3D5, filp=3D0x8609efc <textbuf.25662+28>) at fs/open.c:6=
0
#18 0x081013f2 in do_sys_ftruncate (fd=3D108, length=3D32809, small=3D1=
) at fs/open.c:190
#19 0x081016da in SYSC_ftruncate (length=3D<optimized out>, fd=3D<optim=
ized out>) at fs/open.c:200
#20 SyS_ftruncate (fd=3D129, length=3D32809) at fs/open.c:198
#21 0x08062974 in handle_syscall (r=3D0x473c9fd4) at arch/um/kernel/ska=
s/syscall.c:35
#22 0x08074fa5 in handle_trap (local_using_sysemu=3D<optimized out>, re=
gs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas/p=
rocess.c:198
#23 userspace (regs=3D0x473c9fd4) at arch/um/os-Linux/skas/process.c:43=
1
#24 0x0805f740 in fork_handler () at arch/um/kernel/process.c:160
#25 0x00000000 in ?? ()



The fuzzer trinity is still running and tries to kill one of it childs=20
(the output comes from a ssh command, which started trinity in the UML)=
:

=2E..
w[atchdog] sending SIGKILL to pid 4345. [diff:261]
[watchdog] sending SIGKILL to pid 4346. [diff:263]
[watchdog] sending SIGKILL to pid 4344. [diff:263]
[watchdog] sending SIGKILL to pid 4345. [diff:266]
[watchdog] sending SIGKILL to pid 4346. [diff:267]
[watchdog] sending SIGKILL to pid 4344. [diff:267]
[watchdog] sending SIGKILL to pid 4345. [diff:270]
[watchdog] sending SIGKILL to pid 4346. [diff:271]
[watchdog] sending SIGKILL to pid 4344. [diff:271]
=2E..


but I cannot connect to the UML via ssh.


>>
>> tfoerste@n22 ~/devel/linux $ sudo gdb /usr/local/bin/linux-v3.12-48-=
gbe408cd 16619 -n -batch -ex bt
>> 0x08296a8c in radix_tree_next_chunk (root=3D0x25, iter=3D0x462e7c64,=
 flags=3D12) at lib/radix-tree.c:770
>> 770                                             if (node->slots[offs=
et])
>> #0  0x08296a8c in radix_tree_next_chunk (root=3D0x25, iter=3D0x462e7=
c64, flags=3D12) at lib/radix-tree.c:770
>> #1  0x080cc1fe in find_get_pages (mapping=3D0x462ad470, start=3D0, n=
r_pages=3D14, pages=3D0xc) at mm/filemap.c:844
>> #2  0x080d5d6a in pagevec_lookup (pvec=3D0x462e7cc8, mapping=3D0x25,=
 start=3D37, nr_pages=3D37) at mm/swap.c:914
>> #3  0x080d615a in truncate_inode_pages_range (mapping=3D0x462ad470, =
lstart=3D0, lend=3D-1) at mm/truncate.c:241
>> #4  0x080d64ff in truncate_inode_pages (mapping=3D0x25, lstart=3D515=
39607589) at mm/truncate.c:358
>>
>>
>>
>>
>> tfoerste@n22 ~/devel/linux $ sudo gdb /usr/local/bin/linux-v3.12-48-=
gbe408cd 16619 -n -batch -ex bt
>> radix_tree_next_chunk (root=3D0x28, iter=3D0x462e7c64, flags=3D18) a=
t lib/radix-tree.c:769
>> 769                                     while (++offset < RADIX_TREE=
_MAP_SIZE) {
>> #0  radix_tree_next_chunk (root=3D0x28, iter=3D0x462e7c64, flags=3D1=
8) at lib/radix-tree.c:769
>> #1  0x080cc1fe in find_get_pages (mapping=3D0x462ad470, start=3D0, n=
r_pages=3D14, pages=3D0x12) at mm/filemap.c:844
>> #2  0x080d5d6a in pagevec_lookup (pvec=3D0x462e7cc8, mapping=3D0x28,=
 start=3D40, nr_pages=3D40) at mm/swap.c:914
>> #3  0x080d615a in truncate_inode_pages_range (mapping=3D0x462ad470, =
lstart=3D0, lend=3D-1) at mm/truncate.c:241
>> #4  0x080d64ff in truncate_inode_pages (mapping=3D0x28, lstart=3D773=
09411368) at mm/truncate.c:358
>> #5  0x0825e388 in hostfs_evict_inode (inode=3D0x462ad3b8) at fs/host=
fs/hostfs_kern.c:242
>> #6  0x0811a8df in evict (inode=3D0x462ad3b8) at fs/inode.c:549
>>
>>
>=20
>=20


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

