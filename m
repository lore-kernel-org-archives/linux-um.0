Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC78CE8D6B
	for <linux-um@archiver.kernel.org>; Mon, 17 Nov 2025 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJojd+yHHb22iFQkkceWLmDQfdkENpWFJdPZtgzdX/E=; b=vE6G3pNHbrtfXW7aoSRF5HU3Dy
	y2eI+V/O1kTJmmt8dK3j267stR5Dxk2GwRsMzuUByOJZBX35yovJ3DPCRkdYsDTgWHZemum5MPeys
	+NfGukncBDm0rjkIjaqwFrsSkw107kWrc0mfeYHh1PWClWSatABgiPBGFctHs1twkrATqXPmsqZt1
	jUoBfZFMmZleSM3qkU325XBCmzmsf3hHU82Bk9/wfLN2SD2INhQ2R6MX6ejfQozWdppf70/5BvHxa
	SlnVPBSOEs72D+gYroiW5eZVw9hv1RAKSx01R9wmfyrqpZaSAAzkNvmVlfAot1kDwN3L4mhgBN631
	e2lEraiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKtBQ-0000000FYVe-1XeC;
	Mon, 17 Nov 2025 06:57:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKtBO-0000000FYUq-28yL
	for linux-um@lists.infradead.org;
	Mon, 17 Nov 2025 06:57:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D193433BD
	for <linux-um@lists.infradead.org>; Mon, 17 Nov 2025 06:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7BC19425
	for <linux-um@lists.infradead.org>; Mon, 17 Nov 2025 06:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763362669;
	bh=QFHJjbWXgZ5FLJu59KKPwWK2r2/tZ86nN8Ql1jm9c1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TgEn9zesgIRCkrmyUN3w5JmDr4gYs1GGuRuGQO48gd4V4EjRN6C5Msq0MIsDUo6Rq
	 2T0q2HNtfFmfieLN040ZdcCSB4+kjAMkf3BfT7kLJM0ij0ZRLTTd0t2LhfRgXhvOTX
	 wUcRiqerY+vy9iUWThAl5jGFg4WLdGNLtkeJfhPgcrg7QanuH9wVDDqgpx+sPiuM4B
	 NP1xZcNj6i/hm/oI70m2A8SVfKRtW2hkYh24UkzuvtIqPyIGW1tt5nLb1JnJbnurn2
	 r3gVqYVpX/Xkq0ye5fGg+mH7BgewPI9K2xfGVaCysRYj+fSoLu6K1b2/YWeOqGRcAp
	 b4D8ocqGafeBw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so6313577a12.0
        for <linux-um@lists.infradead.org>; Sun, 16 Nov 2025 22:57:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC+ooFX4vf69erUU83eW7thJHb1p2SAH+kuKFSI06tUMWu6HOLxb22VMOObwL+Q9ITob5RHQHNpg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4RPxg7KGLlDIRfnA8G6tPoiVryXjbYk81RmfUvsuNPOV+KGxW
	dRUHp7WGTeG1/NFdaFBY2MGBgoqHM6ZmI9ENK/W0ul2h412MqABVNtlt//B89Dedcpp/C9LafRB
	QxLLjzmne1vHsSLP2CbbxVEJoDjj9w/E=
X-Google-Smtp-Source: AGHT+IGu0YWlJyZo9sBFqmWx/8Hh3O0yFNJjWzg2iDkfq3nhyb14i7bYZtnnHW6QkMeJqt8H8KA79+YcCaKiwhmN4Fo=
X-Received: by 2002:a17:906:6a08:b0:b72:599:5385 with SMTP id
 a640c23a62f3a-b7367bab9e7mr1170101566b.61.1763362668048; Sun, 16 Nov 2025
 22:57:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
 <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com> <8fbeb3e8-7c30-46f6-a0a4-289efbf45ac0@linux.dev>
In-Reply-To: <8fbeb3e8-7c30-46f6-a0a4-289efbf45ac0@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Nov 2025 14:57:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H73vNhjZqsDq0KGJD_PC2LtM39XAG-aZtvE=tphrQ8dJA@mail.gmail.com>
X-Gm-Features: AWmQ_bmXPoa2u3pjJaGT_1E1BSy8DLhNHegRD0EaZ-4w9eHZIwpki4fOuwGYKs4
Message-ID: <CAAhV-H73vNhjZqsDq0KGJD_PC2LtM39XAG-aZtvE=tphrQ8dJA@mail.gmail.com>
Subject: Re: [PATCH 3/7] loongarch: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org, 
	david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_225750_569286_E3D275FB 
X-CRM114-Status: GOOD (  11.07  )
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

On Mon, Nov 17, 2025 at 2:42=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> Hi Huacai,
>
> On 11/14/25 10:17 PM, Huacai Chen wrote:
> > Hi, Qi Zheng,
>
> [...]
>
> >>
> >> -#define __pmd_free_tlb(tlb, x, addr)   pmd_free((tlb)->mm, x)
> >> +#define __pmd_free_tlb(tlb, x, addr)   \
> >> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
> > I think we can define it in one line.
>
> Do we need to change __pte_free_tlb() to a single-line format
> as well?
Yes, there is no 80 columns limit now.

Huacai

>
> Thanks,
> Qi
>
>
> >>
>
>

