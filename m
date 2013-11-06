Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <527AB51B.1020005@nod.at>
Date: Wed, 06 Nov 2013 22:31:07 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <526696BF.6050909@gmx.de>	<CAFLxGvy3NeRKu+KQCCm0j4LS60PYhH0bC8WWjfiPvpstPBjAkA@mail.gmail.com>	<5266A698.10400@gmx.de>	<5266B60A.1000005@nod.at>	<52715AD1.7000703@gmx.de> <CALYGNiPvJF1u8gXNcX1AZR5-VkGqJnaose84KBbdaoBAq8aoGQ@mail.gmail.com> <527AB23D.2060305@gmx.de>
In-Reply-To: <527AB23D.2060305@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] fuzz tested 32 bit user mode linux image hangs in
 radix_tree_next_chunk()
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 06.11.2013 22:18, schrieb Toralf F=C3=B6rster:
> On 11/06/2013 05:06 PM, Konstantin Khlebnikov wrote:
>> In this case it must stop after scanning whole tree in line:
>> /* Overflow after ~0UL */
>> if (!index)
>>   return NULL;
>>
>=20
> A fresh current example with latest git tree shows that lines 769 and=
 770 do alternate :

Can you please ask gdb for the value of offset?

Thanks,
//richard

>=20
> tfoerste@n22 ~/devel/linux $ sudo gdb /usr/local/bin/linux-v3.12-48-g=
be408cd 16619 -n -batch -ex bt
> 0x08296a8c in radix_tree_next_chunk (root=3D0x25, iter=3D0x462e7c64, =
flags=3D12) at lib/radix-tree.c:770
> 770                                             if (node->slots[offse=
t])
> #0  0x08296a8c in radix_tree_next_chunk (root=3D0x25, iter=3D0x462e7c=
64, flags=3D12) at lib/radix-tree.c:770
> #1  0x080cc1fe in find_get_pages (mapping=3D0x462ad470, start=3D0, nr=
_pages=3D14, pages=3D0xc) at mm/filemap.c:844
> #2  0x080d5d6a in pagevec_lookup (pvec=3D0x462e7cc8, mapping=3D0x25, =
start=3D37, nr_pages=3D37) at mm/swap.c:914
> #3  0x080d615a in truncate_inode_pages_range (mapping=3D0x462ad470, l=
start=3D0, lend=3D-1) at mm/truncate.c:241
> #4  0x080d64ff in truncate_inode_pages (mapping=3D0x25, lstart=3D5153=
9607589) at mm/truncate.c:358
>=20
>=20
>=20
>=20
> tfoerste@n22 ~/devel/linux $ sudo gdb /usr/local/bin/linux-v3.12-48-g=
be408cd 16619 -n -batch -ex bt
> radix_tree_next_chunk (root=3D0x28, iter=3D0x462e7c64, flags=3D18) at=
 lib/radix-tree.c:769
> 769                                     while (++offset < RADIX_TREE_=
MAP_SIZE) {
> #0  radix_tree_next_chunk (root=3D0x28, iter=3D0x462e7c64, flags=3D18=
) at lib/radix-tree.c:769
> #1  0x080cc1fe in find_get_pages (mapping=3D0x462ad470, start=3D0, nr=
_pages=3D14, pages=3D0x12) at mm/filemap.c:844
> #2  0x080d5d6a in pagevec_lookup (pvec=3D0x462e7cc8, mapping=3D0x28, =
start=3D40, nr_pages=3D40) at mm/swap.c:914
> #3  0x080d615a in truncate_inode_pages_range (mapping=3D0x462ad470, l=
start=3D0, lend=3D-1) at mm/truncate.c:241
> #4  0x080d64ff in truncate_inode_pages (mapping=3D0x28, lstart=3D7730=
9411368) at mm/truncate.c:358
> #5  0x0825e388 in hostfs_evict_inode (inode=3D0x462ad3b8) at fs/hostf=
s/hostfs_kern.c:242
> #6  0x0811a8df in evict (inode=3D0x462ad3b8) at fs/inode.c:549
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

