Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F6BC02188
	for <linux-um@archiver.kernel.org>; Mon, 27 Jan 2025 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXnX6yfCJ4lo25sKBuf0Jih5OsMg7kJt7yHBT/wi2JQ=; b=M8iBEk27mOGbW3vSrfi1E3aCU/
	NOVPi6WIYlHIdergJaUzAn02yf1QDvRRpqaSE+nwJ6V5mNa3akvGebjsBtetpGJEj/tF5RXTrioRw
	l/L0HHz4Ueg2uDcE3CxGUoAdusmiv2oR3q4PfHGSEPA25qHuEB8V2ESiCAVOLXuQBCykCgDor+zu6
	gloMd59e/4VXCC+lkFLR9LpHpoup8C3zc76SYZJZF5md6yErdVRXOxPwDr4T7+NkccwdfDxQ58Iy2
	6+BFTrRsBrcgHiL6YT0y72Qacp7zTELt7bgfo0boVbisgTBXk7EgQ53ZCWLv8gGvrSw/Yuv5A2M3T
	05zg/nhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRZV-00000002i1u-17Ns;
	Mon, 27 Jan 2025 16:02:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRZT-00000002i1e-2sLq;
	Mon, 27 Jan 2025 16:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SXnX6yfCJ4lo25sKBuf0Jih5OsMg7kJt7yHBT/wi2JQ=; b=an/mRK4icZzCqPPHMN609Ff0wL
	Qs2pgoOW69THhWB5T5gY6nH/4fK6Y72Gx049NYy4Jjyug2T3/ZqGxinuzmLsukap/98K7qe6Bqwy6
	7MFOHakKvuHQ9yFf/ZaTeVhJH7QQNtJt3R+A5YsNVDHyFh2+dFXHFqOqCuLPafjvgw/Ko394Ybr25
	5i168RQSG388+3kPTU4tUR6sth73mFYsatyAk065qko7xleaRiAMsQW6PIOD1KtmnXAMGvNjM/h8P
	qmlTj2NGgL7VPHXjuGCxbahpRIiTN3LvPQJXH47YXPZraFzPsPy0cSXa1hMT4QUnZnKtVWB2tSt2P
	1b8AU+gg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRZN-0000000Eiwv-24hm;
	Mon, 27 Jan 2025 16:02:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 145F93004DE; Mon, 27 Jan 2025 17:02:37 +0100 (CET)
Date: Mon, 27 Jan 2025 17:02:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
	david@redhat.com, jannh@google.com, hughd@google.com,
	willy@infradead.org, yuzhao@google.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
	rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/5] x86: pgtable: unconditionally use tlb_remove_table()
Message-ID: <20250127160236.GJ16742@noisy.programming.kicks-ass.net>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <00bf7935d65826eee547ac195d7854b1c946dbc5.1737637631.git.zhengqi.arch@bytedance.com>
 <20250124113854.GA15996@noisy.programming.kicks-ass.net>
 <45651097-c056-49e3-9cc8-c289c1c0030d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45651097-c056-49e3-9cc8-c289c1c0030d@bytedance.com>
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

On Fri, Jan 24, 2025 at 09:00:58PM +0800, Qi Zheng wrote:
> 
> 
> On 2025/1/24 19:38, Peter Zijlstra wrote:
> > On Thu, Jan 23, 2025 at 09:26:17PM +0800, Qi Zheng wrote:
> > > If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
> > > will fall back to pagetable_dtor() + tlb_remove_page(). So let's use
> > > tlb_remove_table() unconditionally to free page table pages.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > I think we can clean up more :-)
> 
> Yes, but Rik van Riel has already done the same thing in his patch series
> [1], so I was originally planning to wait for his patch to be
> merged into the linux-next branch, and then rebase this series onto his
> patch.

Duh, yeah, I've actually seen those patches and totally forgot he did
that... -ETOOMUCHEMAIL :/

