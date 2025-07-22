Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D702C87FC5
	for <linux-um@archiver.kernel.org>; Tue, 22 Jul 2025 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s1bfHAcPl/XMz8xDguK3teTl09r5v0kLVciBst2DtbI=; b=ZXy9a9u4QH1m+PGLNWBhAy9pLa
	BA6m27iHgjFCAozM0QPhS/jYuHhTNPJ998Z9Y9xdcj6JbB0VBXlhsWFEA8xmJjpwVvInlI6reWb2v
	T0tHzHSNSrNkA8RE1m5UHxw9mLMw2Jh3dqymifZWJorSoZv8XN+d7+P/kr9sqtyN0r9CSCWdRqAJo
	n4/MA2b55IA7s0w7bzUoItXMPZxVH+aWjbVjJBRDvFJfhOtaXvRL4+pOOFY9yqfEJXqRPWLkRsXIS
	wuEugB452jgOy1Cs5hVTI5/O7Cxwcr403ip7njHdJJQfEefcozFQNlI7lUF2o3IQM71mWousvKOY2
	qorcZJ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueHcN-00000003Eq3-3ofz;
	Tue, 22 Jul 2025 18:21:35 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueHcK-00000003EpG-3ZvJ;
	Tue, 22 Jul 2025 18:21:33 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-553e5df44f8so5268783e87.3;
        Tue, 22 Jul 2025 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208491; x=1753813291; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1bfHAcPl/XMz8xDguK3teTl09r5v0kLVciBst2DtbI=;
        b=CcrzXKDpBy512Lu2Plaju7Q7RWggxWG7eOtFCG6YTp85DxrIAEEZ3JVuwOQjTMDX0S
         JDpsXJZ0EfFFHefd9we7iA7/QE4o0+ONG1ereEllIscde/uEUtsI6gAWGs7pIqXTGbOb
         cjFH/U3+0zC4VJ79+0TlJkh5KWAUhdZWvs/0/srYtTLg5DWpBaoPsymQt3GQi6Fe56Ne
         q4h8iPZdz7SHueAU6yb9c24yDY5ryCoYnsSTG2hAw64uXhlyY+UC7AEx01OX08UdUklK
         YViIUyMKVQHkiM9RUmNYWrDgvxCGoV7gBhJ7BxOiGlnO8wXINUHNknHetCN/dWE7br7i
         AUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208491; x=1753813291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1bfHAcPl/XMz8xDguK3teTl09r5v0kLVciBst2DtbI=;
        b=tSPjdd0dSp+VJYI9+CsHIHr+lLCrpblArkSPKYmrnozrsZYiYY6Cu0LudOCY+uEJEW
         YrYXsfor5mOvJGxCCDVx2zlmbz0WA+MYQoqI/OAMiquepWbx9oVF7zQSanZuiTYsQVHL
         gPqosOoJXvgVZhMdJuAv8e1Rogx6uj0/dgBYLLDl3nzihc5scbknlzva4hZ4dwoWizrL
         FpOU0RHoFnLNEyj7i7KATVTm/9eE5sqvZiQrk1XLf9cDm07edESWPzFFlEq35ID6O+jH
         NSZgcel2GHKyiuN4jrYeVBeW/tiLM4LVWvNGvv/OLdP6B6NhcPhYtT+K3n06kzlF1nV+
         Slpw==
X-Forwarded-Encrypted: i=1; AJvYcCXdNo3nFrE74vgidASsV4lM9vP3/9iF4zAD5nOAUIjI6tlqvO5DY8LBKe4WWMT7ZH+Y5lvel368fzU=@lists.infradead.org, AJvYcCXsNPjhYtgnwbUNwCCjNwoarV9g3wuPMWqOCBrXtHKfDcf7pXGtX1y+CWn+X8I4ERabrT4Q3KasqgeXiw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsFMrB8PEy3Zq6B7sTiI/o1VGa2dFNCoqKgy6Qn11zo5MldXr8
	MTT9oYD1dNNrXq1PO7pQ8Ho7lVOeMJ+zLnIuJoBom4KqD6qBIpA/6RcP3BOBkAViSZg+hwqNz74
	QbA8Aomqm8Wsmo2ej2tUFtWm1OKbl0U8=
X-Gm-Gg: ASbGncuuJR7x6Xm1+lB+VeKpfOkimFwg/bvxShwJ+XQ/ab1cjgpCMIbRVTPHwDvinBL
	YPYdQGnNPto1nFRThMsz0Qqg8HscCIlgoY4vecJDQv+n/F949uVKbOJssAd3o8JHMo01BoZEbe/
	KYvKwZj0TDtg2LKEpZSHclNcvNLyUCqQAvPvSbcBCB3MfB1/Kaxm/erQllJghZm51Iuuri6X6h3
	VMKKy8=
