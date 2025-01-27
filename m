Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B769C0218C
	for <linux-um@archiver.kernel.org>; Mon, 27 Jan 2025 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nxlZG0x9iQaYpsd+eadUudjrFnJ1cGtAfW/gj43tTw=; b=Q6gKsLLWbIkMwaC6Skjysvtuoh
	LRy8uJsBaBtdZkZRu2oVVKnlnAy1vLSABFW2t1YtMTnbcnmf5IDxda5lyIrITgIPTEOxMUwaI0nP2
	o8KqFWi3hdwtim3rY2Nj9Ge7Vk3ohSXTd6JneZq8i/+97+83fJoYWH6IkL1IZvnZPM5tktYP8TTwV
	NcCsasQ/hrzBQPAQO9bh0N8KCjnelYDRUSJlNloqZfFFKPUsHcYRv/Q51Wp+vrYMant+SOiwOF7l6
	ml/fnJIsyLNuX/xsNjcpQMir8i9nJ3gBBWBSRYKNzPxY0KKIVbjZ+bCqjg5vrMZ/0ptEmWJAXNZ/l
	jcxX379Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcNAJ-00000002Crq-2I8H;
	Mon, 27 Jan 2025 11:20:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcN9D-00000002CjP-4977
	for linux-um@bombadil.infradead.org;
	Mon, 27 Jan 2025 11:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2nxlZG0x9iQaYpsd+eadUudjrFnJ1cGtAfW/gj43tTw=; b=Sj0xS/qvr8H41QAKtpZRieE13Y
	aiVj8mHj3pZnEWKoAD3Wd6wuTFDoU6Be22SwXDNWbDzO3IM8T+gXHeZKhWxjNclBx0dQumSMS1C5Z
	V6PP/mamsBhXIVujfX/YgB1kEHLgPt9Ul42gqoJRUMafSAa5MwSWRLYQzlGsbBTTAdV72PxTu0OCk
	sjvgNjd0NtJmzEdGPfPV5twTvfTzqazcPs0SxNXf1kV+BZzGIS9BUgIVAO3P8AKnOWlRTL5HeRnt2
	6XCGhLzKQzQu31s8rh+jHRlsG4MmmtNripWGwIxe3Sb6e6uX4JNIerL4SqMtbLL+escsGkpuLAdEH
	oGUBpIuw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcN96-00000009K2m-3aM4;
	Mon, 27 Jan 2025 11:19:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6EF783004DE; Mon, 27 Jan 2025 12:19:12 +0100 (CET)
Date: Mon, 27 Jan 2025 12:19:12 +0100
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
Subject: Re: [PATCH v3 0/9] x86/module: rework ROX cache to avoid writable
 copy
Message-ID: <20250127111912.GF16742@noisy.programming.kicks-ass.net>
References: <20250126074733.1384926-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126074733.1384926-1-rppt@kernel.org>
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

On Sun, Jan 26, 2025 at 09:47:24AM +0200, Mike Rapoport wrote:
> v3 changes:
> * instead of adding a new module state handle ROX restoration locally in
>   load_module() as Petr suggested

OK, updated the patches I have pending for post -rc1.

