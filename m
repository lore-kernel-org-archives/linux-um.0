Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB2FE7719F
	for <linux-um@archiver.kernel.org>; Mon, 13 Jan 2025 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cvtrbhOZ/jnb0cKefuPBu8WDeu540Muca3yRyRrNZtI=; b=MprL/iA79bg1s59zu4wTOO1rRb
	EG78y+bfVpnuMGGPP+v0RiPSZwFGdLL+3FF1r5LTITFJZkMRs0pUW/U2Vgzy8LdISmxZyjkDYHUkH
	seV4G/As2NgWr8Qaa8NHyyfjznOlKpPQQmEOMYIA2TCpcxooMarARtR4Lo06WSI3c6FZN7aVlLGEw
	NrGD8ZQWAAGXK97p1gVdy9q+aHtJhQeMCJSTisHYTcGA5xFFS6H5CzUDRi4z9FxEyNFl5vRvv4gRh
	9gtHvxMUFmwhnCmBmhywSHedn4PQSVzf4BowBi1HzyVFXg/W6md9/FwAJiZRg/OGbFtq6gDalArZI
	YAWGLxlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXFO3-00000004Io8-2iHn;
	Mon, 13 Jan 2025 08:01:27 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXFO1-00000004Imo-2EwH
	for linux-um@lists.infradead.org;
	Mon, 13 Jan 2025 08:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736755286; x=1768291286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQUlUvfhCWekOuCl5QttmQTgLYBws5TIBjoR0vGiG7Q=;
  b=VCKFoq/v1aI55CGoiLQvGy7rIHAoSgbY6VjP08LCjDNAiShpkwP2GPyT
   5IuBw9mvVW9HQera6711B0rZgadw6Gr/oAv/StmTKnh9j6qWqXgNQszSW
   Q1COYXru2e6pVgPDqAqdW7NrMJXZSYlXcKoLJFuK9euJbPdXOVmiuI4s7
   nM9jAZpGkVCC/pN+yG4dPtZdUTAb0Of1RvI5n4hlx1cbLp0tdmQiskm5A
   GyO0GV8+IU2uEHngxCcN1mN6C1CKlbMzNXZIVHmNejqUxp6VGwa2gak9C
   JIqB4siKpwDBwd47l8b7KKPJpeN62BQss/mFSi286RndGqm/mOJZQQEoZ
   w==;
X-CSE-ConnectionGUID: HHC8+BWwSG+b0YET6otdew==
X-CSE-MsgGUID: kXTI1wseQTiV2sfAJ/EmBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37162334"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37162334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:01:25 -0800
X-CSE-ConnectionGUID: errEg64YRjm1IP+ivSWOEA==
X-CSE-MsgGUID: JLLGpe/CSLWefE+dqKfu3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109517553"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 13 Jan 2025 00:01:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4C363331; Mon, 13 Jan 2025 10:01:13 +0200 (EET)
Date: Mon, 13 Jan 2025 10:01:13 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Borislav Petkov <bp@alien8.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Gomez <da.gomez@samsung.com>, 
	Daniel Thompson <danielt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Gow <davidgow@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, 
	Jiri Kosina <jikos@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>, Rae Moar <rmoar@google.com>, 
	Richard Weinberger <richard@nod.at>, Sami Tolvanen <samitolvanen@google.com>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <sivhweds7p5sst2jpxanrj6qc7wlonqkod64nsr5cgttma7ntp@bhqespo3jdqz>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-4-rppt@kernel.org>
 <jut35igb2kstpz24apqdeubv5rvyl3vmp2s43xtivpz54uiedj@wmd2onulv4xw>
 <Z4ODVmnC4fDnIUSN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ODVmnC4fDnIUSN@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_000125_621096_7D10E138 
X-CRM114-Status: GOOD (  29.27  )
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

On Sun, Jan 12, 2025 at 10:54:46AM +0200, Mike Rapoport wrote:
> Hi Kirill,
> 
> On Fri, Jan 10, 2025 at 12:36:59PM +0200, Kirill A. Shutemov wrote:
> > On Fri, Dec 27, 2024 at 09:28:20AM +0200, Mike Rapoport wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > Change of attributes of the pages may lead to fragmentation of direct
> > > mapping over time and performance degradation as result.
> > > 
> > > With current code it's one way road: kernel tries to avoid splitting
> > > large pages, but it doesn't restore them back even if page attributes
> > > got compatible again.
> > > 
> > > Any change to the mapping may potentially allow to restore large page.
> > > 
> > > Hook up into cpa_flush() path to check if there's any pages to be
> > > recovered in PUD_SIZE range around pages we've just touched.
> > > 
> > > CPUs don't like[1] to have to have TLB entries of different size for the
> > > same memory, but looks like it's okay as long as these entries have
> > > matching attributes[2]. Therefore it's critical to flush TLB before any
> > > following changes to the mapping.
> > > 
> > > Note that we already allow for multiple TLB entries of different sizes
> > > for the same memory now in split_large_page() path. It's not a new
> > > situation.
> > > 
> > > set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> > > not remap such pages as large. Re-use one of software PTE bits to
> > > indicate such pages.
> > > 
> > > [1] See Erratum 383 of AMD Family 10h Processors
> > > [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/
> > > 
> > > [rppt@kernel.org:
> > >  * s/restore/collapse/
> > >  * update formatting per peterz
> > >  * use 'struct ptdesc' instead of 'struct page' for list of page tables to
> > >    be freed
> > >  * try to collapse PMD first and if it succeeds move on to PUD as peterz
> > >    suggested
> > >  * flush TLB twice: for changes done in the original CPA call and after
> > >    collapsing of large pages
> > > ]
> > > 
> > > Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> > When I originally attempted this, the patch was dropped because of
> > performance regressions. Was it addressed somehow?
> 
> I didn't realize the patch was dropped because of performance regressions,
> so I didn't address it.
> 
> Do you remember where did the regressions show up?

https://github.com/zen-kernel/zen-kernel/issues/169

My understanding is if userspace somewhat frequently triggers set_memory_*
codepath we will get a performance hit.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

