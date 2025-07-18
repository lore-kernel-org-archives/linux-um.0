Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DD4C83F1A
	for <linux-um@archiver.kernel.org>; Fri, 18 Jul 2025 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mE5OlSABnLgWhYl6SAq4PjOG8cGD+M3libfM2kaqTAg=; b=Yam9+gxctj1ssycJGYiCykC2Jl
	gExJR/lmgMFIS5YrBnAHCoH84CKPqKP2rHtqyiJ0MAm6b0NI0Jg3XEAimSHIJHjpuUS+06EGBJMv5
	2zQAxo7shVfz30bH80ggZlBDGOkht1s6NrShw368H4YQlD3xq+6ozbXv7TPwlsyy35QeOwQi3Uo9i
	UnxDaCX+d5oQ75gGdBsaIcikfB0bQ+j45ybYt1T4lYGere3yKio70GEmwfQ4itp7f4n5WqAQNQhSc
	7t65j7O1a9L8mBzRNN7Iidnq+QTiCwS6dAD3wXneZE/II1v4RFBL5MQEt344XBjpUYekTr4vY4Lsr
	3sDGXmyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgBr-0000000BzDz-48rP;
	Fri, 18 Jul 2025 08:11:35 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucg6J-0000000ByE2-42c5;
	Fri, 18 Jul 2025 08:05:53 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-32f1df5703aso14019161fa.3;
        Fri, 18 Jul 2025 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752825950; x=1753430750; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE5OlSABnLgWhYl6SAq4PjOG8cGD+M3libfM2kaqTAg=;
        b=BwcolQ7jtJSgBy4JsRFBMH6ncjbERIoHm8OLkxZqJoONSKlrAMPC7L6nK2VJRfR9FQ
         UvRux2FrkAAfbqjZdv5FJBNBSiz5YNeocFu+yiG/RxeUvApGgwIdjEzFPppHIDOkA9nE
         UwHZVwxsP9IWm47Rt5Eiw2nj0I1MDeruk/vohMtdlK75VLDYZOo7nQ2MebwekXSPL/DX
         6xpcHmIyTZGNNUrVJrcW9VSGubBv9KfttJ0Nv8FS6h0zdxxQo64qaAd8pvCaub0j8b2H
         xc3I4tiJMSfBMnsyH20/SECzvpx6g5l0/WjyVMHQt8kraSh/UNJA5nuefB6VUxuPlQn4
         DVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825950; x=1753430750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE5OlSABnLgWhYl6SAq4PjOG8cGD+M3libfM2kaqTAg=;
        b=CmHgXexbXscSkzZkJxPs7lZ9Ow5eH18Ii0hnMhYuYax/3wwcnllez3LKRzCg19toxe
         yNLC/YIhkuAgHL0KL79mzdLJ8OY8iEmgXuJf4MEbuBgnneffr2dK9mlcUm4BYNjiJV/K
         UewsruNPqRTbSxSIBbUIdF7S2Z9Hjsg5Ca0hwkdAWJf0DXN7O6NOEQb5Dlbzn2+o53Sp
         9KvXmp2rPfwiwl9ZhPEssAGV6KO8M0voDHQ7Yjhic17twdnrQqowC/xIGt6I7V4ICmGv
         iZifTkCQFON1BeIKOCub5usXGsTm0HIWPtGXYbG9hzfuOtQ1qTgCLTqoH7b1AlOjnhYA
         ZiGg==
X-Forwarded-Encrypted: i=1; AJvYcCUz+E5ZwDvXGPFXIiuMPzi9l2UhcwtnSacrkQnV3ATV6B59mfS/NyxPlQ71dglRXkPqT0RfVm0SZpzrvQ==@lists.infradead.org, AJvYcCVXGj6cMOnBpHHCO2CFx8h8GSwIBEk2hI8iOhiJw1WNp55jHIEzM+nygC+c0Q9R81fzea+wiNJmn3I=@lists.infradead.org
X-Gm-Message-State: AOJu0YwURMlScTdxwFD/Di0k89rq7bUExBBM0HRs8bkwWWM3lhlW/xRN
	WC8OPYzARMwkLf06RvB9OEsbEW5giMicHEx7n5GRwdRgItfkNyNmHchqMBqE6vON8AwXCZJL54w
	LHDK06i2yx3vtMnLka4ovPvBfAiGV6cc=
