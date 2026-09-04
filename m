Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAA1C624DE
	for <linux-um@archiver.kernel.org>; Fri,  4 Sep 2026 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=; b=GwSagp6mh4ngzk51UZb79BVfyc
	0H8aT/uQbTsE4MuouftPj3ai0rmVytCDzqDvh9a2G7Uee+Em7fHjMsBkNjJ80LZSe93DrVX5Mqeec
	LUypLtlupSerrmR0/ZzOvQT89cHQG+AFGocdqai4wBnz7/9KKmgLr7Z4tuGZOM8XbIb32Et0oxb8W
	mwZkIvAT9itb8X3LfyNvAqXaOr2euBLHYb3tZJYqkhnNElOzj9+eXb5ByPkt035aCgkEQBKcHVNhA
	bSfaBppVca4aK+dP939RtvrS32FPhdNqKB5HZ7jTPY80PVfqfxJuue3nBj9YNUC91BpSZeU65vp5R
	ceu8mcyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2XbQ-00000002sFh-1llw;
	Fri, 04 Sep 2026 17:21:24 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2XbO-00000002sEg-0CRL
	for linux-um@lists.infradead.org;
	Fri, 04 Sep 2026 17:21:23 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6a5ebf75d62so1912099a12.1
        for <linux-um@lists.infradead.org>; Fri, 04 Sep 2026 10:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788542480; cv=none;
        d=google.com; s=arc-20260327;
        b=fA2cY+Oy7WZkf1CEjzA0fZ/pqULDmnAB0QnIGBiAIfa8fAVSgEkFET+GrHB+OTYBZL
         GcMmD1LJ9l95+SSPzmEdqBjjgHf7E5VVLtVYECnIL1YIaMnjvFHxO9ct9XvxBg1evA6w
         4fk81HneKhxelN9gHb90GYR4sCi+LFwEO0UxVdlV94ZwfuBugeYpZI8/VIsmHT5iIHAx
         4VM6AOaQaONKwfRX5m19M3UHWGbZaVImkl6HrqUx8junwD6axvaxK+XGfqrOyANQH+jG
         ibkIN4w0uQVibPxqrvQGF9c8RXN11ituth7ztoBB+q3PiwDsj4AVzASmQg2/zk8eqano
         QQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        fh=Ii0jRyIuYwXnHNE2CXFeLsikzlCATnULEDrL92B2NVo=;
        b=AR7jNeW9yL9Z354LOxKLFrShsfu68FaN27+651kp9KUZzImpZ41xemiTH2WvRHuD8k
         bDu5NKo7RLvhh4CVdADtT/YbP+kJVORTSgNwj/ziM8j7nicSAwD9At/wdT4LfnsLKkrb
         LGiHewLNqLudPi17JcqsQLNGC2+FZKHaYDyUusQ3IEjJOm/ilnWMTxqFg4ly4naiCAW8
         bEzbbBMr0fc0suFAycQT1+juPyP32MCe8VFxe8pJEQf/a3TjZh8xCFJSoHoRZj6vh6/h
         AZrSKYSpYfNL3XUmjuG2Sb2M+G4minAhYEiNi/RBrdfp/RAhDfL1FxICkDJ8C0c/61kH
         8mGA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542480; x=1789147280; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        b=CEUxXb8VUmHpqJcVXypX1+9IjftQTV2F6TWwLxtV9m3KKDErhxKcF7WkJeKBmEJjFr
         RTaVrdBz/nVryyYic5SpQQZWekkLYUzq06B596zAlwhVG0/FayJ82yA5s7Fd49AHefm4
         cePZxRAW5Rz40YOr2hhwyOZZHXthH4gP3nrRgwgR+DYsF+cpBC1wxgo4hBBy5J3uNYE1
         srmOWhG6VWTD0ouURi8tNJCNg9Loo/HkKgStLq+pi0kJ0pkLoDuKc64xKrNaKL5MCsdn
         b2+aJAt8jy5H6yYSJFwKYekyelu9QJ8B4gCSJtGz54PNCWbGkmCkN5y5tUD1ZKLWtN6q
         jUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542480; x=1789147280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        b=fXbQ10ZXs6OLxSy1hNQ6CpNg1WSdaZW7omUFAT8r2sdsUCnOrkN8rV8k/VeO4/8/q6
         lzmOfC5+O99mRvFd3Op0GgS8qBFmVuTJtFvFONVlWiY+OQkuINeHv7OLokL/mL3I8LDf
         X+54FXOU3hrOTfgzqraPrQbS41sSQairzBJwkhs3NOmHk8xeWXV1K4mFFEVKRU49lXcv
         h5ciyKZSfK4/ywHCy0qPzRCLtob35mBqMaXh8+WelKnAcNH/FYL/HnSe7tGcOQ7MJw8B
         tZ0O3iQ1TkSbhM14kxTQegdI+9ObfQr7n/hqfAGfDSGu/IkwtcG5j5qN2w8ABE+k63lt
         ifxA==
