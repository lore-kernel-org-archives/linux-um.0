Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82DEE7718B
	for <linux-um@archiver.kernel.org>; Fri, 27 Dec 2024 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVhqgsU2xvF7EXptjIpaUTgDXd0zYOHitWWau0YEx3Y=; b=u5aZQHbY6tEGrbK/JBzOWbjsKy
	nOXuEr4XlWiVQ9SZm0UC7VIWNsZ18NeyfiOBn0avd8TsqlcGmFTZ//IdFS6Dq5mHWd5KGVnNcho91
	yuHuobpyJLcw+xLP3niXx3xyDPYCgGI7MZSqOZBIMn34Ts3fAQ6tVXqSbICA7P9bGyzJ/dYe4MLiz
	n/TnlriI3tDNhWWfuMKxENfjlddPJyODSPTxbY9euBmirboD82ey+pqfOOb9ptCmJxJaXCSlPusXm
	H15iY60d2uYh+nhoUgL86NBdv4M5ZcikHtoDeHCWeyvS3n53JqiFsRhbODDr2yfjpC5WnjjK38uCl
	ZyfmOHEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tR4nS-0000000HGNP-2cP6;
	Fri, 27 Dec 2024 07:30:10 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tR4nQ-0000000HGLs-3g1Y
	for linux-um@lists.infradead.org;
	Fri, 27 Dec 2024 07:30:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5DF8DA4120F;
	Fri, 27 Dec 2024 07:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE3C4CED7;
	Fri, 27 Dec 2024 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284607;
	bh=4TvuKJvEyJTpjYu41+xgE0YbwjdhXodJecvgvQg8Q9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojHOLd1jY+IbJlMWHlQqmy11U2unw6udkZruAXzLiwt6p3tf38LSDBsdZlSGAr5Ti
	 oWt8KIUmukiINpZQ30rlaQW/esY9vKKs3doeOUrzcy8pW5ZYTPFGO0ZI3gJxReLmOn
	 YaQcqvRdKh4p95/gxdtlnhOY0W/KmRAcMm6L8WPojyDC4zVUscK6EE9nVOGL4nLjWR
	 r1cjGnKgKxQGMvk4aIJGohIjP0qxuM3ubVIpYcu1eURVo5rELi+KYU6DKD9THakf4i
	 3tyThFwaKvxwFltVsRKo7mTf+dPkTgS+g+XxaWhLAOBU/pmfaSEwU9bFMm6R9seeLv
	 0fvxg0DCRWzQw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
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
	Mike Rapoport <rppt@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	live-patching@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 8/8] module: drop unused module_writable_address()
Date: Fri, 27 Dec 2024 09:28:25 +0200
Message-ID: <20241227072825.1288491-9-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227072825.1288491-1-rppt@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_233008_983083_694E88C1 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

module_writable_address() is unused and can be removed.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/module.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e9fc9d1fa476..222099bb07cf 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -774,11 +774,6 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
-
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -886,11 +881,6 @@ static inline bool module_is_coming(struct module *mod)
 {
 	return false;
 }
-
-static inline void *module_writable_address(struct module *mod, void *loc)
-{
-	return loc;
-}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
-- 
2.45.2