X-Gm-Gg: ASbGncvUugFrnPyFu7s8jX1ZUgVODc4p2KIY14EKXr3KMBMiq5CLr/oQvUnzgm/Lrc6
	ppoQ/Pe0GKdPv33qGbECHOMa/2BlWjU7jIE+SP5ucDYaAyPZ2sliGmIp+ptHUp3tW4fYlEwGBPp
	sbDFTkyqP/6+JEjx43YpkVznlGJc+4ZD5vgpR1NY8gfa8/JOeqcijdjbMapK5OhF8W8oyHd+AmV
	HQEnec=
X-Google-Smtp-Source: AGHT+IHyLMKDBrDr7Srvy/Ikd0HaWMaoK7ylFo11Rc1uD9JBuJ8oBsq1gin5zNroA8IEeJqMbuI/vDPTs3/MNmSKtdw=
X-Received: by 2002:a2e:80d4:0:b0:32b:755e:6cd7 with SMTP id
 38308e7fff4ca-3308e56e179mr28488571fa.32.1752825949700; Fri, 18 Jul 2025
 01:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250717142732.292822-1-snovitoll@gmail.com> <20250717142732.292822-2-snovitoll@gmail.com>
 <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
In-Reply-To: <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Fri, 18 Jul 2025 13:05:32 +0500
X-Gm-Features: Ac12FXz9YqNA1eFVik-g2DCaFm9kQISkxpcsj01QS2Zo6EkvjPY09aiUDIQMxqs
Message-ID: <CACzwLxgyd9yd3ah=LK93Bn7SwAy7H1Hhi=ncFzZYUs+6YGEqvg@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN option
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com, 
	agordeev@linux.ibm.com, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250718_010552_003135_169B93DE 
X-CRM114-Status: GOOD (  18.04  )
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

On Fri, Jul 18, 2025 at 3:10=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 17 Jul 2025 19:27:21 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.=
com> wrote:
>
> > Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> > to defer KASAN initialization until shadow memory is properly set up.
> >
> > Some architectures (like PowerPC with radix MMU) need to set up their
> > shadow memory mappings before KASAN can be safely enabled, while others
> > (like s390, x86, arm) can enable KASAN much earlier or even from the
> > beginning.
> >
> > This option allows us to:
> > 1. Use static keys only where needed (avoiding overhead)
> > 2. Use compile-time constants for arch that don't need runtime checks
> > 3. Maintain optimal performance for both scenarios
> >
> > Architectures that need deferred KASAN should select this option.
> > Architectures that can enable KASAN early will get compile-time
> > optimizations instead of runtime checks.
>
> Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
> during -rc6, especially given the lack of formal review and ack tags.
>
> But but but, that's what the mm-new branch is for.  I guess I'll add it
> to get some additional exposure, but whether I'll advance it into
> mm-unstable/linux-next for this cycle is unclear.
>
> What do you (and others) think?

Thanks for the positive feedback!
Adding it to mm-new for additional exposure would be great.
Given the complexity of this cross-architecture change,
I think of taking the conservative approach of:
1. mm-new branch for exposure and review collection
2. Advancing to mm-unstable/linux-next only after we get proper acks from
    KASAN maintainers/reviewers, at least.

The series has been thoroughly tested by me - compiled all affected arch an=
d
ran QEMU on arm64, x86 with KUnits.

+ Forgot to add in CC Johannes Berg, Peter Zijlstra who commented in v1.
https://lore.kernel.org/all/20250625095224.118679-1-snovitoll@gmail.com/

