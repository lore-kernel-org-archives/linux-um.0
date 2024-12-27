Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2584FE7718B
	for <linux-um@archiver.kernel.org>; Fri, 27 Dec 2024 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhAs81WsdmaB1BC5mVN5DKU+/2vSD1EVP4twaFT9Vd4=; b=eyA+tnnoSfPNeHD9dnE8XtEycz
	dqrXu0uEk0MAtVphZPCTVyK/5kxyw3EMcwxrXJI/R56IEWcETex/gUVK41ic3s1XI7+tieGrXM4NR
	Sh53HgjIWbgkKJHRGuzfiv0zXvG9LwQHCZyE81rgM2V++zjQ2bGd+DUuWThWUxglWGdoaidHZPfyE
	dznqPYxQVkPaqdGa3w9PG8s2wQ8tHPN08tH2DPQ3KyEX/8DtFNjojVDFhpnhjBb9j32kt7iXliLqb
	3dHbPsO/Mr2i8bVhFYp0WJQXOyYTlhaCQNOtmT6wo7sHDOKIO0D7r5VmRVqFN3ku5cffSLPdHhMmb
	3Ba+N1CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tR4mx-0000000HG5c-3lax;
	Fri, 27 Dec 2024 07:29:39 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tR4mv-0000000HG3Z-3V1U
	for linux-um@lists.infradead.org;
	Fri, 27 Dec 2024 07:29:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 40680A411C6;
	Fri, 27 Dec 2024 07:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED23AC4CEDE;
	Fri, 27 Dec 2024 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284576;
	bh=FmTrET8nL2UmyRc6aQAH2J1SgS8cwR3X1MoKmnTcl78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScuKV2kD6qnanPStFqpYQm0FgQDVh0DLb3NJ4mtpO81hTHINYHF0xekTtwDQfutNa
	 5HKFQzwtfQTvNvihXCd5kB4OjdDHB0EgoIFx02GxxN3l+EmLdLZCev+8FpmEu9CC4k
	 eMT9y14Y+PeB1o2Tfc/girl/nvsZSOezNPfNaMWFzyJZUyEKRLnNC7r43j4jRHie3x
	 /okfVqQiHOWC+vCecEU5ddItPuJAZnoPoFpdYKjuRTORzV98ljXX49DwlOe+fDP1f0
	 KYHcHr1ZIK6uxPwndLMeq8O6yIz3Hp7YubMI/Xsj65vbvOwrCzxasJFI+iE6G6/Qwt
	 XiyJ1o1+qm82Q==
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
Subject: [PATCH 5/8] module: introduce MODULE_STATE_GONE
Date: Fri, 27 Dec 2024 09:28:22 +0200
Message-ID: <20241227072825.1288491-6-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227072825.1288491-1-rppt@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_232937_994523_0D0032F7 
X-CRM114-Status: GOOD (  23.69  )
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

In order to use execmem's API for temporal remapping of the memory
allocated from ROX cache as writable, there is a need to distinguish
between the state when the module is being formed and the state when it is
deconstructed and freed so that when module_memory_free() is called from
error paths during module loading it could restore ROX mappings.

Replace open coded checks for MODULE_STATE_UNFORMED with a helper
function module_is_formed() and add a new MODULE_STATE_GONE that will be
set when the module is deconstructed and freed.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/module.h                        |  6 ++++++
 kernel/module/kallsyms.c                      |  8 ++++----
 kernel/module/kdb.c                           |  2 +-
 kernel/module/main.c                          | 19 +++++++++----------
 kernel/module/procfs.c                        |  2 +-
 kernel/tracepoint.c                           |  2 ++
 lib/kunit/test.c                              |  2 ++
 samples/livepatch/livepatch-callbacks-demo.c  |  1 +
 .../test_modules/test_klp_callbacks_demo.c    |  1 +
 .../test_modules/test_klp_callbacks_demo2.c   |  1 +
 .../livepatch/test_modules/test_klp_state.c   |  1 +
 .../livepatch/test_modules/test_klp_state2.c  |  1 +
 12 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 94acbacdcdf1..bd8cf93d32c8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -320,6 +320,7 @@ enum module_state {
 	MODULE_STATE_COMING,	/* Full formed, running module_init. */
 	MODULE_STATE_GOING,	/* Going away. */
 	MODULE_STATE_UNFORMED,	/* Still setting it up. */
+	MODULE_STATE_GONE,	/* Deconstructing and freeing. */
 };
 
 struct mod_tree_node {
@@ -620,6 +621,11 @@ static inline bool module_is_coming(struct module *mod)
         return mod->state == MODULE_STATE_COMING;
 }
 
