Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54392FE8.8060904@m4x.org>
Date: Sat, 11 Oct 2014 15:26:00 +0200
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
MIME-Version: 1.0
References: <1413026981-9667-1-git-send-email-nicolas.iooss_linux@m4x.org> <54391792.40508@nod.at> <54391F7C.1050001@m4x.org> <54392181.8050707@nod.at>
In-Reply-To: <54392181.8050707@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: always use the same type for __syscall_stub_start
To: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Le 11/10/2014 14:24, Richard Weinberger a =E9crit :
> Am 11.10.2014 um 14:15 schrieb Nicolas Iooss:
>> 2014-10-11 13:42 GMT+02:00 Richard Weinberger:
>>> Am 11.10.2014 um 13:29 schrieb Nicolas Iooss:
>>>> syscall_stub_start is declared with different types in C files:
>>>>
>>>>   arch/um/kernel/physmem.c: extern int __syscall_stub_start;
>>>>   arch/um/kernel/skas/mmu.c: extern int __syscall_stub_start;
>>>>   arch/um/os-Linux/skas/mem.c: extern unsigned long __syscall_stub=
_start;
>>>>   arch/um/os-Linux/skas/process.c: extern int __syscall_stub_start=
;
>>>>
>>>> Fix this inconsistency by always using unsigned long.  This does n=
ot
>>>> change anything in the compiled code because only the address of
>>>> __syscall_stub_start is used, but it makes the static checker I us=
e
>>>> stop complaining about incompatible declarations.
>>>
>>> While we're here, can you put these declarations into a single head=
er
>> file?
>>
>> Sure.  Do you have a specific header file in mind or shall I create
>> arch/um/include/asm/sections.h with declarations for
>> __syscall_stub_start, __syscall_stub_end and __binary_start (used in
>> arch/um/kernel/um_arch.c)?
>=20
> Not really. Maybe you can find a common header for all.
> But I fear where is a reason why these declarations are not in a
> common header. They are used in the kernel- and userspace part of
> UML.
> Anyway, please give it a try. :)

Ok.  I'll at least try to add a kernel header and send a new patch afte=
r
some tests.

By the way, most variables in include/asm-generic/sections.h are
declared "char[]" and used without operator, contrary to
__syscall_stub_start, declared "int" or "unsigned long" and only used
with "&" operator.  Is there any reason why there are in the kernel two
ways of declaring/accessing code addresses defined in linker files?  If
not, I can send a patch which makes __syscall_stub_start "char[]"
instead of "unsigned long" to make the code a little bit clearer.

Nicolas

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

