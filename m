Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AE9C02182
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+S3XXHbN/oe6xKVYGSf9YZ3CRMWHxj1l3FkfZRty5tI=; b=rMw+50+uKpRApsp0yi9fDrS3B8
	J+/Tmo10QfcJqu+fET41HGgBiMxs0/qzDn433EnbIMpaT42umx2Ilc2kXUsdUnlYbDjBtDZdZ5DJG
	uG6iPmQxrbJzqz9Hm/iowXp8Q2nrODNUUPm+pOkYmksVAfROGkwKBYGTSb8HB+7bSBrZVywb6xOQw
	wOZXCM+AA8gFnlPaod9AWLpKyFl92zZcLgtyKXuPjE80I+HX9i1qGLwudyrr8JwU+bfvy9MP9KHgy
	p4TkHCvrmfYB7tDOwwMJDSnHiMgyBdVWj5iAc4fZtnTRsth5YB5jPzpPhDvYhtFW/GCO5Pscgj/ku
	eYiGtu2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taDV2-00000007sXC-3lcy;
	Tue, 21 Jan 2025 12:36:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taDV2-00000007sWt-2C9j
	for linux-um@bombadil.infradead.org;
	Tue, 21 Jan 2025 12:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+S3XXHbN/oe6xKVYGSf9YZ3CRMWHxj1l3FkfZRty5tI=; b=FiKvPMinu66/G2JHsGRgnMbT5F
	rMCwmED4+IvlnlmUz8ASXQB1GnEDZq3CzcLFTzt/RVSSHIUCEDPvYaR/vpM6O1K7+ZPOaapQJPWi8
	gca1sxhPAW16+uYuk22hj7LI7nu4tDIkzL3A6KLSNh1mj956fKMeGTTg9KGoF+XnjymQh81ulQrlI
	CCL1agCm2m2GbwQWiEo5t3elu50no64PB+45UsbaAodphvLrkDFOhDpfNYqzLzLyJGT+DvKcMFIph
	zBK8tPp+ZXFGNxDquE/xKAwVWlD5DQAw2mJsd7DgAkH4dWm3RWoF9hgpd6mq3Ji/IulJ6M7qZucvU
	ddwVVUjg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taDUu-0000000AbnU-0YO0;
	Tue, 21 Jan 2025 12:36:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BE8E300619; Tue, 21 Jan 2025 13:36:47 +0100 (CET)
Date: Tue, 21 Jan 2025 13:36:46 +0100
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
Message-ID: <20250121123646.GC7145@noisy.programming.kicks-ass.net>
References: <20250121095739.986006-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121095739.986006-1-rppt@kernel.org>
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

On Tue, Jan 21, 2025 at 11:57:29AM +0200, Mike Rapoport wrote:

> Kirill A. Shutemov (1):
>   x86/mm/pat: restore large ROX pages after fragmentation

The duplication between pmd and pud collapse is a bit annoying, but so
be it.

> Mike Rapoport (Microsoft) (9):
>   x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
>   x86/mm/pat: drop duplicate variable in cpa_flush()
>   execmem: don't remove ROX cache from the direct map
>   execmem: add API for temporal remapping as RW and restoring ROX afterwards
>   module: introduce MODULE_STATE_GONE
>   module: switch to execmem API for remapping as RW and restoring ROX
>   Revert "x86/module: prepare module loading for ROX allocations of text"
>   module: drop unused module_writable_address()
>   x86: re-enable EXECMEM_ROX support

All these look good on a first reading, let me go build and test the
various options.

