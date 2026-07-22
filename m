Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F2C4452D
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wC39mDJmjWAKjIsfem4wgNNJRZ0yjt0+KIFebjtEn9M=; b=yfm1E0lR9bD+wVTlqx65c9FbXS
	Zwb2u+JJR5O3Ee0UiS+FuD5TtJWLrSRYcGwogYiDJPaAfjuAdWvJLrMThcAhRI3yTwsdjlAb1h3YN
	Yblba1m2bJ9cGOl+Of4vK7ESXZs/z/ZwxArbaJof60G2aoIg16lDLmTRnU3l6I6TWpLdauGCJUn7G
	zQq3kSI6eYkm6vI2xCWbwaAUtI9glH9WJ6E5fVBDxC8kzIlrzqG7NUpr4cLFvbT3EYt4nNGbjhZLz
	2+p5V5Toi/HFoSOUDtozJA+dtk9OQgC8kO5CmIvr9xZQh6KfzD61z3AxUlVDTpJ60L9KROfing25s
	IfZ7zJ7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmKzR-0000000Aeja-0S3r;
	Wed, 22 Jul 2026 00:39:13 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmKzP-0000000AejG-0VPd
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 00:39:12 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38dcbade417so10206497a91.1
        for <linux-um@lists.infradead.org>; Tue, 21 Jul 2026 17:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784680750; x=1785285550; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wC39mDJmjWAKjIsfem4wgNNJRZ0yjt0+KIFebjtEn9M=;
        b=nT7GsK5VimqeaaX7Urcrpr8m+dtCwt1bHQsLgEm7LDDVCaw9glzIJ8kO/Ugvzdk2Cf
         jYlsRCNxLMjcfzTKdeKOl/76nX9TyXTByyWqjL0YDPvasQruZdUjV9uT/pJnuClqnBeD
         RQYbk7Q5VL6A2XYJwgjT9srJ37fzay7b2ucfmBXtUDOrPbA34NFPULEhKu6hTpkdt4te
         KjfxS/K866W4d4zRN3ZM67BXlvmZaoTmQlYoKWo+5I5DQ64T+71NNGRDd6TaGO0aAtCJ
         1MGZ2NFkOZVsas2DfzKOuKkcM7/k02MCg4V9cFm6Js83F1DcaO4N8n8CmyIGkhoni9ei
         c+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680750; x=1785285550;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wC39mDJmjWAKjIsfem4wgNNJRZ0yjt0+KIFebjtEn9M=;
        b=bhpkdz20F1LmGtjcSluodEjhsR/BWvLjh8ryU44Z9p16/eAPDubvY/zML0tCaCHjL2
         egkKzgE3SsfOfHWyc88kI9ZopjpslgeKxV/XH4NwTugHqp6CLvkUA7rIa5HMfBKiTh6Y
         WYp3zL8TnZYKs6rE0MbKiARZJLjfOBb+GhBKduf5BzXoCkhyA9koWW5ZFkg9MI5r/Unn
         4wRmHp4qRpyniKAvqnL1MTXo8PMLhp2IcSq/LZHq6+xTmF0TJEg67lI6gHZBFZwGqJb/
         JHJY7738gf2F4mblhW00VXXj4INmLUQLY35Q8QGCIwitlpQInf0xrXo/GC4OEqKgivWl
         chIg==
X-Gm-Message-State: AOJu0YxtoAcdXBjTBmi8Cy1YoD1ZL+px5rGJK44FX5thRtZsBUhw9yri
	Ur9yN8yNG86eYrXPjB4hOb8rZl0w9mxZLiLBN8KbeNgCy8OW7ikRObDUMY9FOA==
