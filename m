Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD96C83F26
	for <linux-um@archiver.kernel.org>; Thu, 24 Jul 2025 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnISyjUKHS3W7xmAqKrJgQOfQ8Pvb6WXuJTpuuSf72U=; b=48ieXSdGt70yFZ4Rt5VWbBwdbT
	h1U6PlE24C3Srw4LI/F2P1LaF2YZzjfki8CQt7sWHbRBhhvCfI3Nv/Uoc07+gPaJAmmEYUCszrE9J
	N21siLzLaX68LI8FR/IJ/TJnzkVxm1R9q8sxmrQaj/yQGwPnK6ThYa3ZzO5vu8WcryVX7PqlgUjvs
	dr8mmqXkcKY0qGkDx3Mpkq4q+M1FMl7sH9x/CAjuZNBoBWk/IhArJEk45XoNQsiZJFua4VHfB+wlP
	thpLFGdsk9CxNqQb71UtBJZBe8tZyBkcSTWw1a9j6dUjjx4+hg1z94P38/QXnskM7mHEKVNJpo2ow
	bPw5fVZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf3O8-00000008Tlu-2AD0;
	Thu, 24 Jul 2025 21:22:04 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf3O7-00000008TlF-0jj3
	for linux-um@lists.infradead.org;
	Thu, 24 Jul 2025 21:22:04 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3137c20213cso1322195a91.3
        for <linux-um@lists.infradead.org>; Thu, 24 Jul 2025 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753392122; x=1753996922; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnISyjUKHS3W7xmAqKrJgQOfQ8Pvb6WXuJTpuuSf72U=;
        b=alkoJS0BvQcG+htHLXaU/V7WcC75MZm6ZXNo0Zv1bW5VA4Q++NdBwQ1ytegwpX5H6A
         LhfBdWEJ9KXuzDYgzEtCTOyc5422dbE2ChTPPY9Se/lAInnt6EqX8WFuEUCV2E/zaqfq
         zuaPeeMb0WzaO+b3PJ00u4w6G0p8ZBolBH2vQDpDYEFhqOLSWpL4t2CpuSwxpwnFbXL6
         yBUEW/MDq+QHlv+HbfkUF6ZwmyyBUpT5GVKCIQc9eZ9RvL/3ifmo8CCutRRWc4v/6o7G
         O93xk51FxSef0WgyLw41Ku8MLMP3jEzvbnTOHE3UT/7RPJefp/ZBef5x+2fuz0ltyu8Z
         vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392122; x=1753996922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnISyjUKHS3W7xmAqKrJgQOfQ8Pvb6WXuJTpuuSf72U=;
        b=HXXv6JN1QjTnSoiW7SQOqFf+64QKnkJL5Un7qK/m+4NEuO/Xm6gvoB+TqCZoEdEJXn
         86HlWxILZf7vifayrAavF6ADv9WBTBbu5oI7HytUh6z1rQ/7XSghzX/dWeVgh4JlHIum
         NDX7fno50eqaeDgcxmkYy62tULoqxisfUZe06oGrUGarB0iuWgumkOAt1zpmvkD9O/At
         3GvXNXmZwctaEb57gul0MUy/efSSe0assTfKr85HHWRpk7zXmJ2iRUR5eAjIjSRAlHA1
         rBkCssdPHxLWT2E2ch5rQjgq9G5uX8SdwPHKx2FNGpGqwhbCTntcJxKqyJeDeu6Vc0H8
         QE0g==
X-Forwarded-Encrypted: i=1; AJvYcCXR4TWuVe2OiL7AGb/gYg9OkgD5gOtm8YPJQ0G93f4LVn8VH4+Gmyi8upFTVu0Vq4X/Sval+T3Nyw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7UqDINxvvbApY3/pu78l1zq3ml6rTds7/0DMnGB6MqNbtVKYP
	hnuUsgPEBt1+TW461n+zxJbcx1Omqd3tMBH/JfDAXne9WwTJT8hGYHMG3Y9auhDL+NaBRPhFA0u
	iAezYcRyuxfYTfWCojVHXbQBQu7ZVCdzXKCbe
X-Gm-Gg: ASbGnctVzk8Qqu1p/nQ9ThELrA65W828D8uY6nPCgVlv08dpuGDwQx6BOV5hxpujpSJ
	BKswUrQdJI0tszJdAsslbJyy7ggV1YsZuwLSbl6xoUv9IzuPAY13x+kD3ZGUOBY+5vG4MvlRnLI
	tQZwHIV6RnAfB2j7urb7X+AaQ5vC0sxcdIvIynjVtMrS3qmz25r81E+5jFGkv8PhwQzhZ+EgMqx
	ZCsZVSng39T0dMwbA==
X-Google-Smtp-Source: AGHT+IFpQvxgR+m3arl/939ve9F0kGDxn4L8HQeFRxceQ3CC6HGVwgsB45ZWPHuC/kvv+NMjlIZfhK5TkB5J/UTpcU8=
X-Received: by 2002:a17:90b:5844:b0:311:c970:c9c0 with SMTP id
 98e67ed59e1d1-31e507b3fd6mr10252588a91.22.1753392122046; Thu, 24 Jul 2025
 14:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250713172536.404809-1-tiwei.bie@linux.dev>
In-Reply-To: <20250713172536.404809-1-tiwei.bie@linux.dev>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 24 Jul 2025 23:21:49 +0200
X-Gm-Features: Ac12FXxwcRqN_TusO_4sUZveHbpN_UuMWgN-cl3T2jaaDF7Z9BUtyD5H2q28XXo
Message-ID: <CAFLxGvxiCzLEYX2yuexgidUZ1fgtF5F988X2Cz4L_7ni1JYKXA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] um: Add SMP support
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, tiwei.btw@antgroup.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_142203_212038_8FFBD789 
X-CRM114-Status: GOOD (  10.20  )
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

On Sun, Jul 13, 2025 at 7:25=E2=80=AFPM Tiwei Bie <tiwei.bie@linux.dev> wro=
te:
> Here are some steps to try out SMP support in UML:
>
> 1. Build UML with CONFIG_SMP=3Dy and, for example, CONFIG_NR_CPUS=3D8.
>
> 2. Launch a UML instance with, for example, 8 virtual CPUs.
>
>  $ ./linux mem=3D16G ncpus=3D8 nohz=3Dn seccomp=3Don init=3D/bin/sh \
>            ubd0=3D$your_rootfs_image

That's pretty cool! The implementation looks *much* simpler than I
have expected.

Can you please explain a little more the details behind it?
e.g. Why ptrace is not supported?
Does it support true SMP (IOW SMP within the kernel)?

I gave it a try on my machine and noticed that the UML process eats a
lot of CPU time
on the host side.
Tracing showed that some (not all) CPU threads perform these syscalls
over and over:
rt_sigprocmask(SIG_UNBLOCK, 0xe081bdf0, NULL, 8) =3D 0
rt_sigprocmask(SIG_BLOCK, 0xe081bdf0, 0xe081be70, 8) =3D 0
timer_gettime(2, 0xe081bdd0)

I'm also a bit surprised that using pthreads works for this.
Traditionally UML uses it's own threading using raw clone(), so I expected
some hassle.

