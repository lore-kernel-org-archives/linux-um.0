Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52715AD1.7000703@gmx.de>
Date: Wed, 30 Oct 2013 20:15:29 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <526696BF.6050909@gmx.de> <CAFLxGvy3NeRKu+KQCCm0j4LS60PYhH0bC8WWjfiPvpstPBjAkA@mail.gmail.com> <5266A698.10400@gmx.de> <5266B60A.1000005@nod.at>
In-Reply-To: <5266B60A.1000005@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] fuzz tested 32 bit user mode linux image hangs in
 radix_tree_next_chunk()
To: Richard Weinberger <richard@nod.at>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 10/22/2013 07:29 PM, Richard Weinberger wrote:
> Am 22.10.2013 18:23, schrieb Toralf F=C3=B6rster:
>> On 10/22/2013 06:12 PM, Richard Weinberger wrote:
>>> On Tue, Oct 22, 2013 at 5:16 PM, Toralf F=C3=B6rster <toralf.foerst=
er@gmx.de> wrote:
>>>>
>>>> When I fuzz testing a 32 bit UML at a 32 bit host (guest 3.12.-rc6=
-x, host 3.11.6) with trinity
>>>> and use hostfs for the victom files for trinity. then trintiy ofte=
n hangs while trying to finish.
>>>>
>>>> At the host I do have 1 process eating 100% CPU power of 1 core. A=
 back trace of thet linux process at the hosts gives :
>>>>
>>>> tfoerste@n22 ~ $ sudo gdb /usr/local/bin/linux-v3.12-rc6-57-g69c88=
dc 16749 -n -batch -ex bt
>>>> radix_tree_next_chunk (root=3D0x21, iter=3D0x47647c60, flags=3D12)=
 at lib/radix-tree.c:769
>>>> 769                                     while (++offset < RADIX_TR=
EE_MAP_SIZE) {
>>>> #0  radix_tree_next_chunk (root=3D0x21, iter=3D0x47647c60, flags=3D=
12) at lib/radix-tree.c:769
>>>> #1  0x080cc13e in find_get_pages (mapping=3D0x483ed240, start=3D0,=
 nr_pages=3D14, pages=3D0xc) at mm/filemap.c:844
>>>> #2  0x080d5caa in pagevec_lookup (pvec=3D0x47647cc4, mapping=3D0x2=
1, start=3D33, nr_pages=3D33) at mm/swap.c:914
>>>> #3  0x080d609a in truncate_inode_pages_range (mapping=3D0x483ed240=
, lstart=3D0, lend=3D-1) at mm/truncate.c:241
>>>> #4  0x080d643f in truncate_inode_pages (mapping=3D0x21, lstart=3D5=
1539607585) at mm/truncate.c:358
>>>> #5  0x08260838 in hostfs_evict_inode (inode=3D0x483ed188) at fs/ho=
stfs/hostfs_kern.c:242
>>>> #6  0x0811a8cf in evict (inode=3D0x483ed188) at fs/inode.c:549
>>>> #7  0x0811b2ad in iput_final (inode=3D<optimized out>) at fs/inode=
=2Ec:1391
>>>> #8  iput (inode=3D0x483ed188) at fs/inode.c:1409
>>>> #9  0x08117648 in dentry_iput (dentry=3D<optimized out>) at fs/dca=
che.c:331
>>>> #10 d_kill (dentry=3D0x47d6d580, parent=3D0x47d95d10) at fs/dcache=
=2Ec:477
>>>> #11 0x08118068 in dentry_kill (dentry=3D<optimized out>, unlock_on=
_failure=3D<optimized out>) at fs/dcache.c:586
>>>> #12 dput (dentry=3D0x47d6d580) at fs/dcache.c:641
>>>> #13 0x08104903 in __fput (file=3D0x47471840) at fs/file_table.c:26=
4
>>>> #14 0x0810496b in ____fput (work=3D0x47471840) at fs/file_table.c:=
282
>>>> #15 0x08094496 in task_work_run () at kernel/task_work.c:123
>>>> #16 0x0807efd2 in exit_task_work (task=3D<optimized out>) at inclu=
de/linux/task_work.h:21
>>>> #17 do_exit (code=3D1196535808) at kernel/exit.c:787
>>>> #18 0x0807f5dd in do_group_exit (exit_code=3D0) at kernel/exit.c:9=
20
>>>> #19 0x0807f649 in SYSC_exit_group (error_code=3D<optimized out>) a=
t kernel/exit.c:931
>>>> #20 SyS_exit_group (error_code=3D0) at kernel/exit.c:929
>>>> #21 0x08062984 in handle_syscall (r=3D0x4763b1d4) at arch/um/kerne=
l/skas/syscall.c:35
>>>> #22 0x08074fb5 in handle_trap (local_using_sysemu=3D<optimized out=
>, regs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/s=
kas/process.c:198
>>>> #23 userspace (regs=3D0x4763b1d4) at arch/um/os-Linux/skas/process=
=2Ec:431
>>>> #24 0x0805f750 in fork_handler () at arch/um/kernel/process.c:160
>>>> #25 0x00000000 in ?? ()
>>>>
>>>
>>> That trace is identical to the one you reported yesterday.
>>> But this time no nfs is in the game, right?
>>>
>>
>> Right - I could narrow down it in the meanwhile to hostfs only. Firs=
t I
>> argued if NFS sometimes might force the issue to happen later but in=
 the
