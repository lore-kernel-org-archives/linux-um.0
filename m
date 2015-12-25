Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450875553-17717-1-git-send-email-mic@digikod.net>
 <20151223214212.GA1300@x> <567BE089.8030903@digikod.net>
 <20151225012613.GA12977@x>
From: Richard Weinberger <richard@nod.at>
Message-ID: <567D5C48.7020900@nod.at>
Date: Fri, 25 Dec 2015 16:10:00 +0100
MIME-Version: 1.0
In-Reply-To: <20151225012613.GA12977@x>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] um: Fix build error and kconfig for i386
To: Josh Triplett <josh@joshtriplett.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 25.12.2015 um 02:26 schrieb Josh Triplett:
> On Thu, Dec 24, 2015 at 01:09:45PM +0100, Micka=EBl Sala=FCn wrote:
>>
>> On 23/12/2015 22:42, Josh Triplett wrote:
>>> On Wed, Dec 23, 2015 at 01:59:13PM +0100, Micka=EBl Sala=FCn wrote:
>>>> Fix build error by selecting COREDUMP when X86_32 is selected:
>>>>
>>>> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
>>>> (.text+0x3e62): undefined reference to `dump_emit'
>>>> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
>>>> (.text+0x3eef): undefined reference to `dump_emit'
>>>>
>>>> Fixes: 5d2acfc7b974 ("kconfig: make allnoconfig disable options be=
hind EMBEDDED and EXPERT")
>>>> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
>>>> Cc: Jeff Dike <jdike@addtoit.com>
>>>> Cc: Richard Weinberger <richard@nod.at>
>>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>>> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>>>> Cc: Michal Marek <mmarek@suse.cz>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>
>>> I suppose um doesn't care deeply about binary size, but ideally I w=
ould
>>> suggest changing arch/x86/um/Makefile to make elfcore.c compiled in=
 when
>>> CONFIG_ELF_CORE rather than CONFIG_BINFMT_ELF.
>>
>> That looks better! Since the first patch has been added to the mmots=
 tree (but not yet in mmotm) I'll send a patch update instead of a new =
one reverting the first. I hope this is OK.
>=20
> -mm regularly replaces patches with newer versions, so that ought to =
be
> fine.

Usually non-trivial UML stuff goes thought me.
As Josh noted, just post an updated version of the patch.
Either me or Andrew will pick it up.

Thanks,
//richard

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

