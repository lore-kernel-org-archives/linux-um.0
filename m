Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7UKr-0006Yu-KX
 for linux-um@lists.infradead.org; Fri, 28 Feb 2020 01:21:02 +0000
Received: by mail-pj1-x1049.google.com with SMTP id w7so752411pjn.1
 for <linux-um@lists.infradead.org>; Thu, 27 Feb 2020 17:21:01 -0800 (PST)
Date: Thu, 27 Feb 2020 17:20:31 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
Subject: [PATCH v3 2/7] arch: um: add linker section for KUnit test suites
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41bd..9a9c97f45694c 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.25.1.481.gfbce0eb801-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

