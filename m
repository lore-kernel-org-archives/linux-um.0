Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52A36389.7010103@gmx.de>
Date: Sat, 07 Dec 2013 19:06:01 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <529217CD.1000204@gmx.de> <20131203140214.GB31128@quack.suse.cz> <529E3450.9000700@gmx.de> <20131203230058.GA24037@quack.suse.cz> <20131204130639.GA31973@quack.suse.cz>
In-Reply-To: <20131204130639.GA31973@quack.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: why does index in truncate_inode_pages_range() grows so much
 ?
To: Jan Kara <jack@suse.cz>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 12/04/2013 02:06 PM, Jan Kara wrote:
>   One idea: Can you add
> WARN_ON(offset > 10000000);
>   into mm/filemap.c:add_to_page_cache_locked() ? That should tell us
> whether someone is indeed inserting pages with strange indices into p=
age
> cache or if page->index got somehow corrupted.
>=20
>  								Honza
>> >=20

With this diff :

diff --git a/mm/filemap.c b/mm/filemap.c
index b7749a9..e95d90c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -463,6 +463,7 @@ int add_to_page_cache_locked(struct page *page, str=
uct address_space *mapping,

        VM_BUG_ON(!PageLocked(page));
        VM_BUG_ON(PageSwapBacked(page));
+       WARN_ON(offset > 10000000);

        error =3D mem_cgroup_cache_charge(page, current->mm,
                                        gfp_mask & GFP_RECLAIM_MASK);



I do get such things :

Dec  7 18:01:29 trinity tfoerste: M=3D1
Dec  7 18:01:36 trinity kernel: type=3D1006 audit(1386435689.994:3): pi=
d=3D1260 uid=3D0 old auid=3D4294967295 new auid=3D1000 old ses=3D429496=
7295 new ses=3D2 res=3D1
Dec  7 18:01:42 trinity kernel: warning: process `trinity-child0' used =
the deprecated sysctl system call with
Dec  7 18:01:42 trinity kernel: VFS: Warning: trinity-child0 using old =
stat() call. Recompile your binary.
Dec  7 18:01:44 trinity kernel: ------------[ cut here ]------------
Dec  7 18:01:44 trinity kernel: WARNING: CPU: 0 PID: 1478 at mm/filemap=
=2Ec:466 add_to_page_cache_locked+0x34/0xf0()
Dec  7 18:01:44 trinity kernel: CPU: 0 PID: 1478 Comm: trinity-child0 N=
ot tainted 3.13.0-rc3-dirty #16
Dec  7 18:01:44 trinity kernel: Stack:
Dec  7 18:01:44 trinity kernel: 084c0773 084c0773 49be7ca8 00000004 085=
d0547 49be0000 00000000 084ce2d4
Dec  7 18:01:44 trinity kernel: 49be7cb8 08425f7f 00000000 00000000 49b=
e7cf0 0807d43b 084cc244 00000000
Dec  7 18:01:44 trinity kernel: 000005c6 084ce2d4 000001d2 080cb714 080=
cb714 000001d2 49be7cfc 0b811b60
Dec  7 18:01:44 trinity kernel: Call Trace:
Dec  7 18:01:44 trinity kernel: [<08425f7f>] dump_stack+0x26/0x28
Dec  7 18:01:44 trinity kernel: [<0807d43b>] warn_slowpath_common+0x7b/=
0xa0
Dec  7 18:01:44 trinity kernel: [<080cb714>] ? add_to_page_cache_locked=
+0x34/0xf0
Dec  7 18:01:44 trinity kernel: [<080cb714>] ? add_to_page_cache_locked=
+0x34/0xf0
Dec  7 18:01:44 trinity kernel: [<0807d503>] warn_slowpath_null+0x23/0x=
30
Dec  7 18:01:44 trinity kernel: [<080cb714>] add_to_page_cache_locked+0=
x34/0xf0
Dec  7 18:01:44 trinity kernel: [<080cb7fb>] add_to_page_cache_lru+0x2b=
/0x50
Dec  7 18:01:44 trinity kernel: [<080cd38b>] generic_file_aio_read+0x57=
b/0x710
Dec  7 18:01:44 trinity kernel: [<081035ee>] do_sync_read+0x6e/0xa0
Dec  7 18:01:44 trinity kernel: [<08104199>] vfs_read+0xa9/0x180
Dec  7 18:01:44 trinity kernel: [<081047cc>] SyS_pread64+0x6c/0xa0
Dec  7 18:01:44 trinity kernel: [<08062a94>] handle_syscall+0x64/0x80
Dec  7 18:01:44 trinity kernel: [<083d8831>] ? ptrace+0x31/0x80
Dec  7 18:01:44 trinity kernel: [<0807a072>] ? get_fp_registers+0x22/0x=
40
Dec  7 18:01:44 trinity kernel: [<080750f5>] userspace+0x475/0x5f0
Dec  7 18:01:44 trinity kernel: [<083d8831>] ? ptrace+0x31/0x80
Dec  7 18:01:44 trinity kernel: [<0807a5d6>] ? os_set_thread_area+0x26/=
0x40
Dec  7 18:01:44 trinity kernel: [<080795a0>] ? do_set_thread_area+0x20/=
0x50
Dec  7 18:01:44 trinity kernel: [<08079718>] ? arch_switch_tls+0xb8/0x1=
00
Dec  7 18:01:44 trinity kernel: [<0805f750>] fork_handler+0x60/0x70
Dec  7 18:01:44 trinity kernel:
Dec  7 18:01:44 trinity kernel: ---[ end trace 7ce562aa9f07d154 ]---








Just FWIW in addition I do have these diffs :

diff --git a/mm/truncate.c b/mm/truncate.c
index 353b683..41eecba 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -244,6 +244,11 @@ void truncate_inode_pages_range(struct address_spa=
ce *mapping,
                for (i =3D 0; i < pagevec_count(&pvec); i++) {
                        struct page *page =3D pvec.pages[i];

+                       if (index > 1000)       {
+                               printk (" page->index:%ld  ->flags:%lu =
 ->s_id:%s  ->i_no:%lu \n",
+                                       page->index , page->flags, page=
->mapping->host->i_sb->s_id, page->mapping->host->i_ino);
+                       }
+
                        /* We rely upon deletion not changing page->ind=
ex */
                        index =3D page->index;
                        if (index >=3D end)
@@ -259,6 +264,9 @@ void truncate_inode_pages_range(struct address_spac=
e *mapping,
                        truncate_inode_page(mapping, page);
                        unlock_page(page);
                }
+               if (index > 1000)       {
+                       printk (" index:%lu  i:%i  start:%lu \n", index=
, i, start);
+               }
                pagevec_release(&pvec);
                mem_cgroup_uncharge_end();
                cond_resched();


producing these results :

Dec  7 18:00:59 trinity kernel: ubda: unknown partition table
Dec  7 18:00:59 trinity kernel: ubdb: unknown partition table
Dec  7 18:00:59 trinity kernel: Netdevice 0 (72:ef:3d:9f:c3:5a) :
Dec  7 18:00:59 trinity kernel: TUN/TAP backend -
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): INFO: recovery required=
 on readonly filesystem
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): write access will be en=
abled during recovery
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): orphan cleanup on reado=
nly fs
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): 1 orphan inode deleted
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): recovery complete
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): mounted filesystem with=
 ordered data mode. Opts: (null)
Dec  7 18:00:59 trinity kernel: VFS: Mounted root (ext4 filesystem) rea=
donly on device 98:0.
Dec  7 18:00:59 trinity kernel: devtmpfs: mounted
Dec  7 18:00:59 trinity kernel[537]: starting version 204
Dec  7 18:00:59 trinity kernel: random: nonblocking pool is initialized
Dec  7 18:00:59 trinity kernel: page->index:65503  ->flags:2092  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65504  ->flags:2152  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65520  ->flags:2092  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65528  ->flags:2092  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65534  ->flags:2152  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65535  ->flags:2156  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: index:65535  i:13  start:0
Dec  7 18:00:59 trinity kernel: EXT4-fs (ubda): re-mounted. Opts: (null=
)
Dec  7 18:00:59 trinity kernel: [sched_delayed] sched: RT throttling ac=
tivated
Dec  7 18:00:59 trinity kernel: bio: create slab <bio-1> at 1
Dec  7 18:00:59 trinity kernel: page->index:65503  ->flags:2152  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65504  ->flags:2156  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65520  ->flags:2152  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65528  ->flags:2152  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65534  ->flags:2156  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: page->index:65535  ->flags:2156  ->s_id=
:bdev  ->i_no:0
Dec  7 18:00:59 trinity kernel: index:65535  i:13  start:0
Dec  7 18:00:59 trinity kernel: Adding 262140k swap on /dev/mapper/cryp=
t-swap.  Priority:-1 extents:1 across:262140k FS
Dec  7 18:00:59 trinity kernel: type=3D1006 audit(1386435658.554:2): pi=
d=3D1069 uid=3D0 old auid=3D4294967295 new auid=3D0 old ses=3D429496729=
5 new ses=3D1 res=3D1
Dec  7 18:00:59 trinity kernel: Virtual console 12 assigned device '/de=
v/pts/5'
Dec  7 18:01:00 trinity dhcpcd[1094]: version 5.6.4 starting
Dec  7 18:01:00 trinity dhcpcd[1094]: sit0: unsupported interface type =
308, falling back to ethernet


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print:1A37 6F99 4A9D 026F 13E2 4DCF C4EA CDDE 0076 E94E
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

