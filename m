Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g27AP-0005AU-MD
 for linux-um@lists.infradead.org; Tue, 18 Sep 2018 03:59:15 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] samples: disable CONFIG_SAMPLES for UML
Date: Tue, 18 Sep 2018 12:58:33 +0900
Message-Id: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andy Gross <andy.gross@linaro.org>

Some samples require headers installation, so commit 3fca1700c4c3
("kbuild: make samples really depend on headers_install") added
such dependency in the top Makefile.  However, UML fails to build
with CONFIG_SAMPLES=y because UML does not support headers_install.

Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
Reported-by: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index bd133ef..ad1ec701 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -1,5 +1,6 @@
 menuconfig SAMPLES
 	bool "Sample kernel code"
+	depends on !UML
 	help
 	  You can build and test sample kernel code here.
 
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