>> mean while I don't think so.
>=20
> It looks like we never find a way out of the while(1) in
> radix_tree_next_chunk().
>=20

=46WIW here's a slightly different and much shorter gdb back trace=20

tfoerste@n22 ~/devel/linux $ sudo gdb /usr/local/bin/linux-v3.12-rc7 31=
05 -n -batch -ex bt
0x08298f16 in radix_tree_next_chunk (root=3D0x0, iter=3D0x46c2fcec, fla=
gs=3D18) at lib/radix-tree.c:756
756                     if ((flags & RADIX_TREE_ITER_TAGGED) ?
#0  0x08298f16 in radix_tree_next_chunk (root=3D0x0, iter=3D0x46c2fcec,=
 flags=3D18) at lib/radix-tree.c:756
#1  0x080cc20e in find_get_pages (mapping=3D0x26c35130, start=3D0, nr_p=
ages=3D14, pages=3D0x12) at mm/filemap.c:844
#2  0x080d5d7a in pagevec_lookup (pvec=3D0x46c2fd50, mapping=3D0x0, sta=
rt=3D0, nr_pages=3D0) at mm/swap.c:914
#3  0x080d616a in truncate_inode_pages_range (mapping=3D0x26c35130, lst=
art=3D0, lend=3D-1) at mm/truncate.c:241
#4  0x080d650f in truncate_inode_pages (mapping=3D0x0, lstart=3D7730941=
1328) at mm/truncate.c:358
#5  0x0818d7e2 in ext4_evict_inode (inode=3D0x26c35078) at fs/ext4/inod=
e.c:228
#6  0x0811a99f in evict (inode=3D0x26c35078) at fs/inode.c:549
#7  0x0811b37d in iput_final (inode=3D<optimized out>) at fs/inode.c:13=
91
#8  iput (inode=3D0x26c35078) at fs/inode.c:1409
#9  0x08111717 in do_unlinkat (dfd=3D5, pathname=3D0x80686c4 <create_pr=
oc_mconsole+4> "_\b\205\322tJU\211\345\203\354\024\307D$\020") at fs/na=
mei.c:3730
#10 0x08111835 in SYSC_unlinkat (flag=3D<optimized out>, pathname=3D<op=
timized out>, dfd=3D<optimized out>) at fs/namei.c:3756
#11 SyS_unlinkat (dfd=3D5, pathname=3D134645444, flag=3D0) at fs/namei.=
c:3748
#12 0x08062984 in handle_syscall (r=3D0x48408dd4) at arch/um/kernel/ska=
s/syscall.c:35
#13 0x08074fb5 in handle_trap (local_using_sysemu=3D<optimized out>, re=
gs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas/p=
rocess.c:198
#14 userspace (regs=3D0x48408dd4) at arch/um/os-Linux/skas/process.c:43=
1
#15 0x0805f750 in fork_handler () at arch/um/kernel/process.c:160
#16 0x5a5a5a5a in ?? ()

> Thanks,
> //richard
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

