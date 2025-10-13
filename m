Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44680CCD183
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nByoAi13Ef5gTkHhIxkIOpZEtyksfBMXQWVuUX54muQ=; b=qOR0EfD8gkvN1DcM9HgiZBbND4
	59VHl/b/DVesIdCZXZoTcnFFc1EKXe/lFeMFtHLX8+KpCKds4h4tRHL+CQri9QBMtmTR5TfSNSSYI
	OSwmdgpvamuhWs+ipHjLFuuOaFT1KfPoan0XjvgJLswecgAtViF5j/DEgr/QS4Bbp6ZaoNS/R0RYF
	B0VF2MBb2vJVDQkWtGKVtB7/rOQ3XLPeFauqB8schVbUCUozafxUc9ZxvkNTiEFr0uCrkzuotJYbE
	rS88NUFevoJ3D05/rS7/++Dbf0Iw0Jdpnj7fHrBQriNBi2gFUii43WMVOReB9mUICcNvjsx/05vso
	GSL+tpCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8M8g-0000000E0NA-1rXu;
	Mon, 13 Oct 2025 17:15:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8M8f-0000000E0MT-1Pu0
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 17:15:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AADAD620D4
	for <linux-um@lists.infradead.org>; Mon, 13 Oct 2025 17:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5384FC19425
	for <linux-um@lists.infradead.org>; Mon, 13 Oct 2025 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760375712;
	bh=qg3NRHdeNA4Fg5h3g9E13z1ZmJaUuUt4rsIs+bfAZf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nInNi8ldgd1mbqOSNYEn0pvWDU/WshfNHypWq71z7uedvu9QnRfeqGNexbgxkQWls
	 f2uSbfqG61R0A7mseEzZHj5XzQdF4CKWpU8WYjlz7LGv0ZD7jEV1HjvOJDz4QmW1nv
	 7xejInsLO+AwE5lGA5DuIDUXa905yRbcZf8QTe1rCeC1iR7E3MOR2rj1iOyyl3h8E6
	 q56Yj6mpnz4vm1ikUfWkH3B45H06p59zFUjdS/IoBGKAA45YFyC3iXzYEXNxkboYJQ
	 /XsOeh2UIs5o+N21V8eMOivhe2kaee1fG903o6NTrx/vhqLEntGtDyLt+O6Iy1bxTH
	 r5nBrhzJ5zA4w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e36125e8aso918586e87.2
        for <linux-um@lists.infradead.org>; Mon, 13 Oct 2025 10:15:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHmVVPknX8cPh+GQmFkX5z3YYNHAW4ILtdCdNQRprX58rYLeLajSBAdK0MJNgSu4UCOU4ReLibmA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDP5+NcaGKl0IPkaJ5vHWA8H1OE/Nwx69IBdHKp5JQbZoYO/TC
	vLGbuQ4/HrkDvPeK45Fxo0I3Aj4JsogmRzTrkDq8j6hB6DVabAjha2d7yZOsb146SIwTB0++bEE
	qGtOI+CfK3skOJNQuRQk8ALAvO5EMex2NVpLky7j6
X-Google-Smtp-Source: AGHT+IFe+SzxnNHmLcFlvnfkJvIZjwnZkm1Ok6JvoMYuj8nhVWXCmwvh0KaZdzeEUyoNuxcssWgKIbqhAnjyljsSJMw=
X-Received: by 2002:a05:6512:230c:b0:573:68fd:7ad2 with SMTP id
 2adb3069b0e04-5906dd53da9mr5881107e87.35.1760375710222; Mon, 13 Oct 2025
 10:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de> <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
In-Reply-To: <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Oct 2025 10:14:58 -0700
X-Gmail-Original-Message-ID: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
X-Gm-Features: AS18NWDGlHiZ6TxV2AYIYIygvwnW3vlieR2fC4dbq7adbnnZ1RUCMMYySi05JAY
Message-ID: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 13, 2025 at 7:07=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/13/25 02:20, Thomas Wei=C3=9Fschuh wrote:
> > -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused);
> > -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused)
> > +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)=
;
> > +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
> >  {
> >       int cpu_id;
>
> It would ideally be nice to have a _bit_ more history on this about
> how it became unused any why there is such high confidence that
> userspace never tries to use it.

The theory is that people thought that getcpu was going to be kind of
slow, so userspace would allocate a little cache (IIRC per-thread) and
pass it in, and the vDSO would do, well, something clever to return
the right value.  The something clever was probably based on the idea
that you can't actually tell (in general) if the return value from
getcpu is stale, since you might well get migrated right as the
function returns anyway, so the cache could be something silly like
(jiffies, cpu).

I don't actually remember whether the kernel ever used this.  It's
possible that there are ancient kernels where passing a wild, non-null
pointer would blow up.  But it's certainly safe to pass null, and it's
certainly safe for the kernel to ignore the parameter.

--Andy

>
> Let's say someone comes along in a few years and wants to use this
> 'unused' parameter. Could they?
>

