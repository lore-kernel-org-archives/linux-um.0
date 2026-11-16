Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088A606A31C
	for <linux-um@archiver.kernel.org>; Mon, 16 Nov 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vWfLtjt3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KdHj0mrw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=; b=vWfLtjt3qctYpI
	/b1ojo04LE6R6IUZEK9rRwOpVGj0rn/fgyXDwC/HoqAtrStGWLoOnt9NpJ+2AnJtYtwocsbmOKFdt
	SzgaXoPUwJvd2Vr6quSqT7lXdCAAQ/M6nhfqEoo7WYa4PXzhthW3fYoJbuTJRxGZMTDPyI0KYzd0n
	y78IDjuywlfhu122B8d7U/jfeM0pZhzZKb4+qRPzD7yhcH3D0S1xM/exWbjFvaS+s6RF4MVjF6T51
	8IKOgT4Ly7CxzMw+E8Q3WUxg3oimixaAvHITB4ELkPB9c6zAxEnxiz4hy+UOIJ0kC5uSa6tDQy6qU
	pB+WNurc1cS3RUgEZAHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT1AH-00000003VDB-39rV;
	Mon, 16 Nov 2026 18:10:49 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT1AD-00000003VCf-1HMV
	for linux-um@lists.infradead.org;
	Mon, 16 Nov 2026 18:10:47 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso5788506a12.2
        for <linux-um@lists.infradead.org>; Mon, 16 Nov 2026 10:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852643; cv=none;
        d=google.com; s=arc-20260327;
        b=Rlf+TaIqaPfHffpiJOGRvzthTGfIHS+KYgh3FqUV7e2KxHP7FbaftmtUxg7tbPO+m/
         WLPfU1MR9y1rgU5E7GIUSz7xKlWWdtjpIOQ1U8lrhFu7jbuHURjxUvcD3CwjsNogt4WG
         it/DTxrhjL5wk9xROamTIgkwd5+fk6D3GWpIV8XgAJkzqx4VGAvEPirH2jiVLtotOWtL
         u5pcyZKy/ugopg3uY81tr0e8YH01EGpsI8KMMdxw+hY42911YTGJyLgyIqEPgJdlZzh1
         TV5gSKlsNrwFMAIjw3i40Cj1cLKMk12nZf3DaHb2noIOiBeiFjMNCXa9BSYMNYRvgnkJ
         5/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
        fh=ah3YFWfqTYrwSCN4uR7NsJLKTanTeFzZoXhsyTFaK+Q=;
        b=s5fvrKFvetg393zj7sbIfEVUdZURsPcB5crKdHmeI5LS8yg5O8iiZOtYJURnSIzbNf
         O8rW99PQuVmNYTL8BEfUaWWu8uisAnYPQCYhbCRkktOCaukYenDACbuB9SUWLNx9aHm5
         0yShxE4QS/CbgzfmuLE68B5T6VJ0ztIuR1I0R/2QwMNWP1mHwledk1nur6kJeIi9Fc6M
         n/zzb5uSSC+qg5ctxUA5wvbThoW+ovN9//x2xnfJmJ1X5UkTAh/oJUZYYE0uhAzq9Mqs
         J0hzms/KMRet4JYTnkdcM9bJ0X9iA+nGrzzLmcQZEaOAZ5H5/Pyuv+SWsU7FDSTF07cS
         nTxg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794852643; x=1795457443; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
        b=KdHj0mrwUi4lusFOy10MHeYlkt5bvC5n+kB+VO2mF1ohB69OjYBtfqCVkb1V7h3qh3
         +2AcjX++VUBvzFej011Hw/A2aMceLOlav3k+NLLWpib6xffAfFORlEEBjuXcIgzMhamr
         Ps/RjRIfpxGpr8rj1NLA8PuvfA40wdyGw6IuinyiQO9zqCaLnPlrU5Wu+ZuAfikBgy/u
         sql9cnqQg1/KCK0TgZTskAWM4yI4QPxWqWc7xxjLXAsC9qxNJoB2PGK2Xb/GFcpe27cb
         FRzaQmQqVYpiMIrhusjz44hEdeJmojrFAT5537Dsmkx2pY64lh5p7uba0qimx4ZVSdX4
         yB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852643; x=1795457443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t10LdZZQL9q+bSGABLhe386ponBIV6xlTkNunDiJC5Y=;
        b=LzIqaZDU6iqnpU0GWgwDJBFuWVtHLev1/XFKzWe5bcbWsriieTfjLx+zRuvnFqmkjU
         5dkj51uD+DvKWd3WtMU3YuVknkBKIwIzUHN8HxTtgfKD/kiHVMIcrzrYtLJ9BRzLQZzJ
         ATp51whOF2lToCsUacXQ6blRzDb7TBX7PsKw/YWqjxnpsQSfyv/NH+nAYlkQYHxVuPDH
         4Qe9JhLngrfkc87imoHdwUNem93C8cimOSKU+HvPHYfonEGLyNIW444Yzg/626cM4xXj
         +kqC5m/pPcmymXMkI9u/R2bGjZPiyul1HX4QVaD7Fs/Y+grqwZVv8/04GwDQkB7+lByw
         wPuA==
