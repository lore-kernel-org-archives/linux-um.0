Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from imap.cs.msu.ru ([188.44.42.39] helo=mail.cs.msu.ru)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h0qup-0000XB-N2
 for linux-um@lists.infradead.org; Mon, 04 Mar 2019 16:58:38 +0000
From: Arseny Maslennikov <ar@cs.msu.ru>
Date: Mon,  4 Mar 2019 19:57:31 +0300
Message-Id: <20190304165732.24043-3-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-1-ar@cs.msu.ru>
References: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Subject: [PATCH 2/3] Makefile: kselftest: use KCONFIG_CONFIG
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
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d5713e7b1e50..4d8760166a47 100644
--- a/Makefile
+++ b/Makefile
@@ -1199,9 +1199,9 @@ kselftest-clean:
 
 PHONY += kselftest-merge
 kselftest-merge:
-	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
+	$(if $(wildcard $(objtree)/$(KCONFIG_CONFIG)),, $(error No $(KCONFIG_CONFIG) exists, config your kernel first!))
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m $(objtree)/.config \
+		-m $(objtree)/$(KCONFIG_CONFIG) \
 		$(srctree)/tools/testing/selftests/*/config
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

