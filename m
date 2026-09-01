Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F29C624D6
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=; b=r8hAoP9RPT4N2T+oRHlDQ6F0AJ
	3b4sQB0sYPqK/MvAQb+N4JhZ4SmEuNEPKlHfubEL1g2L8iUUWm/nWH1Lc11Fw+qSXVPYLS2J8zN9Q
	JFTMdjbndNJkBr7k0ft5SRZY8aVoerrcA9V29QZEA0emUdNkyd+vHI33D0C3isp1jmMr04oX1QL+z
	hq0rUmjU69sl3Z0T2jbhAwF1Hk6p1mBVw3bPk4DtmowmByHGH9SbHxsIV6aSsOghjWjUlJMjzlUmy
	MKrTnGASG3WVZBqsv7rKP3jV9D8LM6YSHBluRt9w4giw9qi2puCKpt84Fdm7XtqyOmoOydkn7p316
	1hJPcMAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1R0D-0000000CcRS-38tP;
	Tue, 01 Sep 2026 16:06:25 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1R0C-0000000CcPu-0OA0
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 16:06:25 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-92ea24a2dbfso10723085a.0
        for <linux-um@lists.infradead.org>; Tue, 01 Sep 2026 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788278783; x=1788883583; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
        b=Wf8X6PK3g07OlLE2bQd/AtnX5cDADesa+MB3734JxABGFHigFzX44G9Qe9gB0matID
         LJiuXtP0xDi785PAm4YENHxjUDb49Ta+Q5+44/Gzyb3wxhSvolkSZNLKpyc8gWEcuBFH
         /fxnVmMvdnK5bqnWOQA/Mfg73ug+Fj557fa6NF83saa7tOmtGM09KGA/Rkke+jkC1qG4
         d8MH9Sr0FHz9/cUsvZFdm3FleRb6HE6Oa9Yt2ouBmX4iX9rdMI9DHRuhHdJE3pbI5GPN
         Gxknaxt0kyzrmfkfzEccYtBHjYZxhaVviodPxofJ/vNPuB0oyQdAYWG0mKbcfs/oJTWV
         E1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278783; x=1788883583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqCXc1d2wL50duIrdszOJfzq0EqANvFRgXietPv5nSU=;
        b=jvAuI085heTjW1GDeoZiQD81PsWinwNh5qWBS9t1HkHKA5aSoPyej6zZ8sKChkxcqZ
         6qbCC3OfSoVvgOB2or8KioB7czWjR+MIEy3EwZHfK1muvi9ZWnlb5DLQxSTPeXlixj46
         i36UQM5mFT2feRpsSsx0L7Fb5e5citlOJ++FouVHARGmjDEReVU3ypazwR12ZlPUI+RH
         e9rZKOAR36EPXfueUAp/cbzJSfOp+Gv36sFci+kRjGKwdhYdEiUVJ5UGswIYM1RUBuYX
         7yZzdRrJyj2EidDlU6aCauYN8LkfEeImF+19jNW0lRIkYGlp0EnCVd/hEjF/3can7OH6
         FQDA==
X-Forwarded-Encrypted: i=1; AHgh+RrHB3gMHIffiu9N1juXoQR4CTnppV9qZO55yjHPKcu0JA63feZ4Wkr4L0ekolM0XUngENMoZEty0Q==@lists.infradead.org
X-Gm-Message-State: AFuF++kJYbs99NtS5j4NP6FVu6nIb2xUHKbfK5VXo9uB6Mc3Jb2PIjF7
	9NWJXk4prGpBhtVL3dHsZm1XxEetLt30jw9edbeAEWj0Pr65ZIDLlW1L3EueakwhM7A=
X-Gm-Gg: AR+sD12wZ1KeWUb24MxGp/08ay3SUTrZrheBOtG9K4DclLIRQDzO7vXVGF25H1a55Wz
	UJbOiKemXjrTDz/vsWgNiitgVvBF11kXF7fwclzpeJlkwpayv2WH5wCWWnuRwboMXk0u0w7riFL
	MExRbX7mDAbcIfcKu124ZvWK+fgT+cfr9RCMcgE37i6pdQKTx4RjJZ8AY6gsuHgu9KGTwfuerqj
	awkwU4LQnRXx/+sfx739bQZWY6rtNfeP5tRfDw0RlKKz3MbA4QLdtJoLK/pPgm8P5Kb18EldqWd
	j7J1UQ98we2jqxg3aa/tfySQETklh84ZD1mW1UjGkRHj92GdeCMtFxLIhjPvNzN9niOOCZVp86c
	mPNkC01+jXhkKuB5SJQdImpUb9zNASDmgyoS8foVBDaBy3NNTqdCPG+voaNNUMeOSa3nbgoAjsk
	flAejrHJyRoNWz6EwQ3xbqvYHchPotKlZ0oA5t2CI62Ba4TweAaTCm3CQV1rtSfYrhsP/ugZwyx
	L3k2NlgDOe3HfmpLM/n/1/oObYmnM57GJ1BMwQ1JfgWnA==
X-Received: by 2002:a05:620a:21d2:b0:936:ea0d:ffc3 with SMTP id af79cd13be357-939139002d3mr3178331885a.22.1788278777843;
        Tue, 01 Sep 2026 09:06:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93922e5278fsm886283685a.14.2026.09.01.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:06:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1R04-0000000BtB8-1Fgr;
	Tue, 01 Sep 2026 13:06:16 -0300
Date: Tue, 1 Sep 2026 13:06:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Russell King <linux@armlinux.org.uk>,
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <20260901160616.GD56830@ziepe.ca>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
 <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kasi4mkjkt56wxsrmphm5o2qfg2lwsdxf3tlmzx5tq6t7uez74@kozleoavd6r2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_090624_143260_17F2FC2F 
X-CRM114-Status: GOOD (  23.57  )
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

On Tue, Sep 01, 2026 at 11:54:47AM -0400, Liam R. Howlett wrote:
> On 26/09/01 04:28PM, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:41:17PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > >
> > > > > It won't be costly at the time of the calls obviously as its deferred. Maybe
> > > > > increase some time spent in softirq but again is 512x that big of a deal?
> > > > >
> > > > > I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> > > > > either really, certainly not without it becoming extremely messy.
> > > >
> > > > The less costly version is to thread the page to be freed onto the
> > > > mmu_gather through a linked list in the struct page memory. This is
> > > > super cheap since it is just a singly linked list operation.
> > > >
> > > > Then when the mmu_gather is flushed it does a single call_rcu using
> > > > the rcu head of the struct page of the head of the list. The callback
> > > > clears the entire linked list of pages.
> 
> If you are going through the trouble of doing this on your side with a
> custom rcu callback, it might be better to pack the pointers in a way
> that does not need to pointer chase through a linked list.

Well, I have 8 bytes of memory in a struct page and can't allocate in
these paths, so IDK there is another option..

Jason

