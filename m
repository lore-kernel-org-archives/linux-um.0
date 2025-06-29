Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8395DC7EE30
	for <linux-um@archiver.kernel.org>; Sun, 29 Jun 2025 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qpjVZvBcIo5G28UGMNZaBkJZF6ITVDpFyOxvjBVjrQo=; b=XbvpAsZqW7yOYfUwnivmKevCGI
	cLpQh9kIaBivXJGbAs77YyDu/mbFREEIlvFPxOGT3xsJBryhPb7f0my07J7wntjAKYomdA4+kyfBQ
	DOynarClqjytI2bRz0EvKh8AgxUK3Qt5Q8ZEILJ42hAD6M+UiigEfuFFjW5W43ENx7XcpdiVD1vFw
	TRx/sm7iYpo5OIWLIUAHzlBBR+qu7ywJQh1H7YmSw2jlWmJgpaxUIM0rCm14cOmEuLVuc/eeXXR3k
	lIoHvuFWqQcsGeLxi8F36BSfoBjlS8cb3ohxVxuh2Ne2/ibSsUTG3hDqxBx9P/iKak6Df9xkhl1nF
	geJEk64Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVyHS-00000000g8Z-1KSX;
	Sun, 29 Jun 2025 20:05:38 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVyHP-00000000g7g-34UC;
	Sun, 29 Jun 2025 20:05:37 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3a52874d593so1198318f8f.0;
        Sun, 29 Jun 2025 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751227534; x=1751832334; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpjVZvBcIo5G28UGMNZaBkJZF6ITVDpFyOxvjBVjrQo=;
        b=cketaLXD+PUDlX6nzdQ5w6JODWtOyuj8Msa0s2TRDgrmr0EZdnwfti8Fp1hmjhywEX
         aeC1JT2l3pG2yD1R98uEPxhD0dZLQhfSxuVkJAUBFzbZbh0eTiDddtaoONvDrHR8Viup
         6tK1JXnuW8Dg7RCoiZV0KzCvwRvSMvPNoy6L5g7F/TyTCBDlIDh6I90ZItH9UXZCxj1w
         z8zZ/ntlKnxH4C5KCuLdQw7QgY3KeOF97tqrTCDGR6vbclV+KDoSO7RvmT2LS7IW8qLP
         cgJMoXtg1tFcR+HgJ58DUC1aOAmQYQeloSYtcSVVVSCsPU0OSaq+8aZY1UlSgGCPPtBy
         Ctgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751227534; x=1751832334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpjVZvBcIo5G28UGMNZaBkJZF6ITVDpFyOxvjBVjrQo=;
        b=XKV5sitysmR4zR1N+SfYCfmlCNa6gyCTydjmnhv9tUlxWvJayU69b+2nyK36x+qzGX
         JL65fWXXH5QdRGoAkDT0TL+kmb4bf00Ok+py4wmr0M6rgj69v7KtwWLlbKM4rC85A8we
         2jsWu99LrrH/sEQwLaFSFfj1RJQmzaLir7Hw2ta2Z+z6cLO1Ar5GzkP1HY9eWUldZc7g
         ymNGuLP9iEb8H8/d1JhhPR/giyfAFBFJkTs6Q0FchkGCQIWY9q1TrRaw8HF1nIz/o1Nk
         b96WZAUZ3/qSvgemh3m/rZTWoWcFubYLmZfjmau9zi+gsLxyos+PC8FHitx/CAxRBNbW
         Lezw==
X-Forwarded-Encrypted: i=1; AJvYcCUAlEh9jL7jpLZ+nLJ0rbQVRm33z4zcmLlEUhUtUglrKnf//ywkpt4pZQkgG8Syo313cSNDB+pGh4kLbRz8nIFy@lists.infradead.org, AJvYcCUL1L8Vqy/c9tuQWpaER/wwP7e+ZnVsiVxsduHX9NNmvXr4Q9ogE60ODkFufkV6yQuEXQOeu7Ib+3Wt09w=@lists.infradead.org, AJvYcCVSBzEeUbLjyUje72kPDIud/MLkLzyvaIMJPkgvSDlllZH4FZDDOMU79H4jjpVLch2kFhcP0GfyRaI=@lists.infradead.org
X-Gm-Message-State: AOJu0YzvzlgkdN7v8TB86eZ0K+CiqqNXwfYiQTEcQSNxOevx96fRH/VU
	2tYvARNwmpVrEV4o7Clhz7DVu/nHiJFFXTLtI7GOjtW2SHYO6pzq+O6TjUTRMdpUs1thyZasa+C
	m3A+M9Tod7QoWnon5mt2zosKjfzy77wY=
X-Gm-Gg: ASbGncumJzGHOyHRZTZSngfIrc8tqUzxdVZKuqxvzUJnTN5m655e1m1GETLaPEStL7h
	b9y/orzUDsNYWLpXT8DZjumkHpMCQDTIssSkyDg6snHZ1A4d6JbE0ZSH5DAsW5trVEnme1k5cIb
	7LxM/BAQua3/NLSvX44cpt8YyV2+lLeWT/3VRV0b4Yk/uahh5GTfdd3gs=
