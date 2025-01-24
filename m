Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452B2C0218C
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GsHc0DkyTGM6Cpzq70Lj5XZc9IxktRLAdwDaGEdlVhU=; b=vi7XiddI6ypoFMNXDS9rLBs5aw
	euJ9GEOdgnHUGXjPhrHQFQ1zSmNGQAJMr0/A/Qc4qNdmOfNXS85o27v2RZveIWD4z8O82gxxWguDB
	mcY9JD9xhqyLBbaGAA6vOa6rw9erPTG9BNg8OTA+DQXEFpioUZwxwxemY4kJl8lKoIGiQZkeWa68l
	NeqZ7vSUrEiKX2VaJIAgwPe1c5w91NwgmtciS9tb3IX1bv7t9Zb6OxeNo+7bJ4loijl1z1YxKXNvA
	TXho7fqiWuL+o7XphqjpqQVTWoH0iD8TPTlibWse30eyNR1nrfV6cDhSbyXdQjPziCzpIA75ZH2gG
	xkA2J6BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHX3-0000000EXKQ-1Zfm;
	Fri, 24 Jan 2025 11:07:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHX0-0000000EXI2-2PlS
	for linux-um@lists.infradead.org;
	Fri, 24 Jan 2025 11:07:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CDEFD5C5DE5;
	Fri, 24 Jan 2025 11:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FDC4CED2;
	Fri, 24 Jan 2025 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737716840;
	bh=wSfyHXcmcOSuIJyW+bb7SIJC8asuo8BMjmJ6ZKag59U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8qJYU/pXyq687Cg0zGfUkpXlGffvuM6D0jtxkliKJACp5JlMojm1GDrNE8vwkQHh
	 QhQ6ovm02lHCCSi4Q+bICN5Ri53ztGf22K3e0skaJ4pRVYXnu3siPiddwrn71c1YpM
	 keFYn5AIrov0gSoot4RZ0oOIf/s0nFcQ/mMYx6r53nKF2FyEV8e+apGJAN5yv5UYhI
	 nIw+SIrFrRkO/Gzpy0loesaORzuJhjgA3nl3p1C1IHchkGMB2VNwUZ4rQfDyfRcmKr
	 FqCOto/w0cN/rIRN+Pw1dI1+KtqsXHjMG2qvVSJC18R98+nJwFyTMBLA5ebT7cyqm7
	 eo4aCP4xXm6ZA==
Date: Fri, 24 Jan 2025 13:06:57 +0200
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
Subject: Re: [PATCH v2 06/10] module: introduce MODULE_STATE_GONE
Message-ID: <Z5N0UVLTJrrK8evM@kernel.org>
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
 <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_030722_707206_C87C5B7D 
X-CRM114-Status: GOOD (  30.10  )
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

On Thu, Jan 23, 2025 at 03:16:28PM +0100, Petr Pavlu wrote:
> On 1/21/25 10:57, Mike Rapoport wrote:
> > In order to use execmem's API for temporal remapping of the memory
> > allocated from ROX cache as writable, there is a need to distinguish
> > between the state when the module is being formed and the state when it is
> > deconstructed and freed so that when module_memory_free() is called from
> > error paths during module loading it could restore ROX mappings.
> > 
> > Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> > function module_is_formed() and add a new MODULE_STATE_GONE that will be
> > set when the module is deconstructed and freed.
> 
> I don't fully follow why this case requires a new module state. My
> understanding it that the function load_module() has the necessary
> context that after calling layout_and_allocate(), the updated ROX
> mappings need to be restored. I would then expect the function to be
> appropriately able to unwind this operation in case of an error. It
> could be done by having a helper that walks the mappings and calls
> execmem_restore_rox(), or if you want to keep it in module_memory_free()
> as done in the patch #7 then a flag could be passed down to
> module_deallocate() -> free_mod_mem() -> module_memory_free()?

Initially I wanted to track ROX <-> RW transitions in struct module_memory
so that module_memory_free() could do the right thing depending on memory
state. But that meant either ugly games with const'ness in strict_rwx.c,
an additional helper or a new global module state. The latter seemed the
most elegant to me.
If a new global module state is really that intrusive, I can drop it in
favor a helper that will be called from error handling paths. E.g.
something like the patch below (on top of this series and with this patch
reverted)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 7164cd353a78..4a02503836d7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1268,13 +1268,20 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	return 0;
 }
 
+static void module_memory_restore_rox(struct module *mod)
+{
+	for_class_mod_mem_type(type, text) {
+		struct module_memory *mem = &mod->mem[type];
+
+		if (mem->is_rox)
+			execmem_restore_rox(mem->base, mem->size);
+	}
+}
+
 static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
 	struct module_memory *mem = &mod->mem[type];
 
-	if (mod->state == MODULE_STATE_UNFORMED && mem->is_rox)
-		execmem_restore_rox(mem->base, mem->size);
-
 	execmem_free(mem->base);
 }
 
@@ -2617,6 +2624,7 @@ static int move_module(struct module *mod, struct load_info *info)
 
 	return 0;
 out_err:
+	module_memory_restore_rox(mod);
 	for (t--; t >= 0; t--)
 		module_memory_free(mod, t);
 	if (codetag_section_found)
@@ -3372,6 +3380,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 				       mod->mem[type].size);
 	}
 
+	module_memory_restore_rox(mod);
 	module_deallocate(mod, info);
  free_copy:
 	/*
 
> It is at least good that MODULE_STATE_GONE is only set in free_module()
> past the sysfs teardown, so it never shows in
> /sys/module/<mod>/initstate. Otherwise, this would require teaching kmod
> about this state as well.
> 
> -- 
> Thanks,
> Petr

-- 
Sincerely yours,
Mike.