X-Forwarded-Encrypted: i=1; AL+hErGPhsQ0PXqMFWm/q5XtMyudmXEn9mkMwHOj5hgh4su+ZXThPw85jBZpYHmWSaHS2oSHj3m06AEQBg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+EAgQQDsqlGDA/A9rj5Yv9VhUySA5xGaP8l2mqvjF4Gp/cQg3m
	rizsG70KBEsLIXS2PTqTjN5LZkQ0G57VSO3XCe928LpknLyICNBUWZ1PiRBOMl3W5sXfsxhEX8m
	Ie2rzuVlgAy5gApexAZ5Q/bibxUBIO14=
X-Gm-Gg: AYBFou1QvLi65VPSSjosF+vm0O2qj9ZdXPYX0W92DrLli1v96/aFAvowln7XG1W+cQC
	t2Y6RV9A0Dgm4hVreFRq1je3W4boloisLgRDeIqSgMM/PLT4XRwweY7uHG6Vd5YSs6gs/YBZqz3
	XyKwzVf/Hmjg5hYsuIOiVtJMCy57UrcuJUOTXZ7OwaNSiMcT77zr9LVWY3wyrcQli5gpOH1idl2
	gDoP0lZKF7F1LkgqGZP6+17mrFrTmgPhQVRdpWs1eiCDVLgUqTzASh/v5kR/hYjlTFtB/XLoyZX
	SrSysu8uGe34POz9zRGreuz3mMViw7zletMuF+Bf+LakUAqL3OljL0hTIPijbQO5G+FXwOGk9mo
	NI9bY7p+TUOPxEUVlb7hGDlYKkvQLrsTQBsUkHxcsRIGVBNj1LJ9q6k9eNtRYNeWXwRBCzyfH5S
	Ae13M/3nlclTlazCj8yXbVwV36BdR5hJH54KLosAYC4eAU
X-Received: by 2002:aa7:c4cc:0:b0:6b4:1037:2bb1 with SMTP id
 4fb4d7f45d1cf-6b7c0bc27a9mr6612692a12.22.1794852642773; Mon, 16 Nov 2026
 10:10:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114184720.373178-1-renzo@cs.unibo.it> <20261114184720.373178-2-renzo@cs.unibo.it>
In-Reply-To: <20261114184720.373178-2-renzo@cs.unibo.it>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Nov 2026 19:10:30 +0100
X-Gm-Features: AclHuK-3zf0u-_tVqqSwOuwnlXe0JuQIB0eE-s6YSpQo7rK-ZYPGihb4jDlFOAE
Message-ID: <CA+=Fv5QPMYffznpkrEhZ3pMWtpHwNUUa3OaHxLexu8S47a7tRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] asm/ptrace.h: add instruction_pointer_set
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Eugene Syromyatnikov <evgsyr@gmail.com>, Davide Berardi <berardi.dav@gmail.com>, 
	"Dmitry V . Levin" <ldv@strace.io>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, strace-devel@lists.strace.io, 
	linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_101045_386908_F23E8D61 
X-CRM114-Status: GOOD (  16.31  )
X-Spam-Score: -0.8 (/)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Renzo,

