Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586FFC02182
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d2vU3yVbWk+iyIT5+OGlsu0VZIqzMABeI9eBwwMut2I=; b=IlQGGQeaF3PZVSD3smWEnIjesc
	yjHZ70gfeX+L/5gYeLLkXod5XDj99K4sJgCa9g5MCGYhKWq3ZkcqDsyxxUBG6JD/mX/bG+icRsePy
	6/+KZEhLejLVJOUhTcCspmQtVJoSu/A/Q2EhVOwHgAyJ7WbrY5Os+I0jlm6Zog0S8UxSvYzjKFvUS
	xm67Bhmvx5AbSmAcRFWDbsooNlt4O8KtM9AiwJk890HriRtJa501OVv3E6qDBdgll2yDOgZSuW5xP
	+tJyH1EmWtAmpaKJX1QKlObUMuK7HFJw5DsDqFBDmhJ1laLquPgwKxm3Pcsud61xXIdepvpLO59la
	gSNMF5BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taB21-00000007Utx-2q3Z;
	Tue, 21 Jan 2025 09:58:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taB1E-00000007UUN-21Xy
	for linux-um@lists.infradead.org;
	Tue, 21 Jan 2025 09:58:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C10AAA41431;
	Tue, 21 Jan 2025 09:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B91C4CEDF;
	Tue, 21 Jan 2025 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453479;
	bh=Wme3RadWyvhvMdPRne38RcnHRR4tq7D20M16ECVXgvE=;
	h=From:To:Cc:Subject:Date:From;
	b=rh/HlilriYiUfxxSoSn1Dvm4ive39BJjvEcaYkJPYDB4Bq159WaYziRMj9GttPwV4
	 oNJSZE/CM2l9cUTU/sgeYj916s4tKhaxqflrklPGwUoUglcrt8k38IZ3mnKVmfe85Y
	 w1gmDK9AOGg0wGUcs/4/ufhN7/imdYoNgMCLLC4f6HA8JR1YIM/ho6/94/W16wKcUh
	 HqZ3wE417GufCR++pfx67iGYJhxnZ1tnwT6vt2+4pq4r8W3tAcMQ3/lc3PDxJbju9x
	 5DU87NBLb7gkP2FrZ5zr5ekyyUTyizVQkPCFzaKNT9bc5g12mboVzYrIz0bs5KMlAE
	 6HjYs6N1b8mgw==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
	live-patching@vger.kernel.org
Subject: [PATCH v2 00/10] x86/module: rework ROX cache to avoid writable copy
Date: Tue, 21 Jan 2025 11:57:29 +0200
Message-ID: <20250121095739.986006-1-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_015800_637747_77D00556 
X-CRM114-Status: GOOD (  12.83  )
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

To keep the ROX memory mapped with large pages, make set_memory_rox()
capable of restoring large pages (more details are in patch 3).

Since this is really about x86, I believe this should go in via tip tree.

The patches also available in git
https://git.kernel.org/rppt/h/execmem/x86-rox/v9

v2 changes:
* only collapse large mappings in set_memory_rox()
* simplify RW <-> ROX remapping
* don't remove ROX cache pages from the direct map (patch 4)

v1: https://lore.kernel.org/all/20241227072825.1288491-1-rppt@kernel.org

[1] https://lore.kernel.org/all/20241209083818.GK8562@noisy.programming.kicks-ass.net

Kirill A. Shutemov (1):
  x86/mm/pat: restore large ROX pages after fragmentation

Mike Rapoport (Microsoft) (9):
  x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
  x86/mm/pat: drop duplicate variable in cpa_flush()
  execmem: don't remove ROX cache from the direct map
  execmem: add API for temporal remapping as RW and restoring ROX afterwards
  module: introduce MODULE_STATE_GONE
  module: switch to execmem API for remapping as RW and restoring ROX
  Revert "x86/module: prepare module loading for ROX allocations of text"
  module: drop unused module_writable_address()
  x86: re-enable EXECMEM_ROX support

 arch/um/kernel/um_arch.c                      |  11 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vma.c                     |   3 +-
 arch/x86/include/asm/alternative.h            |  14 +-
 arch/x86/include/asm/pgtable_types.h          |   2 +
 arch/x86/kernel/alternative.c                 | 181 ++++++--------
 arch/x86/kernel/ftrace.c                      |  30 ++-
 arch/x86/kernel/module.c                      |  45 ++--
 arch/x86/mm/pat/cpa-test.c                    |   2 +-
 arch/x86/mm/pat/set_memory.c                  | 220 +++++++++++++++++-
 include/linux/execmem.h                       |  31 +++
 include/linux/module.h                        |  22 +-
 include/linux/moduleloader.h                  |   4 -
 include/linux/vm_event_item.h                 |   2 +
 kernel/module/kallsyms.c                      |   8 +-
 kernel/module/kdb.c                           |   2 +-
 kernel/module/main.c                          |  86 ++-----
 kernel/module/procfs.c                        |   2 +-
 kernel/module/strict_rwx.c                    |   9 +-
 kernel/tracepoint.c                           |   2 +
 lib/kunit/test.c                              |   2 +
 mm/execmem.c                                  |  39 ++--
 mm/vmstat.c                                   |   2 +
 samples/livepatch/livepatch-callbacks-demo.c  |   1 +
 .../test_modules/test_klp_callbacks_demo.c    |   1 +
 .../test_modules/test_klp_callbacks_demo2.c   |   1 +
 .../livepatch/test_modules/test_klp_state.c   |   1 +
 .../livepatch/test_modules/test_klp_state2.c  |   1 +
 28 files changed, 442 insertions(+), 283 deletions(-)


base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.45.2


