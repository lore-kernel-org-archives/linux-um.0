Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BFAD7361B
	for <linux-um@archiver.kernel.org>; Sun,  1 Dec 2024 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6XeldtyfqKO4eQ4OGXo6qPhSjN7vC77QWExey3hzGI=; b=Zk2Qm19LSUiz2hk1ySJLTJdniS
	SN+odweytH9+OTaaLAdhv7en7SgISHX0UxxK4GomfINMg+B7vWCGVBfKDiM4p0p7R5+7c3CIy3PgE
	Lax1RH10iZgps0uoTnsOYsNNKlHOo3Aou2Aj/J1E2X0H9A1ik3wq1QdZPaiJtCxCP+Isy8UWjlszo
	74XLeWGR2WYH/fnDMOjumti3qt52GGnCkWvbbTbkOhgSNdU38msQp5Uga7im8ODaQJvuA5AtQu1XD
	2lWgyYnKyfDFUOYoLRWDM243vG656DFSYA9gUyqKSmuy8coYcUg0j1nlzHeNVD6EWmDG7O7eR547I
	/Z/55u3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHYuw-00000002tK0-3eg7;
	Sun, 01 Dec 2024 01:38:34 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHYuu-00000002tJX-0ZZo
	for linux-um@lists.infradead.org;
	Sun, 01 Dec 2024 01:38:33 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso2602077b3a.3
        for <linux-um@lists.infradead.org>; Sat, 30 Nov 2024 17:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733017111; x=1733621911; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6XeldtyfqKO4eQ4OGXo6qPhSjN7vC77QWExey3hzGI=;
        b=VSDSJYTP4kovS8OuvodQC7ork/31AuYoq9m/JpOhIuAW/VE0HJ4uI5RdShbFFvx5go
         8QDVNAB4BcwLIcISyTC9fg9hqrpL6Yp0f3L9rs8Ch5WwhIzROPkrzTCSPRYp0aAYUBkE
         ZGsKpEPHM0UOE2IyFr3VGP/OsnVK/S7BdOKefIIUsqY4vM9IYsMshjq5Yf5Pa69lELS3
         QeJcBzcr2OFYZk1xXW7LZt+DXqIZ7gBjgtiMWc2L0WhXm5mmiZ3tMV1WvLSSYQM7dEMN
         dQnXrHD1ld+IFZsSvm5jSu69wyl/TeAhIldZDaFC3w/9zlKxOApN7esqwKTqXiqWNELB
         YFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733017111; x=1733621911;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6XeldtyfqKO4eQ4OGXo6qPhSjN7vC77QWExey3hzGI=;
        b=X516iBj9ClKZ9H+7ga3CZshfQWczeUzR/uAxseKAi7gCXAob2dS1w0HcS42xNEcpq7
         DWzyNEXVQ8Ppee+Wu6ta5UI2bN3ctnonDepw1ybHNQO8VCZQEywn6GGfh341VxZktC9U
         wa8ezEeCO47ETM49a7YVUE9elC7GtDfUU++xv41nJ4EX2XOKpg0B/4usGOgWO6j11eyy
         PhbuY1swtWJFFNzg9MNix3cm/TdkN5Wy2FOTbgnB9w32JYdM9jsNUfGErBEhojX+Ih2D
         FtKbKU5PL+u3n3WsKaBi4Hq9DMAl/frrfKAS2GlQuaUO4RCA2okmgfzFUK0TzczNefFE
         xe9g==
X-Gm-Message-State: AOJu0Yy/WOsm1kOa3j2qxkF0lVexBiS0iKGQ6woCuEICM8uyXFF9JsyB
	dEV1ys4Z/UJiGFwb8ecYzab+f2xd3F1ni4LZDPDQALkvZTnRW2i5
X-Gm-Gg: ASbGnctYGz20BY5/OM0xtDugOEVAAbu+9ZWKipqV0afZxhkDut1XqCHkwv/KMsgtt5o
	X3s6u6LBUWtHolyfCkoiOI4KtnC1e/8qW2Ugag2SYtEo7xR5hHuqm1tZFua5o6jCGw0geKuyKJY
	6yIeDMYjTvHVI61XT8LQan86PtHY7k8+zGQKuxNrW8PD6MDVVLWxfhLU+1ElA/kXIZWTrW6GxXq
	O94QkjiOOyLBKtH4G7Bqz/vCJKX5nZ2119lTE+GmianEQiF+y2AAqwM1L8ImItuR8bQI0/CW3/4
	k7U+iJfEg6WFIfO7XK90e4/uvNSp5oWnrVnl
X-Google-Smtp-Source: AGHT+IF2rb7Xy2p8TZbrSE7kxnzH3HWdlHvIylSj6O7SusW2CqwucMhjoy7xelgJA2i3E9fE7rS4+Q==
X-Received: by 2002:a05:6a00:14d5:b0:724:63f1:a522 with SMTP id d2e1a72fcca58-7253017551amr24649139b3a.22.1733017110524;
        Sat, 30 Nov 2024 17:38:30 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb950sm5998116b3a.121.2024.11.30.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 17:38:29 -0800 (PST)
