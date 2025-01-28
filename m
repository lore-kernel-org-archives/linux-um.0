Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80197C02191
	for <linux-um@archiver.kernel.org>; Tue, 28 Jan 2025 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QP7XxJ6Qr0/ecZq8j3OAaCKlA5Lvhwlpzy7j9900yC0=; b=0lnOKvA7mO+WzV4xF/t3ynfzJ4
	jMrE6kk7wv3kf5X7hWXy7UN29EQRE/elEeOExXs+iQs+pe26Y2nhsUlSsv0nBeUbd2sMXlLrfV6uU
	9VMuWXX4BZDAOyNisYt7hHKufqBa29NevFy5cGWhmJ8/LhOeo9SkEJsv+go6bOZG6TtlIAg0Y/xX6
	JvLDwfLxWMmnP+K5mUkCvqqcxFN6FHknd3fcdbLd9tfGu/8785d1qCXk4Czh5pYOzk/cyB9xM9SaF
	YahnIrr/zzXv1UH0HgJzPsAEHSCCOACJdX+0Y17SFZDDpnLw4bvNKJIyy6ueh+jw2HG5kPH0N3LgQ
	yMdTUTtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tciPK-00000004bBj-0NXu;
	Tue, 28 Jan 2025 10:01:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tciPH-00000004b9q-3y2I
	for linux-um@lists.infradead.org;
	Tue, 28 Jan 2025 10:01:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C79005C4786;
	Tue, 28 Jan 2025 10:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0C8C4CED3;
	Tue, 28 Jan 2025 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738058478;
	bh=H+G3TtSN5z2rPg9q7jaqw3zaBc0K+irN0EUiSSVdGVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bx7V38SoAhETd9sc3qxV33PkV4fbZ9U+nWfMSuyj7aAE4t36vZLBolyqeF4nbGBta
	 XbN1Q+pDjEpEFtKJHmktZXdqMYusjeXUsBpMTU7b6k5chsugMb3GDVaN7OIdra9mNc
	 LgS+jr+iGKrULxB2qPNZHewWubD6EIpyvgyZNsdxQFtO0jyXH5V+jnnZUMM6ltJCFZ
	 S0bl1WgjGqJhnkUL6gVfjpKxam708lIRTpj76NinsW/OGobdYd4Lb21/LvZ8ubl/cT
	 FoOzOIdBgb8magf0NcV37KSZIgUUV04fADb6slWXhE+UMBFk+i/daHvsFfa4nWGW8m
	 oHJUjwuGUTj7g==
Date: Tue, 28 Jan 2025 12:00:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
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
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 6/9] module: switch to execmem API for remapping as RW
 and restoring ROX
Message-ID: <Z5iq2GJKIdlB9APM@kernel.org>
References: <20250126074733.1384926-1-rppt@kernel.org>
 <20250126074733.1384926-7-rppt@kernel.org>
 <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_020120_066961_AA275427 
X-CRM114-Status: GOOD (  19.98  )
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

On Mon, Jan 27, 2025 at 01:50:31PM +0100, Petr Pavlu wrote:
> On 1/26/25 08:47, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Instead of using writable copy for module text sections, temporarily remap
> > the memory allocated from execmem's ROX cache as writable and restore its
> > ROX permissions after the module is formed.
> > 
> > This will allow removing nasty games with writable copy in alternatives
> > patching on x86.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> [...]
> 
> > +static void module_memory_restore_rox(struct module *mod)
> > +{
> > +	for_class_mod_mem_type(type, text) {
> > +		struct module_memory *mem = &mod->mem[type];
> > +
> > +		if (mem->is_rox)
> > +			execmem_restore_rox(mem->base, mem->size);
> > +	}
> > +}
> > +
> 
> Can the execmem_restore_rox() call here fail? I realize that there isn't
> much that the module loader can do if that happens, but should it be
> perhaps logged as a warning?

It won't fail at this point. set_memory APIs may fail if they need to split
a large page and could not allocate a new page table, but here all the
splits were already done at module_memory_alloc() time.
 
> -- 
> Thanks,
> Petr

-- 
Sincerely yours,
Mike.

