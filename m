Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46358EEB59D
	for <linux-um@archiver.kernel.org>; Thu, 12 Sep 2024 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDRZeLrzljWEdJqCHAMACK6arKI+JQ8kR+WISNMCIis=; b=EZiHMckDYJeNe9hvPDZG11ORAa
	2setHeXh9DilVGE2zSaQlC2PPVCyw2YgmpKD3mEZTCr+dDGhdIupJhMOE1Ae0fNz5B7Sxt5IxvTmy
	nNZKls9Z9IC31AbbHEZbM4FpKlb2Qjo4sDsoWjcOJju84gMp8meAnGG9JkQZVBnu0uxhkhCHZKpRb
	fAXkUbjqbdU+FO40m6JM75ovWpQgp+DHBdGKXP3JV5XvMmNINTfoUtyQ0/JOI1UBq2ux2smWaATvE
	zjvgUvW/ZzJu4T1S75gie8jNmbJ3KI4a2gk+fM4pO+PhaWADBIevXkQ4lQRS/9njZeLW681PzLVkK
	tVwVwUyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sop5I-0000000DzVD-2a1i;
	Thu, 12 Sep 2024 19:02:28 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sop5F-0000000DzUt-0Pr6
	for linux-um@lists.infradead.org;
	Thu, 12 Sep 2024 19:02:26 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-70b2421471aso51824a12.0
        for <linux-um@lists.infradead.org>; Thu, 12 Sep 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726167743; x=1726772543; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDRZeLrzljWEdJqCHAMACK6arKI+JQ8kR+WISNMCIis=;
        b=Fc5XXn5Rs3CsANJdC3bzZc9Mug+/P1LGtvcSKToejtF/4OHa+5g5F0qBa6y7b7agrX
         FC2ddkiVNxLaBRQYSy7nhumtBU/4rRhR5a9kF5ADsytjnIyaBuNd+FqK5NE7TGLbxf3p
         8f9pPZ3GLZoyVVIYa22WTgwm2d6yx60i8IHmYijFcF5oSzLM/kNZ7sef0zuA+khthQ3W
         iGCQx46278UfqoUvK16hg2ShEYbxVGEF4tsowNsgMqRhK4QN95T/N4O4Ove+Vr24Pb6t
         Itn34co/wPEw4hD0AzM62YuVrFiv2kYfTlg48twK/RrtrZ4apq9jQKI/pcysVK59C8VO
         Z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167743; x=1726772543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDRZeLrzljWEdJqCHAMACK6arKI+JQ8kR+WISNMCIis=;
        b=UV6seoCO0ItcuTyZ9WS8xQqhEN3XxPFousOJEHMBa3sv1GdAHt5xtOJQzmYLbawm/i
         bO5k+TXxHxOva3twU1Rso+fPKba0WjxK5H6Js08+oDeahCPTnuEV8htrZolIIRuU2r7E
         meGieo2riIFUUZUrMlCVnEC+j9Ur8yFj6Lx88LU8m+/CX6GESyvtWNXkQcGneetnSSth
         sJrVDerTcCSKJ4oHBj3NgDK4pZsmW+BB+uo4i8q/FGLJkNqFXeUsST/T4imWO7dXr6ok
         2DmkwHx1vTfMdIfSMHz+j+if6ePKMANqGaopp/QLQf2WKr+cDbjc4nxwbZ2RuXTuRTxH
         YO8g==
X-Gm-Message-State: AOJu0YwP5dRLsSPWB1cK67svHR3NE1HrUt22N+xTR4Lrd/nXFFt0kfVF
	IYAyMTiCsJLZD+nBwaAcxc46/RBz6PvguFMMVYTpX7cjhykCqAWDs5enRa0edIVqBahNjBtN4kT
	BM+dkMPKi3Rbysm39gJTgJf56bNU=
X-Google-Smtp-Source: AGHT+IHOH+w1VyO14+91O4qvLI642gGn0BNslxC/aAskUvp7xKtJEVo5lIKquInIxKyHTS0260taC6QkOk4rT95y/gA=
X-Received: by 2002:a17:90b:3b4a:b0:2d3:d7b9:2c7e with SMTP id
 98e67ed59e1d1-2dbb9e20e1emr119639a91.24.1726167743309; Thu, 12 Sep 2024
 12:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240830153825.1466691-1-benjamin@sipsolutions.net>
In-Reply-To: <20240830153825.1466691-1-benjamin@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 12 Sep 2024 21:02:11 +0200
Message-ID: <CAFLxGvxPM9x9ay7+7Sv4wwPFKM9keZGfy9C2=5Cbk-_BUf88gQ@mail.gmail.com>
Subject: Re: [PATCH] um: add RCU syscall hack for time-travel
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_120225_192426_22783CDC 
X-CRM114-Status: GOOD (  21.49  )
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

On Fri, Aug 30, 2024 at 5:38=E2=80=AFPM Benjamin Berg <benjamin@sipsolution=
s.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> In time-travel mode userspace can do a lot of work without any time
> passing. Unfortunately, this can result in OOM situations as the RCU
> core code will never be run.
>
> Work around that by kicking the RCU using rcu_sched_clock_irq. So
> behave to the RCU code as if a clock tick happened every syscall.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>
> ---
>
> This patch is on top of "um: fix time-travel syscall scheduling hack"
> ---
>  arch/um/kernel/skas/syscall.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.=
c
> index b09e85279d2b..4b4ab8bf8a0c 100644
> --- a/arch/um/kernel/skas/syscall.c
> +++ b/arch/um/kernel/skas/syscall.c
> @@ -19,6 +19,21 @@ void handle_syscall(struct uml_pt_regs *r)
>         struct pt_regs *regs =3D container_of(r, struct pt_regs, regs);
>         int syscall;
>
> +       /*
> +        * This is a "bit" of a hack. But in time-travel mode userspace c=
an do
> +        * a lot of work without any time passing. Unfortunately, this ca=
n
> +        * result in OOM situations as the RCU core code will never be ru=
n.
> +        *
> +        * Work around that by kicking the RCU using rcu_sched_clock_irq.=
 So
> +        * behave to the RCU code as if a clock tick happened every sysca=
ll.
> +        */
> +       if (time_travel_mode =3D=3D TT_MODE_INFCPU ||
> +           time_travel_mode =3D=3D TT_MODE_EXTERNAL) {
> +               local_irq_disable();
> +               rcu_sched_clock_irq(1);
> +               local_irq_enable();
> +       }
> +

While I acknowledge that time-travel itself is a beautiful hack, I'd
like to keep the hacks
to keep it working minimal.
So, the problem here is that RCU callbacks never run and just pile up?

I wonder why such a situation does not happen in a nohz_full setup on
regular systems.

--=20
Thanks,
//richard

