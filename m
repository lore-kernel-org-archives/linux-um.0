Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5868AD690F3
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xi1NNx5hEz/F7STuV4ZtM2ZTHHKucRa8UOzRhNh8aI=; b=XE81YSmgIsxQvjIcC6FEBdpxdA
	PXHTttgXvBNjFx9JPyuQRRVBJv/HJ+lJNsXXb0ajzEQNpNh0bbMt6PpwRIvk4LQLVuODfkja1cd0X
	WsZ8fz461JqdyntFq9FtqE/7RkpA9wv+6OVrs8Pmt3GTBMMVWtBv9GzOKir1++6wSFU1hkNXS2zrI
	8rsKrrm5BLJW5VlZ3dXYyE1rBt42ZOqy+/sO2ahLkirI/nf8LwmTPWTV9gGQA3ddtxCLmn0jZACrP
	Hh3XzhotcU6EDJhZ5PviUkLhcK8xxiWc96L2SRfUvh6ErW7Sl7bx3xWlmW3CNuCeXINy7e9JiPm3+
	5FqgXZKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbua-0000000FHAa-3eXk;
	Thu, 28 Nov 2024 10:38:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbtr-0000000FH0u-2L6N
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 10:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4xi1NNx5hEz/F7STuV4ZtM2ZTHHKucRa8UOzRhNh8aI=;
	t=1732790249; x=1733999849; b=XcI8R5+i1GQm7zSUwFZR/p4+ZA9BsIv3aiehyVncJIxwiiu
	7m8KPnnGrLIxDN5v2y2Ce3KJc++pFasaYwzyLlr73iXU5KoZdPjraTfVSdyA4a9JJ8JjGrYWY3hRO
	onyTAPvOO8GOWmHP1xI5VOecUuKOua1Xb/7cb72+uqf+fS6Wchz3JGknkxqw/PBfDTQpcHy9y4JsP
	Wuj0fClbxLJ2akg6wl6DGRSOwNH2V8SRdefI7S2/D3GCK5IyzaETKR9szbOFzT5X9K/1f7E54oEkM
	R3+VoTHzRVg0GV0bCS9pD04gC8Rpe3wxjQpFM+kK/p4WiMNHAsIGlvU82+AawY4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tGbtl-000000008HL-2Euw;
	Thu, 28 Nov 2024 11:37:25 +0100
Message-ID: <87da1cab734b9d92d17210abdeddc10afd533a0f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 10/13] x86/um: nommu: signal handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Thu, 28 Nov 2024 11:37:21 +0100
In-Reply-To: <5a769da2dcc8e7f9b89fbdbc4bccd0b8a1660309.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <5a769da2dcc8e7f9b89fbdbc4bccd0b8a1660309.1731290567.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_023731_775538_2A73C832 
X-CRM114-Status: GOOD (  31.48  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, 2024-11-11 at 15:27 +0900, Hajime Tazaki wrote:
> This commit updates the behavior of signal handling under !MMU
> environment. 1) the stack preparation for the signal handlers and
> 2) restoration of stack after rt_sigreturn(2) syscall.=C2=A0 Those are ne=
eded
> as the stack usage on vfork(2) syscall is different.
>=20
> It also adds the follow up routine for SIGSEGV as a signal delivery runs
> in the same stack frame while we have to avoid endless SIGSEGV.
>=20
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> ---
> =C2=A0arch/um/include/shared/kern_util.h |=C2=A0 3 +++
> =C2=A0arch/um/kernel/trap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++
> =C2=A0arch/um/os-Linux/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 ++++++++++++++-
> =C2=A0arch/x86/um/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 37 +++++++++++++++++++++++++++++-
> =C2=A04 files changed, 66 insertions(+), 2 deletions(-)
>=20
> [SNIP]
> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> index 52852018a3ad..a06622415d8f 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -36,7 +36,15 @@ static void sig_handler_common(int sig, struct siginfo=
 *si, mcontext_t *mc)
> =C2=A0 struct uml_pt_regs r;
> =C2=A0 int save_errno =3D errno;
> =C2=A0
> - r.is_user =3D 0;
> +#ifndef CONFIG_MMU
> + memset(&r, 0, sizeof(r));
> + /* mark is_user=3D1 when the IP is from userspace code. */
> + if (mc && (REGS_IP(mc->gregs) > uml_reserved
> + =C2=A0=C2=A0 && REGS_IP(mc->gregs) < high_physmem))
> + r.is_user =3D 1;
> + else
> +#endif
> + r.is_user =3D 0;

Does this work if we load modules dynamically?

I suppose one could map them into a separate memory area rather than
running them directly from the physical memory.
Otherwise we'll also get problem with the SECCOMP filter.