X-Google-Smtp-Source: AGHT+IHgqZRO4CHZDXwO8i4qviF6GOSHLcIqgaK9MAu32BIYgiKkWD327bPslpy0X0mdn5DHRJd+TcwlCu2XTW4y0IA=
X-Received: by 2002:a05:6512:4021:b0:553:2190:fef8 with SMTP id
 2adb3069b0e04-55a513998a5mr31899e87.7.1753208490745; Tue, 22 Jul 2025
 11:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
In-Reply-To: <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 22 Jul 2025 23:21:13 +0500
X-Gm-Features: Ac12FXzOVMCIvnTEhZltt3TS4XKarYeDIkGkWcMAqG0GgJ62pPTw9Xni6fYiOgs
Message-ID: <CACzwLxjD0oXGGm2dkDdXjX0sxoNC2asQbjigkDWGCn48bitxSw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove
 arch-specific implementations
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com, 
	dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_112132_891736_400B73F4 
X-CRM114-Status: GOOD (  18.54  )
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

On Tue, Jul 22, 2025 at 3:59=E2=80=AFAM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
>
>
> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
>
> > =3D=3D=3D Testing with patches
> >
> > Testing in v3:
> >
> > - Compiled every affected arch with no errors:
> >
> > $ make CC=3Dclang LD=3Dld.lld AR=3Dllvm-ar NM=3Dllvm-nm STRIP=3Dllvm-st=
rip \
> >       OBJCOPY=3Dllvm-objcopy OBJDUMP=3Dllvm-objdump READELF=3Dllvm-read=
elf \
> >       HOSTCC=3Dclang HOSTCXX=3Dclang++ HOSTAR=3Dllvm-ar HOSTLD=3Dld.lld=
 \
> >       ARCH=3D$ARCH
> >
> > $ clang --version
> > ClangBuiltLinux clang version 19.1.4
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> >
> > - make ARCH=3Dum produces the warning during compiling:
> >       MODPOST Module.symvers
> >       WARNING: modpost: vmlinux: section mismatch in reference: \
> >               kasan_init+0x43 (section: .ltext) -> \
> >               kasan_init_generic (section: .init.text)
> >
> > AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
> > is placed in own section ".kasan_init", which calls kasan_init_generic(=
)
> > which is marked with "__init".
> >
> > - Booting via qemu-system- and running KUnit tests:
> >
> > * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results=
.
> > * x86_64 (GENERIC): no regression, no errors
> >
>
> It would be interesting to see whether ARCH_DEFER_KASAN=3Dy arches work.
> These series add static key into __asan_load*()/_store*() which are calle=
d
> from everywhere, including the code patching static branches during the s=
witch.
>
> I have suspicion that the code patching static branches during static key=
 switch
> might not be prepared to the fact the current CPU might try to execute th=
is static
> branch in the middle of switch.

AFAIU, you're referring to this function in mm/kasan/generic.c:

static __always_inline bool check_region_inline(const void *addr,

      size_t size, bool write,

      unsigned long ret_ip)
{
        if (!kasan_shadow_initialized())
                return true;
...
}

and particularly, to architectures that selects ARCH_DEFER_KASAN=3Dy, which=
 are
loongarch, powerpc, um. So when these arch try to enable the static key:

1. static_branch_enable(&kasan_flag_enabled) called
2. Kernel patches code - changes jump instructions
3. Code patching involves memory writes
4. Memory writes can trigger any KASAN wrapper function
5. Wrapper calls kasan_shadow_initialized()
6. kasan_shadow_initialized() calls static_branch_likely(&kasan_flag_enable=
d)
7. This reads the static key being patched --- this is the potential issue?

The current runtime check is following in tis v3 patch series:

#ifdef CONFIG_ARCH_DEFER_KASAN
...
static __always_inline bool kasan_shadow_initialized(void)
{
        return static_branch_likely(&kasan_flag_enabled);
}
...
#endif

I wonder, if I should add some protection only for KASAN_GENERIC,
where check_region_inline() is called (or for all KASAN modes?):

#ifdef CONFIG_ARCH_DEFER_KASAN
...
static __always_inline bool kasan_shadow_initialized(void)
{
        /* Avoid recursion (?) during static key patching */
        if (static_key_count(&kasan_flag_enabled.key) < 0)
                return false;
        return static_branch_likely(&kasan_flag_enabled);
}
...
#endif

Please suggest where the issue is and if I understood the problem.
I might try to run QEMU on powerpc with KUnits to see if I see any logs.