X-Google-Smtp-Source: AGHT+IG9Jnr7utU7Trd4lqTg8GWi9uRNVbru2WXxMPFleBJfH4kInx+LP9kDmy2SL/eaM5dKaQqnO/o2Ok4MjECqA8k=
X-Received: by 2002:a5d:59c7:0:b0:3a4:fc3f:ed28 with SMTP id
 ffacd0b85a97d-3a8fee64fafmr10710844f8f.29.1751227533501; Sun, 29 Jun 2025
 13:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250626153147.145312-1-snovitoll@gmail.com> <CA+fCnZfAtKWx=+to=XQBREhou=Snb0Yms4D8GNGaxE+BQUYm4A@mail.gmail.com>
 <CACzwLxgsVkn98VDPpmm7pKcbvu87UBwPgYJmLfKixu4-x+yjSA@mail.gmail.com>
In-Reply-To: <CACzwLxgsVkn98VDPpmm7pKcbvu87UBwPgYJmLfKixu4-x+yjSA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 29 Jun 2025 22:05:22 +0200
X-Gm-Features: Ac12FXwSsH6fvJE1vEp59zDWu481tFenq-ukDXNa3gyvAGzFlMqgNHF8VfcuM6Y
Message-ID: <CA+fCnZcGyTECP15VMSPh+duLmxNe=ApHfOnbAY3NqtFHZvceZw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with kasan_enabled
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, arnd@arndb.de, rppt@kernel.org, 
	geert@linux-m68k.org, mcgrof@kernel.org, guoweikang.kernel@gmail.com, 
	tiwei.btw@antgroup.com, kevin.brodsky@arm.com, benjamin.berg@intel.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_130535_779065_D91DB2B8 
X-CRM114-Status: GOOD (  26.80  )
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

On Sat, Jun 28, 2025 at 3:25=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> On Sat, Jun 28, 2025 at 3:57=E2=80=AFPM Andrey Konovalov <andreyknvl@gmai=
l.com> wrote:
> >
> > On Thu, Jun 26, 2025 at 5:32=E2=80=AFPM Sabyrzhan Tasbolatov
> > <snovitoll@gmail.com> wrote:
> > >
> > > This patch series unifies the kasan_arch_is_ready() and kasan_enabled=
()
> > > interfaces by extending the existing kasan_enabled() infrastructure t=
o
> > > work consistently across all KASAN modes (Generic, SW_TAGS, HW_TAGS).
> > >
> > > Currently, kasan_enabled() only works for HW_TAGS mode using a static=
 key,
> > > while other modes either return IS_ENABLED(CONFIG_KASAN) (compile-tim=
e
> > > constant) or rely on architecture-specific kasan_arch_is_ready()
> > > implementations with custom static keys and global variables.
> > >
> > > This leads to:
> > > - Code duplication across architectures
> > > - Inconsistent runtime behavior between KASAN modes
> > > - Architecture-specific readiness tracking
> > >
> > > After this series:
> > > - All KASAN modes use the same kasan_flag_enabled static key
> > > - Consistent runtime enable/disable behavior across modes
> > > - Simplified architecture code with unified kasan_init_generic() call=
s
> > > - Elimination of arch specific kasan_arch_is_ready() implementations
> > > - Unified vmalloc integration using kasan_enabled() checks
> > >
> > > This addresses the bugzilla issue [1] about making
> > > kasan_flag_enabled and kasan_enabled() work for Generic mode,
> > > and extends it to provide true unification across all modes.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217049
> >
> > Hi Sabyrzhan,
> >
> > Thank you for working on this!
> >
> > One aspect that is missing from the patches is moving the
> > kasan_arch_is_ready() calls into the include/linux/kasan.h (this is
> > not explicitly mentioned in the issue, but this is what the "adding
> > __wrappers" part is about).
> >
> > Another thing that needs careful consideration is whether it's
> > possible to combine kasan_arch_is_ready() and kasan_enabled() into the
> > same check logically at all. There's one issue mentioned in [1]:
>
> Hello,
> I've removed kasan_arch_is_ready() at all in this series:
> [PATCH v2 11/11] kasan: replace kasan_arch_is_ready with kasan_enabled
>
> Is it not what's expected by unification?

I guess the issue description diverged a bit from what needs to be
done, sorry about that.

The core 2 things I wanted to address with the unification are:

1. Avoid spraying kasan_arch_is_ready() throughout the KASAN
implementation and move these checks into include/linux/kasan.h (and
add __wrappers when required).

2. Avoid architectures redefining the same kasan_enabled global
variable/static key.

Initially, I thought that s/kasan_arch_is_ready/kasan_enabled + simply
moving the calls into affected include/linux/kasan.h functions would
be enough. But then, based on [1], turns out it's not that simple.

So now, I think we likely still need two separate checks/flags:
kasan_enabled() that controls whether KASAN is enabled at all and
kasan_arch_is_ready() that gets turned on by kasan_init() when shadow
is initialized (should we rename it to kasan_shadow_initialized()?).
But then we can still move kasan_arch_is_ready() into
include/linux/kasan.h and use the proper combination of checks for
each affected function before calling __wrappers. And we can still
remove the duplicated flags/keys code from the arch code.

[1] https://lore.kernel.org/linux-mm/CA+fCnZf7JqTH46C7oG2Wk9NnLU7hgiVDEK0EA=
8RAtyr-KgkHdg@mail.gmail.com/

