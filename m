Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKeW5-00B5Tk-RK
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 09:55:45 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 6/6] um: fix CONFIG_GCOV for modules
Date: Fri, 12 Mar 2021 10:55:26 +0100
Message-Id: <20210312104627.54210a33e4c0.I9807ad0ea6ee21a81f86d367f3b61e5f24f8b30b@changeid>
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

At least with current toolchain versions, gcov (as enabled
by CONFIG_GCOV) requires init and exit handlers to run. For
modules, this wasn't done properly, so use the new support
for CONFIG_MODULE_DESTRUCTORS as well as CONFIG_CONSTRUCTORS
to have gcov init and exit called appropriately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig.debug    | 2 ++
 arch/um/kernel/process.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index ca040b4e86e5..74b27b11cb44 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -17,6 +17,8 @@ config GCOV_BASE
 	bool "Enable gcov support (selectively)"
 	depends on DEBUG_INFO
 	depends on !KCOV && !GCOV_KERNEL
+	select CONSTRUCTORS
+	select WANT_MODULE_DESTRUCTORS
 	help
 	  This option allows developers to retrieve coverage data from a UML
 	  session, stored to disk just like with a regular userspace binary,
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index c5011064b5dd..33f895a95ff8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -240,6 +240,8 @@ void do_uml_exitcalls(void)
 	call = &__uml_exitcall_end;
 	while (--call >= &__uml_exitcall_begin)
 		(*call)();
+
+	run_all_module_destructors();
 }
 
 char *uml_strdup(const char *string)
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