X-Forwarded-Encrypted: i=1; AKwUvBznqRf7Sesbj7TP2W60RY3NIw6Vh4GxtByJawhjuG68QlPHGaZQVLIbehmcFMHUBR8LXvC7rQ+47w==@lists.infradead.org
X-Gm-Message-State: AFuF++mAz4QmpVCpWI8Z54Y04AFAN+1K8Y5E4miGz+5DPAQQ5nuKHuuz
	/BQg6CYi385DW+Ra37web3qKGOHQ63U2AaN4Mrz9nXPVOereA8GCYJp5ETp/Ea918KceQPjraiK
	lejrzFK/i0p9KQUBMQSAF8QiDSdWxSN4=
X-Gm-Gg: AYBFou3/QpDxvEQLbdGurJKdHI1BRgasLoOurOPUPTUEMZxhs1Eeqx35zCwm0/HK0li
	UIokNAcwKzklH5KY4vnzTIfgfCzVvVSFp0XX0/focFjMCGDe8S3xNOFi9d2D3kNw8532zii3NBv
	U33lUWFDnj2HSMLh1p6/SbSLZoJaVyw9hSTm9atVeP9fhARcTMKIGvnzIlvl9OUwdq9WZ1eTCCT
	ZEmK5ooe8tLbtauU0MX7IC9m4OfOzwl4MRsUyEtRZL32S1NlRjyytMEPleMxnT9eweIVQHIgq9w
	7N6KF6Vs02sRaOQFyz3W5MsyItYPb5Bfmtg9RHYvnl1DQJ5D5/ihMLzXiG5FxygtL2wkhRacJfD
	3QP4pPfbXIpE7mwBfhPIgGNs6XcubaL0=
X-Received: by 2002:a05:6402:a252:20b0:6a6:9368:73a0 with SMTP id
 4fb4d7f45d1cf-6a696a73aa1mr4363499a12.6.1788542479338; Fri, 04 Sep 2026
 10:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 19:21:07 +0200
X-Gm-Features: AcwNN1WpEQ0Y6eKbtA6wNzDHeYOBs1Tconhq7C15XjRhFKDXvjk4jMYrR9OFExk
Message-ID: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_102122_114099_07B52879 
X-CRM114-Status: GOOD (  16.22  )
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

Hi Ricardo,

On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  arch/alpha/kernel/ptrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> index fc8f6cedbb28..8a39c0473297 100644
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
>         }
>
>  #ifdef CONFIG_AUDITSYSCALL
> -       audit_syscall_entry(syscall_get_nr(current, regs),
> -               regs->r16, regs->r17, regs->r18, regs->r19);
> +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
>  #endif
>         return syscall_get_nr(current, regs);
>  }
> --
> 2.55.0
>
This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series

https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail.c=
om/T/#t

That series moves alpha's syscall entry onto the generic entry
framework and removes syscall_trace_enter() and its direct
audit_syscall_entry() call entirely - verified with git am against
GENERIC_ENTRY applied, it fails at exactly this hunk.
You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
lands, alpha's syscall entry goes through
syscall_enter_from_user_mode_randomize_stack(), which already calls
syscall_enter_audit() as part of the shared entry helpers
(include/linux/entry-common.h). I applied patch 1/13 alone on top of
GENERIC_ENTRY and confirmed alpha's entry path already routes through
the updated __audit_syscall_entry() - no alpha-specific code needed.
So for alpha, you can drop this patch in the next revision rather
than rebase it.

Regards
Magnus

