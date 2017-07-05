Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170525183627.9375-1-f.fainelli@gmail.com>
References: <20170525183627.9375-1-f.fainelli@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 5 Jul 2017 23:32:37 +0200
Message-ID: <CAFLxGvxxkMXQojHFLfCq3F5PiYqQHMHu3fQV3sMNbvYu-Qb1SQ@mail.gmail.com>
Subject: Re: [PATCH v2] um: Allow building and running on older hosts
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, elicooper@gmx.com, Thomas Meyer <thomas@m3y3r.de>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Florian,

On Thu, May 25, 2017 at 8:36 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Commit a78ff1112263 ("um: add extended processor state save/restore
> support") and b6024b21fec8 ("um: extend fpstate to _xstate to support
> YMM registers") forced the use of the x86 FP _xstate and
> PTRACE_GETREGSET/SETREGSET. On older hosts, we would neither be able to
> build UML nor run it anymore with these two commits applied because we
> don't have definitions for struct _xstate nor these two ptrace requests.
>
> We can determine at build time which fp context structure to check
> against, just like we can keep using the old i387 fp save/restore if
> PTRACE_GETRESET/SETREGSET are not defined.
>
> Fixes: a78ff1112263 ("um: add extended processor state save/restore support")
> Fixes: b6024b21fec8 ("um: extend fpstate to _xstate to support YMM registers")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Both patches applied. Thanks a lot for fixing these regressions!

-- 
Thanks,
//richard

