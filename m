Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D718E77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uv4HLJNsimCSXZk5LAECOwBvJVvtg070asVYCzE4+c0=; b=trNb6pggSHp9E2WVf90H5+ue8G
	Q9/GejXSY21kM7TDHVatDlwcbWo97xe2S2kTnMy1dUK4XoEB+IIJ/IAXudIUhYycuHZEGazYIflFp
	9UtFi1evriHmGVVyeKjIG0YZlB6HeVbJTvRcWeHY7fkb2G0vUlu9vB8D/egicDfn0tQQz2H7vsGnI
	mbxFIHzRxqU9+QunROAV93Ja5KxX9BAa2ZkBKC6GN2WAfpSYYUoQJG3C6elcY5k3NafBsmRCnkP8W
	ZP5wV5WJn+UIvLSANP4p1MaAt8BwF5mF6NjRbb9rFl5DF42J7iKLdNXmfxrUISnGDKK/zxyqHA/oU
	TeqWYolg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVU0t-00000008AV5-0HxF;
	Wed, 08 Jan 2025 11:14:15 +0000
Received: from mail-vk1-f180.google.com ([209.85.221.180])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVU03-00000008AJ4-3VMW
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 11:13:24 +0000
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-518954032b2so5366029e0c.0
        for <linux-um@lists.infradead.org>; Wed, 08 Jan 2025 03:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736334801; x=1736939601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv4HLJNsimCSXZk5LAECOwBvJVvtg070asVYCzE4+c0=;
        b=IQKDViyeQQxG+UTUlvkU0cVBIK346ThA0frG0sgdrOkH/L/x4MVlqaPnxRBcmNEvr7
         QZ5X+Oasku/4mZAEB9WIv8t9KL0PTlA+ZS3MWjBuu4FZNNiQvsMMBh8XZObyNsC8Aex9
         V/2mS+Bq2pG1pklYN4VgHe/xC1LYF87fL3iXmvrSAOMUydg2O1qJI6ilkL2H8kMI/eZs
         +UHfJ2KvwumWLEoIxWjnQPBYzXyu2psq8/UG79mDOcwlxyXSnLL3MViyyMcPeFRxGvNG
         RyfUKwLyR+wJVxoJtWKCdQu2LQsa5jFqBoBC07fKMtYJDwTWouuubj/wrHpFrsPtXF3X
         m4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZKCh5nlqn6hUsg42L131QF96jPqtWJ4XjBZoP1/oJZR5p3R+i9da3MokXhLBcyNEqdIFOZxyFCg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzzEQoj6vN+Gba1Vx7cs1EJcWRxe80ucB49atEEpcN/LkQaifhx
	zqb8qm7RP5jIfQs3Gso25OUuaE2aAkTf11uk/34Fq7REPF7kU1kWysLaeebf
X-Gm-Gg: ASbGncsaE6zDEP4fYo30lcqS/uwwGjwYSuIn4iQTNBGnKV2+uZPCLOY3tdQiC50AQw/
	wCTYTv6pMOwYOFyT9WdUMIXJzxCS/Np06JBGNWG5gV4mN21nJmhU+NlNFquYBrGrC32cE24oVnw
	p2jrC2GQ7k8um2V+8VKg0z6JnFq8zWabHFyGoZLuesgikg3f7yXGBGp/zEuwbq7ssGe6e97IgpO
	TLQt5cjVeRWw5/JfGciyvBC9a2x/uuwma2RCZyiRVTiboyuO2VBk/rOQIdGncTStt18LhNKAfWF
	tijgK5azp9OdFn2y4fo=
X-Google-Smtp-Source: AGHT+IGNwyW1Pxj9NkVWeg0r+Lpqbr1D2l4RCc3znr8qRZBaSVI9bF4FCMDhRkobEbjpvLQFagTHpQ==
X-Received: by 2002:a05:6122:926:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-51c6c356692mr1255879e0c.2.1736334801591;
        Wed, 08 Jan 2025 03:13:21 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68b7d1a5sm4863083e0c.1.2025.01.08.03.13.21
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:13:21 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c4c9349b3so3679802241.3
        for <linux-um@lists.infradead.org>; Wed, 08 Jan 2025 03:13:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhO3QRf2kmttz/OtY8Au+COvsi97NfOJlnFhTZO9H8lmlX6Dc5FEhxeeaEBVhTLzCxJWApYucyCg==@lists.infradead.org
X-Received: by 2002:a05:6102:3ca0:b0:4b2:5c4b:5186 with SMTP id
 ada2fe7eead31-4b3d0fe692emr1432724137.23.1736334800971; Wed, 08 Jan 2025
 03:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20250108022404.05e0de1e@crass-HP-ZBook-15-G2> <01be0810b37628a4f8cd6e4b64b68ff7bf9d4ace.camel@sipsolutions.net>
In-Reply-To: <01be0810b37628a4f8cd6e4b64b68ff7bf9d4ace.camel@sipsolutions.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 12:13:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUU-=kVeOzWxZ8A2fFnMCFXdNEc=5Ndbdgb6UrwSzvmog@mail.gmail.com>
X-Gm-Features: AbW1kvZ0CCylT4laGDN2BoD4iuULHRWEu3voQSPpubwBLDvHI_Sau2B1bT417I0
Message-ID: <CAMuHMdUU-=kVeOzWxZ8A2fFnMCFXdNEc=5Ndbdgb6UrwSzvmog@mail.gmail.com>
Subject: Re: close_range is not available on older systems, preventing the
 building of a UML kernel
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: development@efficientek.com, linux-um <linux-um@lists.infradead.org>, 
	Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, 
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_031323_870471_CA0C5DF8 
X-CRM114-Status: GOOD (  32.27  )
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

Hi Benjamin,

On Wed, Jan 8, 2025 at 11:58=E2=80=AFAM Benjamin Berg <benjamin@sipsolution=
s.net> wrote:
> On Wed, 2025-01-08 at 02:24 -0600, Glenn Washburn wrote:
> > I'm wanting to build a UML kernel on Debian bullseye, which is at
> > kernel version 5.10, which does not support close_range(). It appears
> > as though close_range() support is required on the host since commit
> > 32e8eaf263d ("um: use execveat to create userspace MMs"). Was there a
> > conscious decision to break support for kernels less than 5.11, when
> > close_range() was added. What is the policy on support of the host
> > kernel? Since 5.4 is still supported as a longterm release. I think it
> > would be nice to at least support 5.4. Is there any interest in
> > removing this restriction?
> >
> > Also, this system is at glibc 2.31, which does not have execveat()
> > support, which is required by that same commit above. Since execveat()
> > has been supported since 3.19, this kernel should support it. Perhaps
> > the issue can be resolved by defining a syscall wrapper in the UM
> > headers if support is not found in glibc.
>
> Yeah, we need the CLOSE_RANGE_CLOEXEC flag, which was added in 5.11.
>
> On the one hand, there is no real alternative. This is a relatively hot
> path (fork/exec), so I wouldn't want to replace the call with a loop.
>
> On the other, this is "only" an extra safety measure. It is acceptable
> for this to fail (the result is not even checked currently). As such,
> the biggest issue seems to be that your libc does not yet have the
> symbol.
>
> Said differently, we could just replace the call with:
>
> #ifndef CLOSE_RANGE_CLOEXEC
> #define CLOSE_RANGE_CLOEXEC    (1U << 2)
> #endif

Would including include/uapi/linux/close_range.h help?

>   syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);
>
> I am not sure whether we would want to do this in the upstream code.

tools/testing/selftests/bpf/prog_tests/d_path.c does that, too.
But that's not real upstream kernel code...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