X-Gm-Gg: AR+sD12NdeKBbL9agggted1alioJPHsUnYpIH7x0sZKjuqu+cJLu2uohJTuAcj84cwf
	bJvcYjkJxzSN00B+RS960pNdgDBFbHQgpfDQ+rfteQcc8Sn53ydafJwgH+W31j7HFDqnoLADeu3
	pUYZjHhOncbVSzYjW+NEPktFF7GokBqXNBTc2wS1ezqC26zlRsGOIdOS30KTwB6HTcFptfEvNLH
	Xt8SreG3vGney/crtxUjA3z04svfocoyd5qE3sx6gBbe4gc9zrHaYT0BQ4t8646WuLjRfj0QLW8
	rC90ed5DKkFORG6y5r5Z42jbR47IlaZ6Kp920OfaFKpLsTJ1WpH7A4KPRsB2G/LzLFDgGDuW63F
	E+p/ERKNti00QJBEbPFaAh7vhufupF9ze9yzjQ1e3XjcqtxOJXZgTjqzwBe4YKp/YJN7zoKpyI9
	Wc1BLD6i5AKlqv5amIspe3mySZOaHXmso193KcaTDjiLymVsGPGDgszzDWlgVdT2i8jsAB/bg2L
	aDY/yvgw89BaF72F2IFcWA=
X-Received: by 2002:a17:90b:1f88:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-38e4b539d11mr19503995a91.23.1784680749649;
        Tue, 21 Jul 2026 17:39:09 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9208f6bdsm2405306a91.5.2026.07.21.17.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 17:39:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:39:07 +0900
Message-ID: <m28q735044.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org
Subject: Re: [RFC PATCH 0/9] simplified UML/NOMMU approach
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_173911_187961_C8612F81 
X-CRM114-Status: GOOD (  31.51  )
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


Hello,

On Tue, 21 Jul 2026 03:26:50 +0900,
Johannes Berg wrote:

> After Hajime's talk at netdevconf 0x1A I was this time really
> tempted into implementing an approach to NOMMU UML that I'd
> thought about quite a while ago, and here's the resulting
> code. I had prototyped some of this with LLM help, but now
> have pretty much reworked most of it (except boilerplate).
> 
> Instead of using a wholly new architectural interface, new
> process/thread handling, new seccomp machinery etc. this
> just reuses all the existing infrastructure (we're not in
> fact trying to run UML on nommu, but run _as_ nommu), but
> makes runner processes for each CPU instead of each userspace
> MM (as it would be on MMU).
> 
> This eventually results in a far simpler implementation that
> doesn't have all the complexity of the syscall handling yet
> again.
> 
> It's also more capable:
>  - continues working with ptrace
>  - doesn't require disabling SMP
>    (just has a runner per CPU)
>  - should work on 32-bit (untested)
>  - keeps physmem FD, which in theory should allow virtio
>    PCI devices, but PCI doesn't build on !MMU right now

thanks, this is really nice.

I quickly read the patchset and found that [RFC PATCH 8/9] is the core
of your idea, which I agree with your point of simplicity, as well as
the list of compatible features of (the stock version of) UML.

I also understand the need of futex implementation instead of
asm-generic, which only works with !CONFIG_SMP.

I also quickly tested with my local tests (getpid bench, lmbench,
iperf/netperf, and LTP) and all looks fine.  speed measurement is
mostly what I expected.

getpid (nsec)
----------------
  native                  421  
  um			  31983
  um-mmu(seccomp)	  26753
  um-nommu(seccomp)	  3533 
  um-nommu-skas		  27844
  um-nommu-skas(seccomp)  26387
			  

> However, it does go in an entirely different direction
> and while it doesn't entirely close off all things for
> optimisations wrt. syscall speed that the much older
> versions of the NOMMU patchset did, it does create the
> infrastructure in a way that doesn't make that easier.
> 
> Personally, I think the only real use case for this
> whole thing is NOMMU testing (which was requested), and
> we don't really need everything else.
> 
> Note: the futex thing seems odd. I mirrored the existing
> implementation, but I think it's just wrong. There's a
> FIXME in the code for now.
> 
> It does boot ghcr.io/thehajime/alpine:3.20.3-um-nommu
> as was documented before.


What is your plan for this RFC ?

I'm pretty fine with this (skas nommu) mode for nommu UML; it
is certainly useful to detect more bugs if it is available in UML.

I would also like to ask maintainers if my nommu approach can be an
opt-in feature only when specific kernel config is added, probably
marking as '(EXPERIMENTAL)' or `if EXPERT` condition, as there is
potential benefits (speed, less host process use, etc.).

But if you (maintainers) wish and feel this as not an easy option,
I can work for it with later patches as an extension.

btw, maybe I need a better name for (my) nommu code using different
syscall handling, with regard to skas (i.e., separate kernel address
space) mode (e.g., CONFIG_UML_NOMMU_SAS (single address space) etc.).

-- Hajime


