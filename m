Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 13 Dec 2013 20:10:05 +0100
From: Jan Kara <jack@suse.cz>
Message-ID: <20131213191005.GA23630@quack.suse.cz>
References: <529217CD.1000204@gmx.de>
 <20131203140214.GB31128@quack.suse.cz>
 <529E3450.9000700@gmx.de>
 <20131203230058.GA24037@quack.suse.cz>
 <20131204130639.GA31973@quack.suse.cz>
 <52A36389.7010103@gmx.de>
 <20131211202639.GE1163@quack.suse.cz>
 <52AAD8D4.2060807@gmx.de>
 <CAFLxGvy16wv0m4D+ydmqbksUu9CaEaDtGdtnk1YHa56jAU+SEA@mail.gmail.com>
 <52AB052E.9000404@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52AB052E.9000404@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] why does index in truncate_inode_pages_range() grows
 so much ?
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Jan Kara <jack@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Linux Kernel <linux-kernel@vger.kernel.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri 13-12-13 14:01:34, Toralf F=F6rster wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On 12/13/2013 11:51 AM, Richard Weinberger wrote:
> > On Fri, Dec 13, 2013 at 10:52 AM, Toralf F=F6rster <toralf.foerster=
@gmx.de> wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA256
> >>
> >> On 12/11/2013 09:26 PM, Jan Kara wrote:
> >>> Thanks! So this works more or less as expected - trinity issued a
> >>> read at absurdly high offset so we created pagecache page a that
> >>> offset and tried to read data into it. That failed. We left the
> >>> page in the pagecache where it was for reclaim to reclaim it when
> >>> free pages are needed. Everything works as designed except we cou=
ld
> >>> possibly argue that it's not the most efficient way to use
> >>> pages...
> >>>
> >>> Patch 'vfs: fix a bug when we do some dio reads with append dio
> >>> writes' (http://www.spinics.net/lists/linux-fsdevel/msg70899.html=
)
> >>> should actually change the situation and we won't unnecessarily
> >>> cache these pages.
> >>>
> >> confirmed - applied to latest git tree of Linus I helps.
> >=20
> > Good to know! :-)
> >=20
>=20
> OTOH - there's seems to be more places for an improvement - now trini=
ty
> often runs hours w/o problem (before it runs within a rather short ti=
me
> into such issues).
>=20
> But today I got another case (I did not patched the source files exce=
pt
> the mentioned patch by Jan Kara) where the trinity call cycles since =
2
> hours w/o any progress. But fortunately the system is still responsiv=
e,
> ssh works and I can shutdown that virtual machine smoothly, furthermo=
re
> all local and remote file systems can be unounted cleanly - so that p=
atch
> is a big improvement).
  OK, that is indeed strange. Can you step through find_get_pages() in =
gdb
to see where exactly are we looping? From the traces below the argument
values look somewhat unreliable so it's not clear to me what is exactly
happening.

								Honza

> tfoerste@n22 ~/devel/github/bingo $ date; sudo gdb /home/tfoerste/dev=
el/linux/linux 9776 -n -batch -ex 'bt'
> Fri Dec 13 13:54:33 CET 2013
> find_get_pages (mapping=3D0x45182810, start=3D0, nr_pages=3D14, pages=
=3D0x0) at mm/filemap.c:885
> 885     }
> #0  find_get_pages (mapping=3D0x45182810, start=3D0, nr_pages=3D14, p=
ages=3D0x0) at mm/filemap.c:885
> #1  0x080d669a in pagevec_lookup (pvec=3D0x40607d40, mapping=3D0x0, s=
tart=3D0, nr_pages=3D0) at mm/swap.c:937
> #2  0x080d6a9a in truncate_inode_pages_range (mapping=3D0x45182810, l=
start=3D0, lend=3D-1) at mm/truncate.c:241
> #3  0x080d6e3f in truncate_inode_pages (mapping=3D0x0, lstart=3D0) at=
 mm/truncate.c:358
