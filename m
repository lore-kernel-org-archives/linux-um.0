Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from imap.cs.msu.ru ([188.44.42.39] helo=mail.cs.msu.ru)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h0qup-0000X8-NJ
 for linux-um@lists.infradead.org; Mon, 04 Mar 2019 16:58:36 +0000
From: Arseny Maslennikov <ar@cs.msu.ru>
Date: Mon,  4 Mar 2019 19:57:32 +0300
Message-Id: <20190304165732.24043-4-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-1-ar@cs.msu.ru>
References: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Subject: [PATCH 3/3] arch/um/kernel/Makefile: use KCONFIG_CONFIG
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
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2f36d515762e..f5afd186a0ab 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -35,7 +35,7 @@ targets := config.c config.tmp
 # Be careful with the below Sed code - sed is pitfall-rich!
 # We use sed to lower build requirements, for "embedded" builders for instance.
 
-$(obj)/config.tmp: $(objtree)/.config FORCE
+$(obj)/config.tmp: $(objtree)/$(KCONFIG_CONFIG) FORCE
 	$(call if_changed,quote1)
 
 quiet_cmd_quote1 = QUOTE   $@
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

