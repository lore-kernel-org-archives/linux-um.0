Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3R97-00BWjX-2y
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 22:44:58 +0000
Received: by mail-yb1-xb2d.google.com with SMTP id b13so37525318ybk.4
 for <linux-um@lists.infradead.org>; Tue, 13 Jul 2021 15:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210713234710.ba0da02a609f.I56390429bc78e79e859e374183370c6311535786@changeid>
 <CAFLxGvxuC61cre6hOg2_-qCe6ArRgOYw0E8q-5ECS=mggoqF0g@mail.gmail.com>
In-Reply-To: <CAFLxGvxuC61cre6hOg2_-qCe6ArRgOYw0E8q-5ECS=mggoqF0g@mail.gmail.com>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Tue, 13 Jul 2021 17:44:45 -0500
Message-ID: <CABqSeAQWt41yvGCV3AbKuLeHUF0kvQvj6=0of-US4sn_=wxLDg@mail.gmail.com>
Subject: Re: [PATCH] um: fix stub location calculation
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>, subashab@codeaurora.org, Johannes Berg <johannes.berg@intel.com>

On Tue, Jul 13, 2021 at 5:11 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Tue, Jul 13, 2021 at 11:47 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > In commit 9f0b4807a44f ("um: rework userspace stubs to not hard-code
> > stub location") I changed stub_segv_handler() to do a calculation with
> > a pointer to a stack variable to find the data page that we're using
> > for the stack and the rest of the data. This same commit was meant to
> > do it as well for stub_clone_handler(), but the change inadvertently
> > went into commit 84b2789d6115 ("um: separate child and parent errors
> > in clone stub") instead.
> >
> > This was reported to not be compiled correctly by gcc 5, causing the
> > code to crash here. I'm not sure why, perhaps it's UB because the var
> > isn't initialized? In any case, this trick always seemed bad, so just
> > create a new inline function that does the calculation in assembly.
>
> My best guess is that gcc 5 sees only local modifications, but no further reads.
> So it treats it as dead store.
>
> > Reported-by: subashab@codeaurora.org
> > Fixes: 9f0b4807a44f ("um: rework userspace stubs to not hard-code stub location")
> > Fixes: 84b2789d6115 ("um: separate child and parent errors in clone stub")
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>
> BTW: Marking data/f as volatile fixes the problem too.
> That way gcc no longer optimizes data/f away.

Yeah, in the bad compilation,

(gdb) disas stub_segv_handler
Dump of assembler code for function stub_segv_handler:
   0x000000006033d0c5 <+0>:    push   %rbp
   0x000000006033d0c6 <+1>:    mov    %rsp,%rbp
   0x000000006033d0c9 <+4>:    int3
   0x000000006033d0ca <+5>:    pop    %rbp
   0x000000006033d0cb <+6>:    retq
End of assembler dump.

The store is optimized away -> the faultinfo is unmodified -> the segv
handler treats the fault as unfixable -> init dead.

>
> diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
> index 592cdb1..6331941 100644
> --- a/arch/um/kernel/skas/clone.c
> +++ b/arch/um/kernel/skas/clone.c
> @@ -25,7 +25,7 @@ void __attribute__ ((__section__ (".__syscall_stub")))
>  stub_clone_handler(void)
>  {
>         int stack;
> -       struct stub_data *data = (void *) ((unsigned long)&stack &
> ~(UM_KERN_PAGE_SIZE - 1));
> +       volatile struct stub_data *data = (void *) ((unsigned
> long)&stack & ~(UM_KERN_PAGE_SIZE - 1));
>         long err;
>
>         err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
> diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
> index 21836ea..87c3aef 100644
> --- a/arch/x86/um/stub_segv.c
> +++ b/arch/x86/um/stub_segv.c
> @@ -13,7 +13,7 @@ stub_segv_handler(int sig, siginfo_t *info, void *p)
>  {
>         int stack;
>         ucontext_t *uc = p;
> -       struct faultinfo *f = (void *)(((unsigned long)&stack) &
> ~(UM_KERN_PAGE_SIZE - 1));
> +       volatile struct faultinfo *f = (void *)(((unsigned
> long)&stack) & ~(UM_KERN_PAGE_SIZE - 1));
>
>         GET_FAULTINFO_FROM_MC(*f, &uc->uc_mcontext);
>         trap_myself();
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

