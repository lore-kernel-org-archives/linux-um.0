Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <527E87EA.8080700@gmx.de>
Date: Sat, 09 Nov 2013 20:07:22 +0100
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

Still trying to get those values. One attempt to do that was to replace=
 -O2 with -O0 in the Makefile,
but that resulted into this error :

  LD      kernel/built-in.o
  CC      mm/memory.o
In function =E2=80=98zap_pmd_range=E2=80=99,
    inlined from =E2=80=98zap_pud_range=E2=80=99 at mm/memory.c:1265:8,
    inlined from =E2=80=98unmap_page_range=E2=80=99 at mm/memory.c:1290=
:8:
mm/memory.c:1220:23: error: call to =E2=80=98__compiletime_assert_1220=E2=
=80=99 declared with attribute error: BUILD_BUG failed
mm/memory.c: In function =E2=80=98follow_page_mask=E2=80=99:
mm/memory.c:1530:18: error: call to =E2=80=98__compiletime_assert_1530=E2=
=80=99 declared with attribute error: BUILD_BUG failed
make[1]: *** [mm/memory.o] Error 1
make: *** [mm] Error 2


With -O1 it compiled at least.


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