+static inline bool module_is_formed(struct module *mod)
+{
+	return mod->state < MODULE_STATE_UNFORMED;
+}
+
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index bf65e0c3c86f..daf9a9b3740f 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -361,7 +361,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 
 	preempt_disable();
 	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		if (within_module(addr, mod)) {
 			const char *sym;
@@ -389,7 +389,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	list_for_each_entry_rcu(mod, &modules, list) {
 		struct mod_kallsyms *kallsyms;
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
@@ -441,7 +441,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		unsigned long ret;
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		ret = __find_kallsyms_symbol_value(mod, name);
 		if (ret)
@@ -484,7 +484,7 @@ int module_kallsyms_on_each_symbol(const char *modname,
 	list_for_each_entry(mod, &modules, list) {
 		struct mod_kallsyms *kallsyms;
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 
 		if (modname && strcmp(modname, mod->name))
diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
index 995c32d3698f..14f14700ffc2 100644
--- a/kernel/module/kdb.c
+++ b/kernel/module/kdb.c
@@ -23,7 +23,7 @@ int kdb_lsmod(int argc, const char **argv)
 
 	kdb_printf("Module                  Size  modstruct     Used by\n");
 	list_for_each_entry(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 
 		kdb_printf("%-20s%8u", mod->name, mod->mem[MOD_TEXT].size);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..ad8ef20c120f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL(unregister_module_notifier);
  */
 static inline int strong_try_module_get(struct module *mod)
 {
-	BUG_ON(mod && mod->state == MODULE_STATE_UNFORMED);
+	BUG_ON(mod && !module_is_formed(mod));
 	if (mod && mod->state == MODULE_STATE_COMING)
 		return -EBUSY;
 	if (try_module_get(mod))
@@ -361,7 +361,7 @@ bool find_symbol(struct find_symbol_arg *fsa)
 			  GPL_ONLY },
 		};
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 
 		for (i = 0; i < ARRAY_SIZE(arr); i++)
@@ -386,7 +386,7 @@ struct module *find_module_all(const char *name, size_t len,
 
 	list_for_each_entry_rcu(mod, &modules, list,
 				lockdep_is_held(&module_mutex)) {
-		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
+		if (!even_unformed && !module_is_formed(mod))
 			continue;
 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
 			return mod;
@@ -457,7 +457,7 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 	preempt_disable();
 
 	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		if (!mod->percpu_size)
 			continue;
@@ -1326,7 +1326,7 @@ static void free_module(struct module *mod)
 	 * that noone uses it while it's being deconstructed.
 	 */
 	mutex_lock(&module_mutex);
-	mod->state = MODULE_STATE_UNFORMED;
+	mod->state = MODULE_STATE_GONE;
 	mutex_unlock(&module_mutex);
 
 	/* Arch-specific cleanup. */
@@ -3048,8 +3048,7 @@ static int module_patient_check_exists(const char *name,
 	if (old == NULL)
 		return 0;
 
-	if (old->state == MODULE_STATE_COMING ||
-	    old->state == MODULE_STATE_UNFORMED) {
+	if (old->state == MODULE_STATE_COMING || !module_is_formed(old)) {
 		/* Wait in case it fails to load. */
 		mutex_unlock(&module_mutex);
 		err = wait_event_interruptible(module_wq,
@@ -3608,7 +3607,7 @@ char *module_flags(struct module *mod, char *buf, bool show_state)
 {
 	int bx = 0;
 
-	BUG_ON(mod->state == MODULE_STATE_UNFORMED);
+	BUG_ON(!module_is_formed(mod));
 	if (!mod->taints && !show_state)
 		goto out;
 	if (mod->taints ||
@@ -3702,7 +3701,7 @@ struct module *__module_address(unsigned long addr)
 	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			mod = NULL;
 	}
 	return mod;
@@ -3756,7 +3755,7 @@ void print_modules(void)
 	/* Most callers should already have preempt disabled, but make sure */
 	preempt_disable();
 	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
 	}
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88adb..2c617e6f8bc0 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -79,7 +79,7 @@ static int m_show(struct seq_file *m, void *p)
 	unsigned int size;
 
 	/* We always ignore unformed modules. */
-	if (mod->state == MODULE_STATE_UNFORMED)
+	if (!module_is_formed(mod))
 		return 0;
 
 	size = module_total_size(mod);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1848ce7e2976..e94247afb2c6 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -668,6 +668,8 @@ static int tracepoint_module_notify(struct notifier_block *self,
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;
+	case MODULE_STATE_GONE:
+		break;
 	}
 	return notifier_from_errno(ret);
 }
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 089c832e3cdb..54eaed92a2d3 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -836,6 +836,8 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;
+	case MODULE_STATE_GONE:
+		break;
 	}
 
 	return 0;
diff --git a/samples/livepatch/livepatch-callbacks-demo.c b/samples/livepatch/livepatch-callbacks-demo.c
index 11c3f4357812..324bddaef9a6 100644
--- a/samples/livepatch/livepatch-callbacks-demo.c
+++ b/samples/livepatch/livepatch-callbacks-demo.c
@@ -93,6 +93,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
index 3fd8fe1cd1cc..8435e3254f85 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
@@ -16,6 +16,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573e80af..78c1fff5d977 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -16,6 +16,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 57a4253acb01..bdebf1d24c98 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -18,6 +18,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index c978ea4d5e67..1a55f84a8eb3 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -18,6 +18,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
-- 
2.45.2


