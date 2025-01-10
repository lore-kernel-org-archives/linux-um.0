Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B4E7719D
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MmNW7y3eqsd92Gzg8gEtV3OkdUAt4QIGvUyRb4/YY3Y=; b=SbDmFhto6skl2TRtnRvdvqTK9c
	nFsk8QQNf8C6laS4f5wlWQTa5PR/5HUa0t5piajliqM+Swx73PB5ZDQywTpxN7LKbzCtLlwjup4bp
	OlbT6Nqg76+BPLtqVOGRSmTFn7KmPiuR1FLNQYh49SS2/yXOdaBU/3Ncqs2Ve+rTmxRubc4X2r9ec
	8/lHuX+DcP8217SoRp4BXZRCKcq7MHagE3NU0eegxJnK2M8gN3JvDjxFpIpS8isT1A1Hq6LBXIv/Z
	29cwaFeAyXeu/938w5ag9EPhqSnj0Tk9VTXwfV0KoRCrZo1bAayh7Wqj+PG8+KAElaAIQIEPwi9O2
	Li83VOSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWKWl-0000000GjvE-1GH8;
	Fri, 10 Jan 2025 19:18:39 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWKWi-0000000GjtQ-2ZhF
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 19:18:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8EF1EA4292D;
	Fri, 10 Jan 2025 19:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2BDC4CED6;
	Fri, 10 Jan 2025 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736536714;
	bh=2qtn/yN8KGnvKM4Be6ymIMRepfChNk260BsIzmavFNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVSbNBfBgiPxfs3j9J4+Q/Mm+va0HnyJJvJ511BIZPHoPIheFgi517TCooWsbBMUd
	 WSTmKdJWe1UfTSlATsW95ACeJ+2Ll0h4BtuuaSFwVIFk0Wv0zZu3LZGeJRFeQJn0qe
	 lg2p9xQs3O5V2HOaVWmRlOJx02Yzw7s7vpvz4fokLmZ7ey61g0GQZuRvribH6nHyqr
	 xDH3Wpe0L5t74rdpA5UINqI4Hxxsp6lB+b5KVRB/rten4cAybUcKdl/88Oc2pCe2TE
	 6b7kfjQEJbS5HJyWvsAtyyHoKwfXfP3N4KXgVgUwkJm645MDTdxDa3wPAeEVyf6U26
	 meOgl0uiogQDw==
Date: Fri, 10 Jan 2025 11:18:32 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <Z4FyiALKwX-AIWtF@bombadil.infradead.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-4-rppt@kernel.org>
 <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_111836_777400_8B5823A9 
X-CRM114-Status: GOOD (  25.77  )
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

On Fri, Jan 10, 2025 at 12:36:59PM +0200, Kirill A. Shutemov wrote:
> On Fri, Dec 27, 2024 at 09:28:20AM +0200, Mike Rapoport wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Change of attributes of the pages may lead to fragmentation of direct
> > mapping over time and performance degradation as result.
> > 
> > With current code it's one way road: kernel tries to avoid splitting
> > large pages, but it doesn't restore them back even if page attributes
> > got compatible again.
> > 
> > Any change to the mapping may potentially allow to restore large page.
> > 
> > Hook up into cpa_flush() path to check if there's any pages to be
> > recovered in PUD_SIZE range around pages we've just touched.
> > 
> > CPUs don't like[1] to have to have TLB entries of different size for the
> > same memory, but looks like it's okay as long as these entries have
> > matching attributes[2]. Therefore it's critical to flush TLB before any
> > following changes to the mapping.
> > 
> > Note that we already allow for multiple TLB entries of different sizes
> > for the same memory now in split_large_page() path. It's not a new
> > situation.
> > 
> > set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> > not remap such pages as large. Re-use one of software PTE bits to
> > indicate such pages.
> > 
> > [1] See Erratum 383 of AMD Family 10h Processors
> > [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> > 
> > [rppt@kernel.org:
> >  * s/restore/collapse/
> >  * update formatting per peterz
> >  * use 'struct ptdesc' instead of 'struct page' for list of page tables to
> >    be freed
> >  * try to collapse PMD first and if it succeeds move on to PUD as peterz
> >    suggested
> >  * flush TLB twice: for changes done in the original CPA call and after
> >    collapsing of large pages
> > ]
> > 
> > Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> When I originally attempted this, the patch was dropped because of
> performance regressions. Was it addressed somehow?
> 

Also, the statement:

"Change of attributes of the pages may lead to fragmentation of
direct mapping over time and performance degradation as result.  "

Seems to contradict the findings reported at LSFMM by Mike before
that direct map fragmentation does not incur performance penalty,
so I don't see a point in contradicing those findings and confusing
people further.

  Luis

