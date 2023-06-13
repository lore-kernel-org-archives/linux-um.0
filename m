Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DDEC77B7A
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TfeRAk5Iga0vezE2eF1M+PCrpPvtSp62FL5nF5oBPvc=; b=GAa4Vgug6FZzJy
	RQL+GzPrNrcm7x6AMOC0dLwDV5tW+J3pr9wRTJY1d0rJMgMvBs+Tby7HKrYNhI7OJJYTrzsPlDO+Q
	8PSoOGtAu88+E66p5ZwkToNncV448p8mrJnN+sfZpBGfYB2iwT5mXt8tAKOXUNTJS+J6TGfDSravn
	Fmy61QGwo64eaBfXykdIoT0v+/Vn9MCN0w++HY5owFI6/mu9Wfe/GPLhW/DIc9yFQROslrogy3TJ2
	XPIAjXFGCwIjwZmN7pPsoScw0kYuv0llgGB/ep67wa36T5/lPlQR/dgElz55GmPWIyz2rWCpZgYpB
	fvq/CKgcjofBvq0WJWFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yhg-007FxD-2i;
	Tue, 13 Jun 2023 07:44:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yhb-007Fux-2V;
	Tue, 13 Jun 2023 07:44:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5069B6132D;
	Tue, 13 Jun 2023 07:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E078FC433D2;
	Tue, 13 Jun 2023 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686642270;
	bh=ez0I+RKRhMdZt82NML91fPb7fzRC4/NkCFA3IdK3cEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyA2VS9kwVTQsYOWOuof1Z4qJ92ct0+rpQ0B5SIAzOL2Mz6wp6NoYwA7DcLYOqzj9
	 Q8Z9RGOQt5lsRA8Nc33tC8G7SiwN9ipBSdD03bBdhpX4MycI3Vh7vOT7ypJVtsouWv
	 8Bsg5dlRSFLhnsq+PWCSJc5VolYLva+SeDgrT92N096TEl0/uLmsJvVPLGz9OK3/dz
	 OYm6tEkeVT/cDyaIgk5UyxE5b/W7hyDcldGwNesOYI9EZOqwD7xGIveZKNt/lp9izm
	 uoBjmwxoGZjGvj7XWF9lQv7iNjjhyG9sIxFni/WcE8h+xW9r48P7ifrawWGz2rEEWN
	 FKciDs53eQHeQ==
Date: Tue, 13 Jun 2023 10:43:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eugene Syromiatnikov <esyr@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	"H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Weijiang Yang <weijiang.yang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	John Allen <john.allen@amd.com>, kcc@google.com, eranian@google.com,
	jamorris@linux.microsoft.com, dethoma@microsoft.com,
	akpm@linux-foundation.org, Andrew.Cooper3@citrix.com,
	christina.schimpe@intel.com, david@redhat.com, debug@rivosinc.com,
	szabolcs.nagy@arm.com, torvalds@linux-foundation.org,
	broonie@kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Message-ID: <20230613074347.GR52412@kernel.org>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_004431_913022_A193AC1D 
X-CRM114-Status: GOOD (  24.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Jun 12, 2023 at 05:10:27PM -0700, Rick Edgecombe wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requires
> some core mm changes to function properly.
> 
> One of these unusual properties is that shadow stack memory is writable,
> but only in limited ways. These limits are applied via a specific PTE
> bit combination. Nevertheless, the memory is writable, and core mm code
> will need to apply the writable permissions in the typical paths that
> call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, so
> that the x86 implementation of it can know whether to create regular
> writable memory or shadow stack memory.

Nit:                            ^ mapping?

> But there are a couple of challenges to this. Modifying the signatures of
> each arch pte_mkwrite() implementation would be error prone because some
> are generated with macros and would need to be re-implemented. Also, some
> pte_mkwrite() callers operate on kernel memory without a VMA.
> 
> So this can be done in a three step process. First pte_mkwrite() can be
> renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
> added that just calls pte_mkwrite_novma(). Next callers without a VMA can
> be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
> can be changed to take/pass a VMA.
> 
> Start the process by renaming pte_mkwrite() to pte_mkwrite_novma() and
> adding the pte_mkwrite() wrapper in linux/pgtable.h. Apply the same
> pattern for pmd_mkwrite(). Since not all archs have a pmd_mkwrite_novma(),
> create a new arch config HAS_HUGE_PAGE that can be used to tell if
> pmd_mkwrite() should be defined. Otherwise in the !HAS_HUGE_PAGE cases the
> compiler would not be able to find pmd_mkwrite_novma().
> 
> No functional change.
> 
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Link: https://lore.kernel.org/lkml/CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com/

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
