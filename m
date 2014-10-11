Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54391F7C.1050001@m4x.org>
Date: Sat, 11 Oct 2014 14:15:56 +0200
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
MIME-Version: 1.0
References: <1413026981-9667-1-git-send-email-nicolas.iooss_linux@m4x.org> <54391792.40508@nod.at>
In-Reply-To: <54391792.40508@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: always use the same type for __syscall_stub_start
To: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2014-10-11 13:42 GMT+02:00 Richard Weinberger:
> Am 11.10.2014 um 13:29 schrieb Nicolas Iooss:
>> syscall_stub_start is declared with different types in C files:
>>
>>   arch/um/kernel/physmem.c: extern int __syscall_stub_start;
>>   arch/um/kernel/skas/mmu.c: extern int __syscall_stub_start;
>>   arch/um/os-Linux/skas/mem.c: extern unsigned long __syscall_stub_start;
>>   arch/um/os-Linux/skas/process.c: extern int __syscall_stub_start;
>>
>> Fix this inconsistency by always using unsigned long.  This does not
>> change anything in the compiled code because only the address of
>> __syscall_stub_start is used, but it makes the static checker I use
>> stop complaining about incompatible declarations.
>
> While we're here, can you put these declarations into a single header
file?

Sure.  Do you have a specific header file in mind or shall I create
arch/um/include/asm/sections.h with declarations for
__syscall_stub_start, __syscall_stub_end and __binary_start (used in
arch/um/kernel/um_arch.c)?

Thanks for your quick reply,

Nicolas


