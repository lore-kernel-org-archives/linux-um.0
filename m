Return-Path: <gang.chen@asianux.com>
Message-ID: <51D2888E.8020503@asianux.com>
Date: Tue, 02 Jul 2013 16:00:14 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <51CA8AB8.7080504@asianux.com> <51CA900E.9020407@nod.at> <51CA9E92.4000107@asianux.com> <51CAA0C6.60007@nod.at> <51CAA78C.5040900@asianux.com> <51CAA8D6.9000505@nod.at> <51CAAD1D.8050801@asianux.com> <51CAAE7C.9090003@nod.at> <51CAB556.4070700@asianux.com> <51CAB689.70008@nod.at> <CAMuHMdXw6VYhnNWcVfWc9ssxKTqKFcDbN4WXL5i=eNGy+gXcRA@mail.gmail.com> <51CABBDD.403@asianux.com> <51CABFAC.1040505@nod.at> <51CAC0D0.60505@asianux.com> <51D0DE09.4090702@asianux.com> <51D0FAFE.5010500@asianux.com> <51D23766.8000605@asianux.com> <CAMuHMdUvctqqStGE0QKM_BqgK2f6f_E6T=przdYszZo9A_oDzg@mail.gmail.com>
In-Reply-To: <CAMuHMdUvctqqStGE0QKM_BqgK2f6f_E6T=przdYszZo9A_oDzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support
 'COMPILE_TEST' in 'asm-generic'.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 07/02/2013 03:19 PM, Geert Uytterhoeven wrote:
> On Tue, Jul 2, 2013 at 4:13 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> > 'asm-generic' need provide necessary configuration checking, if can't
>> > pass checking, 'asm-generic' shouldn't implement it.
>> >
>> > For 'COMPILE_TEST', according to its help contents, 'asm-generic' need
>> > let it pass configuration checking, and provide related dummy contents
>> > for it.
>> >
>> > Part of 'COMPLE_TEST' help contents in "init/Kconfig":
>> >
>> >   "...Despite they cannot be loaded there (or even when they load they cannot be used due to missing HW support)..."
>> >
>> >
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> NAKed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Please don't clutter the code with checks for CONFIG_COMPILE_TEST.

Do you mean: 'asm-generic' should not support 'COMPILE_TEST' (the
platform should not support 'COMPILE_TEST") ?

Or you mean: 'COMPILE_TEST' should not exist in kernel ?

Can we use 'asm-default' instead of 'asm-generic', since "if HW support,
it will provide default value, or it will provide nothing" ?


Thanks.
-- 
Chen Gang