> #4  0x0818c2d2 in ext4_evict_inode (inode=3D0x45182758) at fs/ext4/in=
ode.c:228
> #5  0x0811b5ff in evict (inode=3D0x45182758) at fs/inode.c:549
> #6  0x0811c0ed in iput_final (inode=3D<optimized out>) at fs/inode.c:=
1419
> #7  iput (inode=3D0x45182758) at fs/inode.c:1437
> #8  0x08112056 in do_unlinkat (dfd=3D5, pathname=3D0x8065d84 <registe=
r_lines+276> "") at fs/namei.c:3718
> #9  0x081121c5 in SYSC_unlinkat (flag=3D<optimized out>, pathname=3D<=
optimized out>, dfd=3D<optimized out>) at fs/namei.c:3754
> #10 SyS_unlinkat (dfd=3D5, pathname=3D134634884, flag=3D0) at fs/name=
i.c:3746
> #11 0x08062a94 in handle_syscall (r=3D0x473b59cc) at arch/um/kernel/s=
kas/syscall.c:35
> #12 0x080750f5 in handle_trap (local_using_sysemu=3D<optimized out>, =
regs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas=
/process.c:198
> #13 userspace (regs=3D0x473b59cc) at arch/um/os-Linux/skas/process.c:=
431
> #14 0x0805f750 in fork_handler () at arch/um/kernel/process.c:149
> #15 0x5a5a5a5a in ?? ()
>=20
>=20
> tfoerste@n22 ~/devel/github/bingo $ date; sudo gdb /home/tfoerste/dev=
el/linux/linux 9776 -n -batch -ex 'bt'
> Fri Dec 13 13:54:47 CET 2013
> radix_tree_next_chunk (root=3D0x3f, iter=3D0x40607cdc, flags=3D6) at =
lib/radix-tree.c:773
> 773                             index &=3D ~((RADIX_TREE_MAP_SIZE << =
shift) - 1);
> #0  radix_tree_next_chunk (root=3D0x3f, iter=3D0x40607cdc, flags=3D6)=
 at lib/radix-tree.c:773