> =C2=A0 if (sig =3D=3D SIGSEGV) {
> =C2=A0 /* For segfaults, we want the data from the sigcontext. */
> =C2=A0 get_regs_from_mc(&r, mc);
> @@ -191,6 +199,7 @@ static void hard_handler(int sig, siginfo_t *si, void=
 *p)
> =C2=A0 ucontext_t *uc =3D p;
> =C2=A0 mcontext_t *mc =3D &uc->uc_mcontext;
> =C2=A0 unsigned long pending =3D 1UL << sig;
> + int is_segv =3D 0;
> =C2=A0
> =C2=A0 do {
> =C2=A0 int nested, bail;
> @@ -214,6 +223,7 @@ static void hard_handler(int sig, siginfo_t *si, void=
 *p)
> =C2=A0
> =C2=A0 while ((sig =3D ffs(pending)) !=3D 0){
> =C2=A0 sig--;
> + is_segv =3D (sig =3D=3D SIGSEGV) ? 1 : 0;
> =C2=A0 pending &=3D ~(1 << sig);
> =C2=A0 (*handlers[sig])(sig, (struct siginfo *)si, mc);
> =C2=A0 }
> @@ -227,6 +237,12 @@ static void hard_handler(int sig, siginfo_t *si, voi=
d *p)
> =C2=A0 if (!nested)
> =C2=A0 pending =3D from_irq_stack(nested);
> =C2=A0 } while (pending);
> +
> +#ifndef CONFIG_MMU
> + /* if there is SIGSEGV notified, let the userspace run w/ __noreturn */
> + if (is_segv)
> + sigsegv_post_routine();
> +#endif
> =C2=A0}

I am confused, this doesn't feel quite correct to me.

So, for normal UML, I think we always do an rt_sigreturn. Which means,
we always go back to the corresponding *kernel* task. To schedule in
response to SIGALRM, we forward the signal to the userspace process.
I believe that means:
   1. We cannot schedule kernel threads (that seems like a bug)
   2. Scheduling for userspace happens once the signal is delivered.
      Then userspace() saves the state and calls interrupt_end().


Now, keep in mind that we are on the separate signal stack here. If we
jump anywhere directly, we abandon the old state information stored by
the host kernel into the mcontext. We can absolutely do that, but we
need to be careful to not forget anything.

As such, I wonder whether nommu should:
   1. When entering from kernel, update "current->thread.switch_buf"
      from the mcontext.
       - If we need to schedule, push a stack frame that calls the scheduli=
ng
         code and returns with the correct state.
   2. When entering from user, store the task registers from the
      mcontext. At some point (here or earlier) ensure that the
      "current->thread.switch_buf" is set up so that we can return to
      userspace by restoring the task registers.
       - To schedule, piggy back on 1. or add special code.
   3. Always do a UML_LONGJMP() back into the "current" task.

That said, I am probably not having the full picture right now.

Benjamin

PS: On a further note, I think the current code to enter userspace
cannot handle single stepping. I suppose that is fine, but you should
probably set arch_has_single_step to 0 for nommu.

> =C2=A0void set_handler(int sig)
> diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
> index 75087e85b6fd..b7365c75a967 100644
> --- a/arch/x86/um/signal.c
> +++ b/arch/x86/um/signal.c
> @@ -371,6 +371,13 @@ int setup_signal_stack_si(unsigned long stack_top, s=
truct ksignal *ksig,
> =C2=A0 round_down(stack_top - sizeof(struct rt_sigframe), 16);
> =C2=A0
> =C2=A0 /* Add required space for math frame */
> +#ifndef CONFIG_MMU
> + /*
> + * the sig_frame on !MMU needs be aligned for SSE as
> + * the frame is used as-is.
> + */
> + math_size =3D round_down(math_size, 16);
> +#endif
> =C2=A0 frame =3D (struct rt_sigframe __user *)((unsigned long)frame - mat=
h_size);
> =C2=A0
> =C2=A0 /* Subtract 128 for a red zone and 8 for proper alignment */
> @@ -417,6 +424,18 @@ int setup_signal_stack_si(unsigned long stack_top, s=
truct ksignal *ksig,
> =C2=A0 /* could use a vstub here */
> =C2=A0 return err;
> =C2=A0
> +#ifndef CONFIG_MMU
> + /*
> + * we need to push handler address at top of stack, as
> + * __kernel_vsyscall, called after this returns with ret with
> + * stack contents, thus push the handler here.
> + */
> + frame =3D (struct rt_sigframe __user *) ((unsigned long) frame -
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(unsigned long));
> + err |=3D __put_user((unsigned long)ksig->ka.sa.sa_handler,
> + =C2=A0 (unsigned long *)frame);
> +#endif
> +
> =C2=A0 if (err)
> =C2=A0 return err;
> =C2=A0
> @@ -442,9 +461,25 @@ SYSCALL_DEFINE0(rt_sigreturn)
> =C2=A0 unsigned long sp =3D PT_REGS_SP(&current->thread.regs);
> =C2=A0 struct rt_sigframe __user *frame =3D
> =C2=A0 (struct rt_sigframe __user *)(sp - sizeof(long));
> - struct ucontext __user *uc =3D &frame->uc;
> + struct ucontext __user *uc;
> =C2=A0 sigset_t set;
> =C2=A0
> +#ifndef CONFIG_MMU
> + /**
> + * we enter here with:
> + *
> + * __restore_rt:
> + *=C2=A0=C2=A0=C2=A0=C2=A0 mov $15, %rax
> + *=C2=A0=C2=A0=C2=A0=C2=A0 call *%rax (translated from syscall)
> + *
> + * (code is from musl libc)
> + * so, stack needs to be popped of "call"ed address before
> + * looking at rt_sigframe.
> + */
> + frame =3D (struct rt_sigframe __user *)((unsigned long)frame + sizeof(l=
ong));
> +#endif
> + uc =3D &frame->uc;
> +
> =C2=A0 if (copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
> =C2=A0 goto segfault;
> =C2=A0


