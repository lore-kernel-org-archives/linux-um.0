Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1fGb-0005tL-G3
 for linux-um@lists.infradead.org; Tue, 11 Feb 2020 23:48:34 +0000
Received: by mail-wr1-x444.google.com with SMTP id t2so14760704wrr.1
 for <linux-um@lists.infradead.org>; Tue, 11 Feb 2020 15:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com>
In-Reply-To: <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Tue, 11 Feb 2020 15:48:18 -0800
Message-ID: <CAKFsvUKhwAOV9O+LWBr=-zLEJCFJvKOH-ePsXMMVJzHotqd3Ug@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Thu, Jan 16, 2020 at 12:44 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > +config KASAN_SHADOW_OFFSET
> > +       hex
> > +       depends on KASAN
> > +       default 0x100000000000
> > +       help
> > +         This is the offset at which the ~2.25TB of shadow memory is
> > +         initialized and used by KASAN for memory debugging. The default
> > +         is 0x100000000000.
>
> What are restrictions on this value?
The only restriction is that there is enough space there to map all of
the KASAN shadow memory without conflicting with anything else.

> In user-space we use 0x7fff8000 as a base (just below 2GB) and it's
> extremely profitable wrt codegen since it fits into immediate of most
> instructions.
> We can load and add the base with a short instruction:
>     2d8c: 48 81 c2 00 80 ff 7f    add    $0x7fff8000,%rdx
> Or even add base, load shadow and check it with a single 7-byte instruction:
>      1e4: 80 b8 00 80 ff 7f 00    cmpb   $0x0,0x7fff8000(%rax)
>
I just tested with 0x7fff8000 as the KASAN_SHADOW_OFFSET and it worked
so I can make that the default if it will be more efficient.

-- 
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