On Sat, Nov 14, 2026 at 7:47=E2=80=AFPM Renzo Davoli <renzo@cs.unibo.it> wr=
ote:
>
> Add an instruction_pointer_set function for architectures that do
> not currently provide one.
>
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
>  arch/alpha/include/asm/ptrace.h      | 6 ++++++
>  arch/hexagon/include/asm/ptrace.h    | 6 ++++++
>  arch/m68k/include/asm/ptrace.h       | 6 ++++++
>  arch/microblaze/include/asm/ptrace.h | 6 ++++++
>  arch/nios2/include/asm/ptrace.h      | 6 ++++++
>  arch/um/include/asm/ptrace-generic.h | 6 ++++++
>  arch/xtensa/include/asm/ptrace.h     | 6 ++++++
>  7 files changed, 42 insertions(+)
>
> diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptr=
ace.h
> index 45d1229344b6..1a6f073e892e 100644
> --- a/arch/alpha/include/asm/ptrace.h
> +++ b/arch/alpha/include/asm/ptrace.h
> @@ -33,6 +33,12 @@ static __always_inline bool regs_irqs_disabled(struct =
pt_regs *regs)
>         return arch_irqs_disabled_flags(regs->ps);
>  }
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  /* Syscall emulation defines */
>  #define PTRACE_SYSEMU                  0x1d
>  #define PTRACE_SYSEMU_SINGLESTEP       0x1e
> diff --git a/arch/hexagon/include/asm/ptrace.h b/arch/hexagon/include/asm=
/ptrace.h
> index ed35da1ee685..0a121f6e3bfc 100644
> --- a/arch/hexagon/include/asm/ptrace.h
> +++ b/arch/hexagon/include/asm/ptrace.h
> @@ -18,6 +18,12 @@ extern const char *regs_query_register_name(unsigned i=
nt offset);
>         ((struct pt_regs *) \
>          ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #if CONFIG_HEXAGON_ARCH_VERSION >=3D 4
>  #define arch_has_single_step() (1)
>  #endif
> diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrac=
e.h
> index bc86ce012025..6e8a8f0daee8 100644
> --- a/arch/m68k/include/asm/ptrace.h
> +++ b/arch/m68k/include/asm/ptrace.h
> @@ -18,6 +18,12 @@
>         (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) -=
 1
>  #define current_user_stack_pointer() rdusp()
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #define arch_has_single_step() (1)
>
>  #ifdef CONFIG_MMU
> diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/inclu=
de/asm/ptrace.h
> index 17982292a64f..69e10658d7a9 100644
> --- a/arch/microblaze/include/asm/ptrace.h
> +++ b/arch/microblaze/include/asm/ptrace.h
> @@ -20,5 +20,11 @@ static inline long regs_return_value(struct pt_regs *r=
egs)
>         return regs->r3;
>  }
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #endif /* __ASSEMBLER__ */
>  #endif /* _ASM_MICROBLAZE_PTRACE_H */
> diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptr=
ace.h
> index 96cbcd40c7ce..d120d8ecb187 100644
> --- a/arch/nios2/include/asm/ptrace.h
> +++ b/arch/nios2/include/asm/ptrace.h
> @@ -70,6 +70,12 @@ struct switch_stack {
>  #define user_stack_pointer(regs)       ((regs)->sp)
>  extern void show_regs(struct pt_regs *);
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #define current_pt_regs() \
>         ((struct pt_regs *)((unsigned long)current_thread_info() + THREAD=
_SIZE)\
>                 - 1)
> diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/p=
trace-generic.h
> index 62e9916078ec..632d4ce3334d 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -29,6 +29,12 @@ struct pt_regs {
>
>  #define PTRACE_OLDSETOPTIONS 21
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  #ifdef CONFIG_BINFMT_ELF_FDPIC
>  #define PTRACE_GETFDPIC                31
>  #define PTRACE_GETFDPIC_EXEC   0
> diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/p=
trace.h
> index d0568ff6d349..97b14418955e 100644
> --- a/arch/xtensa/include/asm/ptrace.h
> +++ b/arch/xtensa/include/asm/ptrace.h
> @@ -103,6 +103,12 @@ static inline unsigned long regs_return_value(struct=
 pt_regs *regs)
>         return regs->areg[2];
>  }
>
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +                                          unsigned long val)
> +{
> +       instruction_pointer(regs) =3D val;
> +}
> +
>  int do_syscall_trace_enter(struct pt_regs *regs);
>  void do_syscall_trace_leave(struct pt_regs *regs);
>
> --
> 2.47.3
>

The Alpha change looks good and applies cleanly on my for-next,
including the generic-entry fixes.

Tested both series together on my AlphaServer ES40. The ptrace
selftests passed on all three CPUs, including syscall skipping
and instruction-pointer modification.

For the Alpha part:

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

Thanks,
Magnus

