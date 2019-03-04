Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from imap.cs.msu.ru ([188.44.42.39] helo=mail.cs.msu.ru)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h0qup-0000Wv-Nb
 for linux-um@lists.infradead.org; Mon, 04 Mar 2019 16:58:37 +0000
From: Arseny Maslennikov <ar@cs.msu.ru>
Date: Mon,  4 Mar 2019 19:57:30 +0300
Message-Id: <20190304165732.24043-2-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-1-ar@cs.msu.ru>
References: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Subject: [PATCH 1/3] kconfig/Makefile: localmodconfig: use KCONFIG_CONFIG
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arseny Maslennikov <ar@cs.msu.ru>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

If the config file is reassigned through the KCONFIG_CONFIG
makeflag/envvar, this rule still attempts to use the wrong, possibly
nonexistent file.
Let's fix that.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/kconfig/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 1c7ac07def4d..28be91964a20 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -44,14 +44,14 @@ build_xconfig: $(obj)/qconf
 
 localyesconfig localmodconfig: $(obj)/conf
 	$(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
-	$(Q)if [ -f .config ]; then 					\
-			cmp -s .tmp.config .config ||			\
-			(mv -f .config .config.old.1;			\
-			 mv -f .tmp.config .config;			\
+	$(Q)if [ -f $(KCONFIG_CONFIG) ]; then 				\
+			cmp -s .tmp.config $(KCONFIG_CONFIG) ||		\
+			(mv -f $(KCONFIG_CONFIG) .tmp.config.old.1;	\
+			 mv -f .tmp.config $(KCONFIG_CONFIG);		\
 			 $< $(silent) --oldconfig $(Kconfig);		\
-			 mv -f .config.old.1 .config.old)		\
+			 mv -f .tmp.config.old.1 $(KCONFIG_CONFIG).old)	\
 	else								\
-			mv -f .tmp.config .config;			\
+			mv -f .tmp.config $(KCONFIG_CONFIG);		\
 			$< $(silent) --oldconfig $(Kconfig);		\
 	fi
 	$(Q)rm -f .tmp.config
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

