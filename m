Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC4C282D2
	for <linux-um@archiver.kernel.org>; Tue,  4 Mar 2025 04:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZGZG2B6v8MKwl/nSJ0KoqWQ0hady/U7PdPhgWJxR0Ws=; b=X54KfJOQwPY0Hippj5LqtmdcaC
	+yGIyPS0o7i/Fms3LsmDoNAYI1lBfHqJoCGI93GJEezo/aZk9Ch7F2DzznBrsO3XFxdbittZJSN2a
	Lrqnnkcxy/qxjBKiCoa8HK6n+PzGotJ4hyOi3W+8JJbiWjjknr8kXIbzUxL6nPTXD+xffwsN+TGu2
	tLCODCiMoLQremv2OTJGSAQdZnE8zQZ/vU5NH8po7BgN9kOYNjLFYp95bTMEBLOdShh3Wlriu9N0T
	FQCesDoMwATOatfIh21G/g5PgZgnW7zpmPHvgrEp/yPDUk4zhS16y08iKlJne0qJYwTflk6S+QwmF
	YNvrEx4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpJZs-000000030BJ-2IHt;
	Tue, 04 Mar 2025 04:08:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpJZq-000000030Ad-2NuZ
	for linux-um@lists.infradead.org;
	Tue, 04 Mar 2025 04:08:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A050B5C546A;
	Tue,  4 Mar 2025 04:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E8C4CEE7;
	Tue,  4 Mar 2025 04:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741061297;
	bh=OJc+K+BY2l6V5qT9+IgOwiKvV4q44ADIwUlWFtnBRCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SvBh6xKua0O4rbGl5Th2h893FxX7s75aMSK/CI6eO1DqDbPVeGxH+L5gTK/tJ4vje
	 QLYaFB944eCWG2oj9FNuFYy6/4EahBL+GAxWOzP5wMTbXrh24P5KHR5JL+N97R06cN
	 9W9X6UKdyRcG1D0ubqQLtWnF+VBx6UkJKFwVkdEY=
Date: Mon, 3 Mar 2025 20:08:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/6 update] mm: pgtable: convert some architectures
 to use tlb_remove_ptdesc()
Message-Id: <20250303200815.53007fb79e5049a99f24c999@linux-foundation.org>
In-Reply-To: <c48715aa-8c1f-41bf-92a0-bacf401c2f7c@bytedance.com>
References: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
	<20250303072603.45423-1-zhengqi.arch@bytedance.com>
	<20250303155331.de9b2fff9b04984a255a7bc2@linux-foundation.org>
	<c48715aa-8c1f-41bf-92a0-bacf401c2f7c@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_200818_675571_ED7F89CE 
X-CRM114-Status: GOOD (  17.21  )
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

On Tue, 4 Mar 2025 10:31:07 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> 
> 
> On 3/4/25 7:53 AM, Andrew Morton wrote:
> > On Mon,  3 Mar 2025 15:26:03 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > 
> >> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
> >> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
> >> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
> >> tlb_remove_page()). This is the same as the implementation of
> >> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
> >> convert these architectures to use tlb_remove_ptdesc().
> >>
> > 
> > checkpatch warns.
> > 
> > Do these things have to be macros?  Switching to static inline fixes
> > the unused-arg warning in a nice fashion.
> 
> This can be switched to static inline. In addition, I found that alpha,
> arc, microblaze, parisc, sparc32 and xtensa also have the unused-arg
> issue. Do I need to add a new patch to fix all of them, or just fix the
> newly added 11 warnings?

I guess leave things as they are now.  Switching all these to C
functions can be addressed at a later time?

