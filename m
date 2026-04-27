Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F082FF8867
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=; b=xc9OcBoDdQBAWnVX9BiAU2aGHF
	GnlPgXjdS2DC9ReUK5w8UbxjjQPMJuenmBqbJ1ctEC+aNLsdnJvVvU+cDb7llfIyrsCxSvJ1S65PF
	rNj3h3c7eqRAA3mkw8v0RhJ7JI80JllQLOvhREWBWiDDp2W8Rvs4Lh8CVaCLgW4iMUuzmU2Vzcm3v
	VSzruho+UheQ9zDdTKE8WArc600EGkU8o1szsJ+DHJk0zzIz9Dy+66qgJfyOg+ddKVs3nQGQb8+7v
	J85CipuoRbLWd+pg+wOJjf5fHd1rVUFoDyPoYJ+JMEfLqu8Pde8WDpLL7QJQagVbHPfxXHdXb4/sv
	VReqgiCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTsQ-00000000CeA-2gUZ;
	Mon, 27 Apr 2026 21:52:26 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTsO-00000000CdU-2fTb
	for linux-um@lists.infradead.org;
	Mon, 27 Apr 2026 21:52:25 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b8f9568e074so1772542466b.0
        for <linux-um@lists.infradead.org>; Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326742; x=1777931542; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=BxI31bNCF9d75fv7b1uflJUa7pZphE/H1TuX/7Z/jn7W8aUFZWuk6DTIHBgAglWzz9
         QXTWcv84xRbJKLsnWzX4DcQs3HJLqlLqlA/rZ4STO3t0kALGxSZwZphF+EfDLcaxPhNl
         1ZRAZ8J7Fn5Nu8XqGGM/NuAf1H9vI0AXAIO30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326742; x=1777931542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=r/79rCBq/ocpNpoa/z2sBJQBAwaiv5ZZX4KWaYK7j1Q2n4EeysHF4yl5OVVaDJXdOC
         6ZP4JHw/O5ggZ4rkfOMBIfIq5jEdOtCMoIvbquu7yJxI9vOSonJma1aZFS0Xzu/dMdYd
         O9MN/T9H38dH2h9s7M0/ivOzS/GUSY9FHX3lS8sFJvQQ++nkvXuPU/JIR4y8UCdTXZLA
         s/R2vYxI/xeYE2ShqAiDI/OugmwQGjQCPw8xLew2/CCxYVTCnSbJLjfDk7XAwhZaY+NF
         eg1PNGa9xxQOUl4ChKa+2YBtdFEXR/AW3mSl/O29bvTSAIYoD5de7nOKSMOI2fjZnULv
         Pr+w==
X-Forwarded-Encrypted: i=1; AFNElJ8/MHbh0P6jB/UCOBRAZ3VW+B+vKRhH62xrhU275c1bWOsK0+IX55LSrk92VeXsDBL3u9gIOaSydQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKvAOiOUit4khkaDoiVxm5cfRwaRMhocL06okN9pxoPXjw1EXl
	N8W1lpxgHdI94yADJhZ8+kOUkZaYJI0Y/RYuwgZXQsNnEA4I5mARpEz7IMy0+enU/7PETa8+J6H
	+GQ7CMu+H6Q==
X-Gm-Gg: AeBDievY0pAVGHnGm+QpeRdSdLM0GJCo6KuUQyXGXgch9KS9kmw7J8TwabZ6mEUdCZ8
	F5ip2/3UmygWXZOtjCnm9MBVSDE52gJEHmctXc3zWqNJYn4/iy92Utq5LEOg8+F+WpOHlKZE7eg
	yb/ce/qVX5/IBGCa4HIXJzs4Ysb/nhVUejLbCry9BNv+xSLc+TgsxsACIgSHHviMNlpYdgL+AZb
	N4mpQ0EtFDGxHp4Vm0+Ik8ywKgz7egGW6VeoLUSLRYCOfnwcWCMphWnm1EW7X3HaMDCD4X3e2ob
	WmHNgSkp+TCrcrTXDbvEMeddLPkU6H4c6Nh0Ka/DTi/vTwRmgcbYxICRU6Z12tIub48DCoAgiUL
	WUwEtidZtolTB3BeLING++b+ABbApWJHy+Bl36cPpV+kggqDODY9dhpI1gzFTThg7A8IlMXH6mt
	3havqt7dxZNA8We8uUZ1+mxo5lpp45aoYui5aC2llbYgewsO/dGrYYQAMkxZpxGSZdlFWchpa+6
	UeANM69naA=
X-Received: by 2002:a17:907:9309:b0:ba9:aeaa:fd18 with SMTP id a640c23a62f3a-bb8037781ecmr26505866b.28.1777326742659;
        Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9e4bcsm10045166b.49.2026.04.27.14.52.22
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9392461a12.2
        for <linux-um@lists.infradead.org>; Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8J/cX1v1RqrU7YMTkF7VQ5EDR3hxqzm3S4U8CICrbsuxv3YuyDREn9yJWTnmegOppOW1uzcK6BSg==@lists.infradead.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_145224_694400_183ED7C2 
X-CRM114-Status: GOOD (  10.48  )
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

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

