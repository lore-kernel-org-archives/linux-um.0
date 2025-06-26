Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DDCC7EE33
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iuFmqpRengejqXGMt8z0krXQLsPU94kcoziX8PACH+I=; b=XVgNLfo3ZzwMpL+g7OOOGLPTeX
	CrKaI+SY/B+KqENmvNAL0Tg2ED/lkol23eJi+wix2ft3JRWEU5V8mCM/Zhx2Dy+yAJofbKDhK7UpN
	uK/rpfatTG5KyLOoGsyL/t5PCbNkzZzjAIUMLRg5SdQOLKeRiDNR2P1MvKmgRShueXvckUqfcvYRw
	LPdg9E3p/RI7f8v/AX5XPIAaDHt7YX4865QbrrMaacrko+xlcAMqcqaIClDzUZ4StkxeG9mcflEsg
	4BvhN1KoQQbgPCYI8krY+1rItmrLsJ9Jgww6IrcOiFIsFayxmjkjKhy8tghYgQvltkYj5WfFwV9qU
	acbZ7l3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUjGB-0000000BCRW-1xyj;
	Thu, 26 Jun 2025 09:51:11 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUix2-0000000B90C-47a1;
	Thu, 26 Jun 2025 09:31:26 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-553644b8f56so739418e87.1;
        Thu, 26 Jun 2025 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750930283; x=1751535083; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuFmqpRengejqXGMt8z0krXQLsPU94kcoziX8PACH+I=;
        b=EqfQEEeRj4r4bAulrFQFJ8jL/OBLJWgaPxF9ukgjkkmr3hAXhMghw1oRxgVLCglxTQ
         +BlOtn/w4lFBBQDwHfn0xRYK1iL1InBf5AtQfRCh5Qm1nT7AB4UNP/CPeOrcxj8eok9m
         T3FnL1aMIOuET8CE+nov3915oxAeAJ0M0JGhUiYZIDBHGdvXHUlSUZ+2oREyu9Ey8pDz
         4WiwvwgLaAgZDBPGQjj/aR63il25J0zPeuywqDnGZyUlps5Wo2csEgjvCIkabHQ/6AFD
         4xXOfF3092KGcAh1sjyR1NOl1YQJbVp5Fqppo/3LT0luYECChcMBjGqzpBZrYZOXubyc
         1/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930283; x=1751535083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuFmqpRengejqXGMt8z0krXQLsPU94kcoziX8PACH+I=;
        b=FnbVz29GKpk9AZK6dnP6dHTOCjrYRHg/phjbqtaGLbEALSSROxYJaEksGzWNiuU+ki
         IEaX3k/3LiqBMch79/pxibpuQO+XhYQ9IuOAKovosoeaIa/JQXfO7ov5gQBrG2+Xdhme
         hqv/YB3Mb8Xh3PxLWEDrGkf7qr9gysIiMbFzAQ3uROV0DwkpZGLPDjsFXyMZtgv21VcO
         Swp/HjhnqxVUhKdZu+JcASCrwnDz9cWRGVXN/qyko8+wRqkfxVosMYZlE+icFT1YOphF
         SoMFHJgqsvQsnWL6gkWqMoGyzs+hPplYdOqL5mvOturorC+Ib7VpWM9IBY4lAWOp/Thl
         4aNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2AQFBFDz0zLwfAvDvk0qv3QtYkJ8XCZT9HxSWrKSJNMJhGHq4xsKh/Jtbn00cLtAyTUcP+uk0qMg=@lists.infradead.org, AJvYcCXnuVorKr0u9gg/7ZPqzQCcVMrUlXqF3+yzWbv8+XYWINXx65vFRKA6LYFqZsMS9cz4Xn0q3ca2uy4yfEYbyzop@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3je+mu4SshZ482VChINX4vKVl8FORpVWm6uPnVAKscMpsQ6H4
	gAmoylmVKEF8wy+f9b2g2w12dJcymi+rCHkaLi9YyMs9dXEK2beMN1sJKVQoh00qKYLoZs3yiY4
	p+nBzz8DztVyU/vlRNwe7q6Z6xsSWcjk=