> #1  0x080cc88e in find_get_pages (mapping=3D0x45182810, start=3D0, nr=
_pages=3D14, pages=3D0x6) at mm/filemap.c:844
> #2  0x080d669a in pagevec_lookup (pvec=3D0x40607d40, mapping=3D0x3f, =
start=3D63, nr_pages=3D63) at mm/swap.c:937
> #3  0x080d6a9a in truncate_inode_pages_range (mapping=3D0x45182810, l=
start=3D0, lend=3D-1) at mm/truncate.c:241
> #4  0x080d6e3f in truncate_inode_pages (mapping=3D0x3f, lstart=3D2576=
9803839) at mm/truncate.c:358
> #5  0x0818c2d2 in ext4_evict_inode (inode=3D0x45182758) at fs/ext4/in=
ode.c:228
> #6  0x0811b5ff in evict (inode=3D0x45182758) at fs/inode.c:549
> #7  0x0811c0ed in iput_final (inode=3D<optimized out>) at fs/inode.c:=
1419
> #8  iput (inode=3D0x45182758) at fs/inode.c:1437
> #9  0x08112056 in do_unlinkat (dfd=3D5, pathname=3D0x8065d84 <registe=
r_lines+276> "") at fs/namei.c:3718
> #10 0x081121c5 in SYSC_unlinkat (flag=3D<optimized out>, pathname=3D<=
optimized out>, dfd=3D<optimized out>) at fs/namei.c:3754
> #11 SyS_unlinkat (dfd=3D5, pathname=3D134634884, flag=3D0) at fs/name=
i.c:3746
> #12 0x08062a94 in handle_syscall (r=3D0x473b59cc) at arch/um/kernel/s=
kas/syscall.c:35
> #13 0x080750f5 in handle_trap (local_using_sysemu=3D<optimized out>, =
regs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas=
/process.c:198
> #14 userspace (regs=3D0x473b59cc) at arch/um/os-Linux/skas/process.c:=
431
> #15 0x0805f750 in fork_handler () at arch/um/kernel/process.c:149
> #16 0x5a5a5a5a in ?? ()
>=20
>=20
> tfoerste@n22 ~/devel/github/bingo $ date; sudo gdb /home/tfoerste/dev=
el/linux/linux 9776 -n -batch -ex 'bt'
> Fri Dec 13 13:57:16 CET 2013
> radix_tree_next_chunk (root=3D0x10, iter=3D0x40607cdc, flags=3D6) at =
lib/radix-tree.c:769
> 769                                     while (++offset < RADIX_TREE_=
MAP_SIZE) {
> #0  radix_tree_next_chunk (root=3D0x10, iter=3D0x40607cdc, flags=3D6)=
 at lib/radix-tree.c:769
> #1  0x080cc88e in find_get_pages (mapping=3D0x45182810, start=3D0, nr=
_pages=3D14, pages=3D0x6) at mm/filemap.c:844
> #2  0x080d669a in pagevec_lookup (pvec=3D0x40607d40, mapping=3D0x10, =
start=3D16, nr_pages=3D16) at mm/swap.c:937
> #3  0x080d6a9a in truncate_inode_pages_range (mapping=3D0x45182810, l=
start=3D0, lend=3D-1) at mm/truncate.c:241
> #4  0x080d6e3f in truncate_inode_pages (mapping=3D0x10, lstart=3D2576=
9803792) at mm/truncate.c:358
> #5  0x0818c2d2 in ext4_evict_inode (inode=3D0x45182758) at fs/ext4/in=
ode.c:228
> #6  0x0811b5ff in evict (inode=3D0x45182758) at fs/inode.c:549
> #7  0x0811c0ed in iput_final (inode=3D<optimized out>) at fs/inode.c:=
1419
> #8  iput (inode=3D0x45182758) at fs/inode.c:1437
> #9  0x08112056 in do_unlinkat (dfd=3D5, pathname=3D0x8065d84 <registe=
r_lines+276> "") at fs/namei.c:3718
> #10 0x081121c5 in SYSC_unlinkat (flag=3D<optimized out>, pathname=3D<=
optimized out>, dfd=3D<optimized out>) at fs/namei.c:3754
> #11 SyS_unlinkat (dfd=3D5, pathname=3D134634884, flag=3D0) at fs/name=
i.c:3746
> #12 0x08062a94 in handle_syscall (r=3D0x473b59cc) at arch/um/kernel/s=
kas/syscall.c:35
> #13 0x080750f5 in handle_trap (local_using_sysemu=3D<optimized out>, =
regs=3D<optimized out>, pid=3D<optimized out>) at arch/um/os-Linux/skas=
/process.c:198
> #14 userspace (regs=3D0x473b59cc) at arch/um/os-Linux/skas/process.c:=
431
> #15 0x0805f750 in fork_handler () at arch/um/kernel/process.c:149
> #16 0x5a5a5a5a in ?? ()
>=20
> - --=20
> MfG/Sincerely
> Toralf F=F6rster
> pgp finger print:1A37 6F99 4A9D 026F 13E2 4DCF C4EA CDDE 0076 E94E
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.22 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>=20
> iF4EAREIAAYFAlKrBS0ACgkQxOrN3gB26U4bRgD/U/5sIELFBZUTeEgfM9eJBnxh
> PhdMMBTTJHoB3v9z70YA/iEZzD9L30vVSWqYrybOWNPYwDR1i67F41nUemmPczqu
> =3Du/iT
> -----END PGP SIGNATURE-----
--=20
Jan Kara <jack@suse.cz>
SUSE Labs, CR
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

