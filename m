Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D74C02181
	for <linux-um@archiver.kernel.org>; Wed, 22 Jan 2025 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2vVfjEoF0Ie9PHykSVzRRqFF+sOncqHqtvT5+6/DaM=; b=MF1kNEDkHpOEHAyyR75bCKeHZY
	HmVuzebdT7r/0yk3VjPgdAMN0BE6fsR1AAyv5NwakaoVJlkKsndrPKHhwjDOJxZ/6Izm+yvXxgPt7
	mVrXcf+VjB875QySgt2Sa5q84t9EBHi6CV3a73yrUPmtZairUGyCNkwi3GhPbR/yrBZ9ooWkXSi9o
	/2azpg3WPEieyvkUh+b3X2PJyuHM0qAZtc1azpvyG3ePFkY7JsKGXBvzSyCukDMVL3MsIFycp0Px4
	aImyxCSAIpTpI9W6eixTwy07NxuBBhYc9RmrQoHElvt36XofBG2Ul+IIqi0XjEiVmnWzKr+GuvF+S
	/L2IKdEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taXPJ-00000009qPV-3JZL;
	Wed, 22 Jan 2025 09:52:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taXO9-00000009qBn-1YxZ
	for linux-um@bombadil.infradead.org;
	Wed, 22 Jan 2025 09:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R2vVfjEoF0Ie9PHykSVzRRqFF+sOncqHqtvT5+6/DaM=; b=MKnkgi6hXTGhjN0zMurpz8SNpE
	ymCkZhFC61LwgD4TM+uvL9f94W7ieK+NlcINltXhi5P7zaThC8LDbygxQwYvl2vjqUbtLZxhyuCAy
	wG9Z+Ldin3RK5nfuM0GkwyoHYphh4xlIzb3ZwPqDqe/Md1bpCVSc/kEnmcmll20W+wRIsVeKhYXLu
	Icsm6CQIqin5i3mHwdxptDspOvpa/TLyj91bi3vFiZtukWqpolG9eXFgrM5se3DpV3tWyn1O5XwlG
	y7jf8tM3H0Aa42/D8J7lIspHZTlrky+YN4nvimy9DUKwuN39znXE18o2HcEui26BmtlwFsHg8i9X0
	ELdyxdQA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taXO2-000000011ZD-0WUk;
	Wed, 22 Jan 2025 09:51:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46E9A300599; Wed, 22 Jan 2025 10:51:01 +0100 (CET)
Date: Wed, 22 Jan 2025 10:51:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v2 00/10] x86/module: rework ROX cache to avoid writable
 copy
Message-ID: <20250122095101.GK8385@noisy.programming.kicks-ass.net>
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121123646.GC7145@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121123646.GC7145@noisy.programming.kicks-ass.net>
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

On Tue, Jan 21, 2025 at 01:36:47PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 11:57:29AM +0200, Mike Rapoport wrote:
> 
> > Kirill A. Shutemov (1):
> >   x86/mm/pat: restore large ROX pages after fragmentation
> 
> The duplication between pmd and pud collapse is a bit annoying, but so
> be it.
> 
> > Mike Rapoport (Microsoft) (9):
> >   x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
> >   x86/mm/pat: drop duplicate variable in cpa_flush()
> >   execmem: don't remove ROX cache from the direct map
> >   execmem: add API for temporal remapping as RW and restoring ROX afterwards
> >   module: introduce MODULE_STATE_GONE
> >   module: switch to execmem API for remapping as RW and restoring ROX
> >   Revert "x86/module: prepare module loading for ROX allocations of text"
> >   module: drop unused module_writable_address()
> >   x86: re-enable EXECMEM_ROX support
> 
> All these look good on a first reading, let me go build and test the
> various options.

I've tested:

GCC:  ibt=off
      ibt=on
LLVM: ibt-off,cfi=off
      ibt=off,cfi=kcfi
      ibt=on,cfi=off
      ibt=on,cfi=kcfi
      ibt=on,cfi=fineibt

And all of them were able to load a module, so yay!

My plan is to merge these patches into tip/x86/mm once we have -rc1.