Date: Sun, 01 Dec 2024 10:38:26 +0900
Message-ID: <m2h67ow5bh.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [RFC PATCH v2 10/13] x86/um: nommu: signal handling
In-Reply-To: <87da1cab734b9d92d17210abdeddc10afd533a0f.camel@sipsolutions.net>
References: <cover.1731290567.git.thehajime@gmail.com>
	<5a769da2dcc8e7f9b89fbdbc4bccd0b8a1660309.1731290567.git.thehajime@gmail.com>
	<87da1cab734b9d92d17210abdeddc10afd533a0f.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241130_173832_182249_395058C2 
X-CRM114-Status: GOOD (  34.08  )
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


Hello,

On Thu, 28 Nov 2024 19:37:21 +0900,
Benjamin Berg wrote:

> > +#ifndef CONFIG_MMU
> > + memset(&r, 0, sizeof(r));
> > + /* mark is_user=3D1 when the IP is from userspace code. */
> > + if (mc && (REGS_IP(mc->gregs) > uml_reserved
> > + =A0=A0 && REGS_IP(mc->gregs) < high_physmem))
> > + r.is_user =3D 1;
> > + else
> > +#endif
> > + r.is_user =3D 0;
>=20
> Does this work if we load modules dynamically?
>=20
> I suppose one could map them into a separate memory area rather than
> running them directly from the physical memory.
> Otherwise we'll also get problem with the SECCOMP filter.

currently, I thought modules use the separate area from execmem, but
nommu allocator ignores this location info to map the memory; instead
mixing up with area used by userspace programs.

we may be able to come up with execmem_arch_setup() to fix this
situation.

so, no, this is_user detection doesn't work; modules also become
is_user=3D1.

MMU full allocator (normal UML and seccomp asl well ?) seems to be
fine as long as using execmem.

I will look into detail how we should handle.

> > =A0 if (sig =3D=3D SIGSEGV) {
> > =A0 /* For segfaults, we want the data from the sigcontext. */
> > =A0 get_regs_from_mc(&r, mc);
> > @@ -191,6 +199,7 @@ static void hard_handler(int sig, siginfo_t *si, vo=
id *p)
> > =A0 ucontext_t *uc =3D p;
> > =A0 mcontext_t *mc =3D &uc->uc_mcontext;
> > =A0 unsigned long pending =3D 1UL << sig;
> > + int is_segv =3D 0;
> > =A0
> > =A0 do {
> > =A0 int nested, bail;
> > @@ -214,6 +223,7 @@ static void hard_handler(int sig, siginfo_t *si, vo=
id *p)
> > =A0
> > =A0 while ((sig =3D ffs(pending)) !=3D 0){
> > =A0 sig--;
> > + is_segv =3D (sig =3D=3D SIGSEGV) ? 1 : 0;
> > =A0 pending &=3D ~(1 << sig);
> > =A0 (*handlers[sig])(sig, (struct siginfo *)si, mc);
> > =A0 }
> > @@ -227,6 +237,12 @@ static void hard_handler(int sig, siginfo_t *si, v=
oid *p)
> > =A0 if (!nested)
> > =A0 pending =3D from_irq_stack(nested);
> > =A0 } while (pending);
> > +
> > +#ifndef CONFIG_MMU
> > + /* if there is SIGSEGV notified, let the userspace run w/ __noreturn =
*/
> > + if (is_segv)
> > + sigsegv_post_routine();
> > +#endif
> > =A0}
>=20
> I am confused, this doesn't feel quite correct to me.

thanks for pointing this out.  the above code, which I spot the
working example under nommu, is indeed suspicious and doesn't look a
right code.

that signal handing (this patch) is immature, and need more work to
understand existing code, nommu characteristic, etc.

> So, for normal UML, I think we always do an rt_sigreturn. Which means,
> we always go back to the corresponding *kernel* task. To schedule in
> response to SIGALRM, we forward the signal to the userspace process.
> I believe that means:
>    1. We cannot schedule kernel threads (that seems like a bug)
>    2. Scheduling for userspace happens once the signal is delivered.
>       Then userspace() saves the state and calls interrupt_end().
>=20
>=20
> Now, keep in mind that we are on the separate signal stack here. If we
> jump anywhere directly, we abandon the old state information stored by
> the host kernel into the mcontext. We can absolutely do that, but we
> need to be careful to not forget anything.
>=20
> As such, I wonder whether nommu should:
>    1. When entering from kernel, update "current->thread.switch_buf"
>       from the mcontext.
>        - If we need to schedule, push a stack frame that calls the schedu=
ling
>          code and returns with the correct state.
>    2. When entering from user, store the task registers from the
>       mcontext. At some point (here or earlier) ensure that the
>       "current->thread.switch_buf" is set up so that we can return to
>       userspace by restoring the task registers.
>        - To schedule, piggy back on 1. or add special code.
>    3. Always do a UML_LONGJMP() back into the "current" task.

thanks, the current code jumps in the signal handler and unblocking
signals without returning the handler (and not calling rt_sigreturn at
host either) upon SIGSEGV, which should not work as you mentioned.

I will also investigate how I can handle.

> That said, I am probably not having the full picture right now.
>=20
> Benjamin
>=20
> PS: On a further note, I think the current code to enter userspace
> cannot handle single stepping. I suppose that is fine, but you should
> probably set arch_has_single_step to 0 for nommu.

I did almost zero tests with ptrace(2) (inside nommu UM) and might
miss a lot of features that mmu-UM could.  will also look into that.

thanks,

-- Hajime