X-Gm-Gg: ASbGncuHoNvAqCy9yVTszDRKWmrr0VnPX3QFUEz040NNbuKLogB3QuCdwvsKuMQgCyN
	sQJQ13yiB2+VTgrJJIqtCnJjhdO14XbQ0lxZ95WcPfzBGIiRsTi3S5uQWv8NYHPCYmfG+0+c9B8
	8DSccHFs/FsuChoR2UA3rB6dN5HStGst6NT7WAS7Lv72v5fSQpLsWY
X-Google-Smtp-Source: AGHT+IHKD9vv7E6n80MsMeNjpJwBWGKsDmTjk3A0J3+cAywyuJ59mQfEiaL2YVTpTIc2tcdraTY+Dh5qWDg83RmXaIY=
X-Received: by 2002:a05:6512:1150:b0:553:36b7:7b14 with SMTP id
 2adb3069b0e04-554fdf96ec2mr2102615e87.37.1750930282937; Thu, 26 Jun 2025
 02:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250625095224.118679-1-snovitoll@gmail.com> <20250625095224.118679-2-snovitoll@gmail.com>
 <db30beb6-a331-46b7-92a3-1ee7782e317a@csgroup.eu>
In-Reply-To: <db30beb6-a331-46b7-92a3-1ee7782e317a@csgroup.eu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 26 Jun 2025 14:31:05 +0500
X-Gm-Features: Ac12FXyxTyp0b2hD3uhdVzbeUTYpXnyKRANJYa2mQoNch15i1MQX1xBLZECmC3k
Message-ID: <CACzwLxj3KWdy-mBu-te1OFf2FZ8eTp5CieYswF5NVY4qPWD93Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] kasan: unify static kasan_flag_enabled across modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, guoweikang.kernel@gmail.com, geert@linux-m68k.org, 
	rppt@kernel.org, tiwei.btw@antgroup.com, richard.weiyang@gmail.com, 
	benjamin.berg@intel.com, kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_023125_019627_7C6630D8 
X-CRM114-Status: GOOD (  14.28  )
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

On Wed, Jun 25, 2025 at 3:35=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit :
> > Historically the fast-path static key `kasan_flag_enabled` existed
> > only for `CONFIG_KASAN_HW_TAGS`. Generic and SW_TAGS either relied on
> > `kasan_arch_is_ready()` or evaluated KASAN checks unconditionally.
> > As a result every architecture had to toggle a private flag
> > in its `kasan_init()`.
> >
> > This patch turns the flag into a single global runtime predicate that
> > is built for every `CONFIG_KASAN` mode and adds a helper that flips
> > the key once KASAN is ready.
>
> Shouldn't kasan_init_generic() also perform the following line to reduce
> even more code duplication between architectures ?
>
>         init_task.kasan_depth =3D 0;

I've tried to introduce a new function kasan_mark_ready() to gather
all arch duplicated code in one place:

In mm/kasan/common.c:

void __init kasan_mark_ready(void)
{
        /* Enable error reporting */
        init_task.kasan_depth =3D 0;
        /* Mark KASAN as ready */
        static_branch_enable(&kasan_flag_enabled);
}

So we could've called it
in mm/kasan/generic.c:
void __init kasan_init_generic(void)
{
        kasan_mark_ready();
        pr_info("KernelAddressSanitizer initialized (generic)\n");
}

in mm/kasan/sw_tags.c:
void __init kasan_init_sw_tags(void)
{
...
        kasan_mark_ready();
        pr_info("KernelAddressSanitizer initialized ..");
}

in mm/kasan/hw_tags.c:
void __init kasan_init_hw_tags(void)
{
...
        kasan_mark_ready();
        pr_info("KernelAddressSanitizer initialized ..");
}

But it works only for CONFIG_KASAN_GENERIC mode,
when arch code calls kasan_init(), for example, arm64:

void __init kasan_init(void)
{
        kasan_init_shadow();
        kasan_init_generic();
}

And for HW_TAGS, SW_TAGS it won't work.
Fails during compiling:
mm/kasan/common.c:45:12: error: no member named 'kasan_depth' in
'struct task_struct'
   45 |         init_task.kasan_depth =3D 0;

because kasan_init_sw_tags(), kasan_init_hw_tags() are called
once on CPU boot. For arm64, where these KASAN modes are supported,
both functions are called in smp_prepare_boot_cpu().

So I guess, every arch kasan_init() has to set in kasan_init()
       init_task.kasan_depth =3D 0;
to enable error messages before switching KASAN readiness
via enabling kasan_flag_enabled key.

>
> Christophe
>

