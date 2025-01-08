Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2584E7719A
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAQ4x0/oizKfpSM1ZOfEKhrwcrgnRVCuoCpheJdwODk=; b=kPzQr2cBqzfw+yJ/4nDQ72LQsr
	xy/do7b6ZVm9KnvPyYt8PJPxXwmQnnmXYc942Cd09rJUZmvLAnZgCFIbuJWG65Un2Ko88Yc47LpwP
	fdydhAHlOetrqsEGtUWbMXKF337bzMhWdh2a6iaMZ8b/R6vFtlERjwUgM3EH8NlnCjhRjROeXiBVk
	FEeLfYNtd8e4Mgiox5Dm1kaA7RW9CsQxJKnBGTzIdM11WgSwFN2MvrLpTKEhtGW4drf9ecE6tsX+9
	fVHNHn6EFbBydo39OgaZKH16cir/RHGS51HCHFqnXGeXImtE+c+ezeJPqUKq86DHvR7U/kXXhzOUP
	MuxdV1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYDy-0000000912R-3UD2;
	Wed, 08 Jan 2025 15:44:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYDw-00000009113-3D3m
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 15:44:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7CC105C53E1;
	Wed,  8 Jan 2025 15:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0593C4CED3;
	Wed,  8 Jan 2025 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351039;
	bh=iAQ4x0/oizKfpSM1ZOfEKhrwcrgnRVCuoCpheJdwODk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPJm0EkhpbVJZIRwKv38+KZr4RI6JAKZRMgSJAUilwa/dgEkob3GpPO+TLNtRiZCT
	 DEWJDBRDzGsOiVUJ+Ljb7+Zn631cx7upT+JgUKWUOxWPdyfc0Rv/VXd92XMheafcRO
	 HwTLae87NP1aV9jSsgjH8i80uyHv2fYQqRxRTS+9d/osRLJHpv7Z+BDIRhOLlXadBp
	 ZyTfw0YbeI9/Tk1NMDXKp+ISKT72FLunUeqjvZM2LA81L2wBEkbl0Wz1SR/Zrf3sG0
	 DbpdPhUNKkmhlmzyHl1UUxz72wsi01z2Ht4x5xPDXSJRrWhFFXhn0nULlTfoL308Ir
	 jxj7j8IS15+bA==
Date: Wed, 8 Jan 2025 15:43:48 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: Re: [PATCH 5/8] module: introduce MODULE_STATE_GONE
Message-ID: <Z36dNC2ROdNsaEyR@aspen.lan>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-6-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227072825.1288491-6-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_074400_844177_FEF64139 
X-CRM114-Status: GOOD (  13.96  )
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

On Fri, Dec 27, 2024 at 09:28:22AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> In order to use execmem's API for temporal remapping of the memory
> allocated from ROX cache as writable, there is a need to distinguish
> between the state when the module is being formed and the state when it is
> deconstructed and freed so that when module_memory_free() is called from
> error paths during module loading it could restore ROX mappings.
>
> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> function module_is_formed() and add a new MODULE_STATE_GONE that will be
> set when the module is deconstructed and freed.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

I've seen the rest of the discussion about this patch... but in case I
forget, and from an extremely myopic kgdb/kdb point of view:
Acked-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

