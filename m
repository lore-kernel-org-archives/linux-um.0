Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EFBE77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 11:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+e20JDJu3VwrmlmlVVpxrvFlU6CuxSxftw52pQXGnog=; b=fWUSTg/gYlnMY3XmaLf5A5whoP
	k0zN+89IxCPPSqJLlCRPowUszA3p6Csa+n93PcAVUNwRqnJxaWRN6TyRGpMbVqDaU1ZTnNHHn35P/
	346dhqJiulbu1mZWrKoefcrM1r2bMwPvfn1kJE4YmdEO1Xxfv67nlVlAsUobK0uNcbJyzkXWdNT6f
	KEpxHM9N92JUIdW9q1CsELXn6WpRvNo43q4OLmQuA0lCbAS4c+gO9WVV7dyRZGJm/q+3XPHaqPYmo
	C4fyQz0alGNjqC9efh2BmXFjIV27xfyYFhTQrjkyX1LHTYNjQJPK7cFQs+UcENjy0vNAuB+EoI3pW
	dvoarcXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfnc-0000000CpR8-2LoM;
	Fri, 03 Jan 2025 11:25:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfip-0000000CokT-3ctV
	for linux-um@bombadil.infradead.org;
	Fri, 03 Jan 2025 11:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+e20JDJu3VwrmlmlVVpxrvFlU6CuxSxftw52pQXGnog=; b=DaRgJ6ZeouUFnjZ11up8spR4oW
	o3qngr9xYj85lxVEWvhjfekmFNWYSpBpnDXfgrnmBcXz21BVnbWSjwF7FJpVqC3515Zz7xoNghOSN
	DH+Y2PmIRLQ12UwBno8GZvcaEK1tyJyBcOeuOEqZZDyo61EUcCWq7+pFRb99cLZH0ChNWFaY8ue4g
	z8w5w37xbByYWZ1U79CbSnvZ1WHPtTWr6jtlQX4rjTXRfc9uIqBUMMP6yizCWyO7qbPQ54fvQbCrO
	XqWipiJzxMZluWZYjJQzRjkUSapDbZoOBeoCu74phuj0VrMCuywG6Sfo3qD6+BsfXkShHAV3onqo/
	yYIJfPJw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfih-00000008NOv-2fvw;
	Fri, 03 Jan 2025 11:19:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A6C93003AF; Fri,  3 Jan 2025 12:19:59 +0100 (CET)
Date: Fri, 3 Jan 2025 12:19:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	live-patching@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/8] x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
Message-ID: <20250103111959.GD22934@noisy.programming.kicks-ass.net>
References: <20241227072825.1288491-1-rppt@kernel.org>
 <20241227072825.1288491-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227072825.1288491-2-rppt@kernel.org>
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

On Fri, Dec 27, 2024 at 09:28:18AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The CPA_ARRAY test always uses len[1] as numpages argument to
> change_page_attr_set() although the addresses array is different each
> iteration of the test loop.
> 
> Replace len[1] with len[i] to have numpages matching the addresses array.

D'oh..

