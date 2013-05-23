Return-Path: <gang.chen@asianux.com>
Message-ID: <519DE9D6.8000707@asianux.com>
Date: Thu, 23 May 2013 18:05:10 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <519DCBEF.3090208@asianux.com> <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com> <20130523090534.GJ18614@n2100.arm.linux.org.uk> <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
In-Reply-To: <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------060108040408020204060404"
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, =?UTF-8?B?SMOldmFy?= =?UTF-8?B?ZCBTa2lubmVtb2Vu?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060108040408020204060404
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/23/2013 05:12 PM, Geert Uytterhoeven wrote:
> On Thu, May 23, 2013 at 11:05 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> > On Thu, May 23, 2013 at 10:40:29AM +0200, Geert Uytterhoeven wrote:
>>> >> On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
>>>> >> > -config BUG
>>>> >> > -       bool "BUG() support" if EXPERT
>>>> >> > -       default y
>>>> >> > -       help
>>>> >> > -          Disabling this option eliminates support for BUG and WARN, reducing
>>>> >> > -          the size of your kernel image and potentially quietly ignoring
>>>> >> > -          numerous fatal conditions. You should only consider disabling this
>>>> >> > -          option for embedded systems with no facilities for reporting errors.
>>>> >> > -          Just say Y.
>>> >>
>>> >> ... It's about reducing memory size on devices where you can't show bug or
>>> >> warning messages.
>> >
>> > And turning off CONFIG_BUG causes lots of warning messages at compile time
>> > about functions which are returning nothing which shouldn't.
>> >
>> > The problem is: trying to fix that _will_ mean the result is a larger
>> > kernel than if you just do the usual arch-implemented thing of placing
>> > an defined faulting instruction at the BUG() site - which defeats the
>> > purpose of turning off CONFIG_BUG.
> Is __builtin_unreachable() working well these days?

In fact, using __builtin_unreachable() is a standard way for
architectures to implemented their own BUG() (e.g. x86, s390, powerpc,
arm ...)

Before __builtin_unreachable(), must need an inline asm instruction
which architecture specific.

I have test using __builtin_unreachable() without an related asm
instruction before, it prints many unexpected things (please see the
attachment).

So I think, it is not suitable to use it in "asm-generic/bug.h"


Thanks.
-- 
Chen Gang

Asianux Corporation

--------------060108040408020204060404
Content-Type: text/plain; charset=UTF-8;
 name="test0.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test0.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPGVy
cm9yLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUg
PHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KCmludCBtYWluKCkKewoJaW50IGZp
bGU7CglpbnQgcmV0OwoJY2hhciBidWZbMHgxMDBdOwoKCWZpbGUgPSBvcGVuKCIvdG1wL3dv
cmsuYyIsIE9fUkRPTkxZKTsKCWlmIChmaWxlID09IC0xKSB7CgkJcHJpbnRmKCJcbm9wZW4g
ZmlsZSBmYWlsZWQuIGVycm5vID0gJWRcbiIsIGVycm5vKTsKCQlnb3RvIGVycjsKCX0gZWxz
ZQoJCXByaW50ZigiXG5vcGVuIGZpbGUgc3VjY2VlZC5cbiIpOwoKCXByaW50ZigiYmVmb3Jl
IHVucmVhY2hhYmxlXG4iKTsKCV9fYnVpbHRpbl91bnJlYWNoYWJsZSgpOwoJcHJpbnRmKCJh
ZnRlciB1bnJlYWNoYWJsZVxuIik7CgoJaWYgKGxzZWVrKGZpbGUsIDEwLCBTRUVLX0VORCkg
PCAwKSB7CgkJcHJpbnRmKCJcbmxzZWVrIGZpbGUgZmFpbGVkLiBlcnJubyA9ICVkXG4iLCBl
cnJubyk7CgkJZ290byBlcnI7Cgl9CgoJcmV0ID0gcmVhZChmaWxlLCBidWYsIDB4MTAwKTsK
CWlmIChyZXQgPCAwKSB7CgkJcHJpbnRmKCJcbjFzdCByZWFkIGZpbGUgZmFpbGVkLiBlcnJu
byA9ICVkLCByZXQgPSAlZFxuIiwgZXJybm8sIHJldCk7CgkJZ290byBlcnI7Cgl9IGVsc2UK
CQlwcmludGYoIlxuMXN0IHJlYWQgZmlsZSBzdWNjZWVkLiBlcnJubyA9ICVkLCByZXQgPSAl
ZFxuIiwgZXJybm8sIHJldCk7CgoJcmV0ID0gcmVhZChmaWxlLCBidWYsIDB4MTAwKTsKCWlm
IChyZXQgPCAwKSB7CgkJcHJpbnRmKCJcbjJuZCByZWFkIGZpbGUgZmFpbGVkLiBlcnJubyA9
ICVkLCByZXQgPSAlZFxuIiwgZXJybm8sIHJldCk7CgkJZ290byBlcnI7Cgl9IGVsc2UKCQlw
cmludGYoIlxuMm5kIHJlYWQgZmlsZSBzdWNjZWVkLiBlcnJubyA9ICVkLCByZXQgPSAlZFxu
IiwgZXJybm8sIHJldCk7CgoJcmV0ID0gcmVhZChmaWxlLCBidWYsIDB4MTAwKTsKCWlmIChy
ZXQgPCAwKSB7CgkJcHJpbnRmKCJcbjJyZCByZWFkIGZpbGUgZmFpbGVkLiBlcnJubyA9ICVk
LCByZXQgPSAlZFxuIiwgZXJybm8sIHJldCk7CgkJZ290byBlcnI7Cgl9IGVsc2UKCQlwcmlu
dGYoIlxuM3JkIHJlYWQgZmlsZSBzdWNjZWVkLiBlcnJubyA9ICVkLCByZXQgPSAlZFxuIiwg
ZXJybm8sIHJldCk7CgoKCXJldHVybiAwOwplcnI6CglyZXR1cm4gLTE7Cn0KCg==
--------------060108040408020204060404--

