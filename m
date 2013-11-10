Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <527FAA34.8080307@nod.at>
Date: Sun, 10 Nov 2013 16:45:56 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <526696BF.6050909@gmx.de>	<CAFLxGvy3NeRKu+KQCCm0j4LS60PYhH0bC8WWjfiPvpstPBjAkA@mail.gmail.com>	<5266A698.10400@gmx.de>	<5266B60A.1000005@nod.at>	<52715AD1.7000703@gmx.de> <CALYGNiPvJF1u8gXNcX1AZR5-VkGqJnaose84KBbdaoBAq8aoGQ@mail.gmail.com> <527AB23D.2060305@gmx.de> <527AB51B.1020005@nod.at> <527FA2BE.6090307@gmx.de>
In-Reply-To: <527FA2BE.6090307@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] fuzz tested 32 bit user mode linux image hangs in
 radix_tree_next_chunk()
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 10.11.2013 16:14, schrieb Toralf F=C3=B6rster:
> On 11/06/2013 10:31 PM, Richard Weinberger wrote:
>> Am 06.11.2013 22:18, schrieb Toralf F=C3=B6rster:
>>> On 11/06/2013 05:06 PM, Konstantin Khlebnikov wrote:
>>>> In this case it must stop after scanning whole tree in line:
>>>> /* Overflow after ~0UL */
>>>> if (!index)
>>>>   return NULL;
>>>>
>>>
>>> A fresh current example with latest git tree shows that lines 769 a=
nd 770 do alternate :
>>
>> Can you please ask gdb for the value of offset?
>>
>> Thanks,
>> //richard
>>
>=20
> With this change=20
>=20
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index 7811ed3..b2e9db5 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -767,6 +767,7 @@ restart:
>                                                 offset + 1);
>                         else
>                                 while (++offset < RADIX_TREE_MAP_SIZE=
) {
> +                                       printk ("node->slots[offset] =
%p offeset %lu\n", node->slots[offset], offset);
>                                         if (node->slots[offset])
>                                                 break;
>                                 }

Make sure that you print only in case of a enless loop. i.e. add a loop=
 counter
and start printing only if the loop was taken *very* often.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

