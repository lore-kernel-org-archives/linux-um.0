Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082F1E77191
	for <linux-um@archiver.kernel.org>; Fri, 27 Dec 2024 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qcorEnshSlUvWUIclIaQ7O5Fp0YwV8Jv7lKKOj/FCyU=; b=cigRt2EfVIhLJqfOA/spetbvPx
	slCulrbTh9t2UJYqGd0l5z5CKgSUh+zWYYjJ7iLwBT61M2cdHsosPi6TKaB3NM92uSItqwB2YMgnN
	WfA8XtTq6tUvToWbegARCS/WUL9L2jbSs6lqJSVGJOqGJxTyimUxvQpdk5gFPsYMS/fqARsCwc2jS
	DEHIbpfwQ2tc5RFW3s5/1iSWX7dgj6Fm9B+Sm4Lkht9g6zX0yj/0NgraZyMRwCP1wYFInoFpnk4+g
	K8vTw6ZMYSTowFE4Ojrx/1xpMftOQ7ED65IsY99P5J8H3qVYVKNmi+CEA+hxNKe118P/NSJm1CnhY
	TuIPx9LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tR4mA-0000000HFc0-0179;
	Fri, 27 Dec 2024 07:28:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tR4m7-0000000HFaH-17cy
	for linux-um@lists.infradead.org;
	Fri, 27 Dec 2024 07:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BC6DCA41191;
	Fri, 27 Dec 2024 07:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BECBC4CED0;
	Fri, 27 Dec 2024 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284525;
	bh=jbs+82vTwYkxQ3EpjI+1yvm0nBPBr9HhcF8xhKMgyb4=;
	h=From:To:Cc:Subject:Date:From;
	b=VWflVN7Vf0mMrePAw/GmezMrZdtva3K3h36HGmBxa/KroU575WF5NJHeh0C6TXNjF
	 qQhJ4X9PGAqzjrUVpQRiVvwIGMd+mISM5MQXFvk45sfhmzlny3nUqVMIbeY6kdii/w
	 zWWKCDoOIlTrr71quUFFRbqLg+DHcfKtQtVHdMmb1lnaMhGLAzyiY7V3autquhweL9
	 gpxz7kV3lQ4EAySR1yDZ2syQZsNyGHLgB/w6HxDmV2RAqrWKXeYkMQOMk5oc3c8Pn5
	 sSBAIqOuQ0ZL0h2iDfLAfuFMjvlnSpx46Mfk1CVcx/gQmlnCTUUVbl2c6KeEM5cwGT
	 y+LUWaqHdI5Jg==
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
Subject: [PATCH 0/8] x86/module: rework ROX cache to avoid writable copy
Date: Fri, 27 Dec 2024 09:28:17 +0200
Message-ID: <20241227072825.1288491-1-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_232847_440951_3E330306 
X-CRM114-Status: GOOD (  11.32  )
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

Hi,

Following Peter's comments [1] these patches rework handling of ROX caches
for module text allocations. 

Instead of using a writable copy that really complicates alternatives
patching, temporarily remap parts of a large ROX page as RW for the time of
module formation and then restore it's ROX protections when the module is
ready.

To keep the ROX memory mapped with large pages, make set_memory code
capable of restoring large pages (more details are in patch 3).

The patches also available in git
https://git.kernel.org/rppt/h/execmem/x86-rox/v8

[1] https://lore.kernel.org/all/20241209083818.GK8562@noisy.programming.kicks-ass.net

Kirill A. Shutemov (1):
  x86/mm/pat: Restore large pages after fragmentation

Mike Rapoport (Microsoft) (7):
  x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
  x86/mm/pat: drop duplicate variable in cpa_flush()
  execmem: add API for temporal remapping as RW and restoring ROX
    afterwards
  module: introduce MODULE_STATE_GONE
  modules: switch to execmem API for remapping as RW and restoring ROX
  Revert "x86/module: prepare module loading for ROX allocations of
    text"
  module: drop unused module_writable_address()

 arch/um/kernel/um_arch.c                      |  11 +-
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/pgtable_types.h          |   2 +
 arch/x86/kernel/alternative.c                 | 181 ++++++---------
 arch/x86/kernel/ftrace.c                      |  30 ++-
 arch/x86/kernel/module.c                      |  45 ++--
 arch/x86/mm/pat/cpa-test.c                    |   2 +-
 arch/x86/mm/pat/set_memory.c                  | 216 +++++++++++++++++-
 include/linux/execmem.h                       |  31 +++
 include/linux/module.h                        |  21 +-
 include/linux/moduleloader.h                  |   4 -
 include/linux/vm_event_item.h                 |   2 +
 kernel/module/kallsyms.c                      |   8 +-
 kernel/module/kdb.c                           |   2 +-
 kernel/module/main.c                          |  86 ++-----
 kernel/module/procfs.c                        |   2 +-
 kernel/module/strict_rwx.c                    |   9 +-
 kernel/tracepoint.c                           |   2 +
 lib/kunit/test.c                              |   2 +
 mm/execmem.c                                  | 118 ++++++++--
 mm/vmstat.c                                   |   2 +
 samples/livepatch/livepatch-callbacks-demo.c  |   1 +
 .../test_modules/test_klp_callbacks_demo.c    |   1 +
 .../test_modules/test_klp_callbacks_demo2.c   |   1 +
 .../livepatch/test_modules/test_klp_state.c   |   1 +
 .../livepatch/test_modules/test_klp_state2.c  |   1 +
 27 files changed, 511 insertions(+), 287 deletions(-)

-- 
2.45.2


