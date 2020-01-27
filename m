Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwABJ-0003ti-Ez
 for linux-um@lists.infradead.org; Mon, 27 Jan 2020 19:36:23 +0000
Received: by mail-pj1-x1049.google.com with SMTP id h2so5472574pji.1
 for <linux-um@lists.infradead.org>; Mon, 27 Jan 2020 11:36:20 -0800 (PST)
Date: Mon, 27 Jan 2020 11:35:48 -0800
In-Reply-To: <20200127193549.187419-1-brendanhiggins@google.com>
Message-Id: <20200127193549.187419-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com>
Subject: [RFC v1 1/2] kbuild: add arch specific dependency for BTF support
From: Brendan Higgins <brendanhiggins@google.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, akpm@linux-foundation.org, changbin.du@intel.com, yamada.masahiro@socionext.com, rdunlap@infradead.org, keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc: Brendan Higgins <brendanhiggins@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, heidifahim@google.com

Some archs (like UM) do not build with CONFIG_DEBUG_INFO_BTF=y, so add
an options for archs to select to opt-in or out of BTF typeinfo support.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/Kconfig.debug | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e4676b992eae9..f5bcb391f1b7d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -238,9 +238,12 @@ config DEBUG_INFO_DWARF4
 	  But it significantly improves the success of resolving
 	  variables in gdb on optimized code.
 
+config ARCH_NO_BTF_TYPEINFO
+	bool
+
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && !ARCH_NO_BTF_TYPEINFO
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
-- 
2.25.0.341.g760bfbb309-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

