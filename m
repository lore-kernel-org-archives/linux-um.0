Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEC0CAC59B
	for <linux-um@archiver.kernel.org>; Tue, 16 Sep 2025 03:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AoUtYaSqpxJxvLloy7nshr4G6vpZl850tw+AAmUwDdk=; b=4r+gg6DIrr6U4/tJLMDFrVwGnz
	2Je2Q0/91HFq48U61y1gmlXmhIWCmpiSIyvf8GvRIFs1rQyrqhu7qCVHBmS+vW4rgyRokmV+sf3zQ
	t30a+Kjqcbc2K1NNNbBZTXbA23sFdKdFqIN0LLU59/xc/ShD9D1OZbO6jjDhybDdYqSQ9Y8Wb3zCs
	wvZM9c2SBcrJB5ZvxHAIPQRsUxTWUxeENsLYKG2lDSOQMQQ5TcuO/b4zObHEfHmDYlPrsiHdslRfz
	tGja6cC3dOA5IHKhvEgiL3+IK2Ci1ntGdiQWEDVBkV6ftosy5R52/UTRyy6pj2WYGixZSWPxTf9wM
	mnTpDBOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyMV1-00000006bf0-2aKj;
	Tue, 16 Sep 2025 03:36:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyMUx-00000006be4-1kPO;
	Tue, 16 Sep 2025 03:36:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C7F3040716;
	Tue, 16 Sep 2025 03:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04DAC4CEEB;
	Tue, 16 Sep 2025 03:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757993814;
	bh=CfVil0FdRSS0PaXQXnEL2MuMd3+XojlUadD8GRWQi7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CNf7AHxNVzyFResUYW5usorS95/1cgWEfQBxIXzVgEh5LcEryf/UaE9d6FXnmevp/
	 hUOvt/SIiD7/Xfzhk6DVSSkzymHadep7a/+dLaY5Vb+n0WLbUQmf5rY9iYjBaJbYhP
	 EK//AR137efTrjN+qYgc2VP+Ya6Cv8E6hGsRI3+Y=
Date: Mon, 15 Sep 2025 20:36:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, ryabinin.a.a@gmail.com,
 christophe.leroy@csgroup.eu, bhe@redhat.com, hca@linux.ibm.com,
 zhangqing@loongson.cn, chenhuacai@loongson.cn, davidgow@google.com,
 glider@google.com, dvyukov@google.com, alexghiti@rivosinc.com,
 alex@ghiti.fr, agordeev@linux.ibm.com, vincenzo.frascino@arm.com,
 elver@google.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify
 static key across modes
Message-Id: <20250915203653.c17d501a5f4b68936a0e3ea9@linux-foundation.org>
In-Reply-To: <CACzwLxh4pJOBbU2fHKCPWkHHCuLtDW-rh52788u2Q6+nG-+bTA@mail.gmail.com>
References: <20250810125746.1105476-1-snovitoll@gmail.com>
	<20250810125746.1105476-2-snovitoll@gmail.com>
	<CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com>
	<CACzwLxh4pJOBbU2fHKCPWkHHCuLtDW-rh52788u2Q6+nG-+bTA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_203655_472941_E9A98182 
X-CRM114-Status: GOOD (  15.21  )
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

On Mon, 15 Sep 2025 09:30:03 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:

> On Wed, Sep 3, 2025 at 6:01 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>

[400+ lines removed - people, please have mercy]

>
> > > @@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
> > >  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> > >                                 unsigned long ip)
> > >  {
> > > -       if (!kasan_arch_is_ready() || is_kfence_address(object))
> > > +       if (is_kfence_address(object))
> > >                 return false;
> >
> > Why is the check removed here and in some other places below? This
> > need to be explained in the commit message.
> 
> kasan_arch_is_ready which was unified with kasan_enabled, was removed
> here because
> __kasan_slab_pre_free is called from include/linux/kasan.h [1] where
> there's already kasan_enabled() check.
> 
> [1] https://elixir.bootlin.com/linux/v6.16.7/source/include/linux/kasan.h#L198
> 
> Please let me know if v7 is required with the change in the git commit
> message only.

Neither works - please send along the appropriate paragraph and I'll
paste it in, can't get easier than that.

> >
>
> [another ~250 lines snipped]
>

