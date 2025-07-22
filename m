Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A82C83F26
	for <linux-um@archiver.kernel.org>; Tue, 22 Jul 2025 00:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsXWWPwR7DnfbUiy0T1Ep+dd0MnCyz+JTCzy2sAeeEk=; b=SotdOYsrq+E+xbOFpdWETYGFlo
	ibsZq122wOPUgH34XdxRvmST99n3yCEU2DKqiqvWEj6WVcFt/uFFTWtj23HboxlHCJUv6SS17p7Is
	k4j1VGntVtBYKYFcXqKnr3HDvsd74y/eHnHvlh96Og6PXzvQvSjIBKHmrudBpDQ3/Q6q90WjpZ9I8
	9nWmMw0CbMm/BEMObhHJbJ7GObKE7CXzgIRBHjE0aglvq8Lm5NSWVLl8Ndi6hOyghNbYwrJPDRZ0O
	6HdEb9g+QfSdwiXwnpd77aWM6Uqn4N7Fx0IwxgbrSciua8Lwg4OKBxr8fH/TWeqKZNop9x6k7i1Ps
	Q51SNIOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue0yb-00000000xjA-2X70;
	Tue, 22 Jul 2025 00:35:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue0yY-00000000xi1-1aOZ;
	Tue, 22 Jul 2025 00:35:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B10445E94;
	Tue, 22 Jul 2025 00:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F17C4CEF6;
	Tue, 22 Jul 2025 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753144521;
	bh=AT7biWnsDCxaCvU7U+iSpw4vNS5TBQoe3SiDN0kL4kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=INuAml7aaOfZKzIUxI4Jtp5dIRPXceDiGCMSn/BcpBEsTc1817QQF/mLnLo7zVGvC
	 tbq9rI4BZrhjCeeHWJKHB4TAfP28laWLUpmcWr4W9hiZ6ObpNJJQoYLudeaLJcdFFn
	 UTOfW5v0jeh5cKAcLjqgeLQM4saR33e63KErjkHU=
Date: Mon, 21 Jul 2025 17:35:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
Message-Id: <20250721173520.a24c29782de519dab1c59fec@linux-foundation.org>
In-Reply-To: <a1bc7a9d-817d-49cc-b7f1-79a900090136@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
	<20250717142732.292822-2-snovitoll@gmail.com>
	<20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
	<a1bc7a9d-817d-49cc-b7f1-79a900090136@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_173522_487002_41485EE3 
X-CRM114-Status: GOOD (  14.15  )
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

On Tue, 22 Jul 2025 01:18:52 +0200 Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:

> >> Architectures that need deferred KASAN should select this option.
> >> Architectures that can enable KASAN early will get compile-time
> >> optimizations instead of runtime checks.
> > 
> > Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
> > during -rc6, especially given the lack of formal review and ack tags.
> > 
> > But but but, that's what the mm-new branch is for.  I guess I'll add it
> > to get some additional exposure, but whether I'll advance it into
> > mm-unstable/linux-next for this cycle is unclear.
> > 
> > What do you (and others) think?
> 
> After looking a bit, it breaks UM and probably LoongArch too.
> I'd say it needs more work and not ready even for mm-new.

OK, thanks.  I'll drop the v3 series.

