Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYad5-00Bdx9-Ae
 for linux-um@lists.infradead.org; Mon, 19 Apr 2021 20:36:26 +0000
Received: by mail-pg1-x52f.google.com with SMTP id y32so25073392pga.11
 for <linux-um@lists.infradead.org>; Mon, 19 Apr 2021 13:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
 <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
In-Reply-To: <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Mon, 19 Apr 2021 15:36:11 -0500
Message-ID: <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
Subject: Re: [PATCH v2] um: Fix stack pointer alignment
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
To: Johannes Berg <johannes@sipsolutions.net>, Colin Ian King <colin.king@canonical.com>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>

On Mon, Apr 19, 2021 at 2:41 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Mon, 2021-04-19 at 10:32 -0500, YiFei Zhu wrote:
> > On a side note, musl is unaffected by this issue because it forces
> > 16 byte alignment via `and $-16,%rsi` in its clone wrapper.
> > Similarly, glibc i386 is also uneffected because it has

I realize I forgot to fix the typo here. Can you amend it or shall I send a v3?

> > `andl $0xfffffff0, %ecx`.
>
> I wonder if this isn't really a glibc bug?
>
> After all, the man page states no alignment restrictions, except when
> documenting the error codes:
>
> EINVAL
> stack is not aligned to a suitable boundary for  this  architecture.
> For example, on aarch64, stack must be a multiple of 16.

This could be considered a glibc bug that it doesn't force alignment,
yeah, considering musl does it for both x86_32 and x86_64, and glibc
does it for only x86_32 and not x86_64. However, I'm unaware that
anywhere saying something like "it's libc's duty to align the stack
pointer to clone()"

Speaking of aarch64, it looks like that message might be out of date.
I was trying to find where this is being enforced, and could not
quickly find the code, so did a quick search on this and see commit
e6d9a5254333 ("arm64: do not enforce strict 16 byte alignment to stack
pointer"), and also two related discussions [1][2]. It seems that the
error entry to the man page was added around the same time as the
check got removed, and the check was there only because it would have
caused SIGBUS when the clone returns. Although in x86, non-16-byte
aligned push / pop would not SIGBUS, unlike aarch64...

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1462985814-16146-1-git-send-email-colin.king@canonical.com/
[2] https://lore.kernel.org/linux-man/571E731A.6050809@canonical.com/

> > To reproduce this bug, enable CONFIG_UML_RTC. uml_rtc will call
> > add_sigio_fd which will then cause write_sigio_thread to go
> > into segfault loop.
>
> It must also depend on the glibc version, because I've definitely been
> testing UML_RTC on 64-bit, on Fedora 32 at the time.
>

Hmm. Interesting. I can't seem to find anything suggesting Fedora has
a patch that would align the stack within clone() [3][4]. I also got a
Fedora 32 docker image and could not see the aligning from disassembly
of clone, and the gcc version installed by yum is 10.2.1-9.fc32, which
is supposed to be affected by this issue... weird. I would expect this
to fail outright. I'm considering compiling uml inside this container
to see what is going on.

[3] https://github.com/bminor/glibc/commits/master/sysdeps/unix/sysv/linux/x86_64/clone.S
[4] https://src.fedoraproject.org/rpms/glibc/tree/rawhide

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

