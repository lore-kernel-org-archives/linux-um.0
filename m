Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlj6H-0001sd-0z
 for linux-um@lists.infradead.org; Thu, 18 Jun 2020 01:12:18 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 191/388] um: do not evaluate compiler's library
 path when cleaning
Date: Wed, 17 Jun 2020 21:04:48 -0400
Message-Id: <20200618010805.600873-191-sashal@kernel.org>
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, linux-um@lists.infradead.org, Nathan Chancellor <natechancellor@gmail.com>

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 7e49afc03212010d0ee27532a75cfeb0125bd868 ]

Since commit a83e4ca26af8 ("kbuild: remove cc-option switch from
-Wframe-larger-than="), 'make ARCH=um clean' emits an error message
as follows:

  $ make ARCH=um clean
  gcc: error: missing argument to '-Wframe-larger-than='

We do not care compiler flags when cleaning.

Use the '=' operator for lazy expansion because we do not use
LDFLAGS_pcap.o or LDFLAGS_vde.o when cleaning.

While I was here, I removed the redundant -r option because it
already exists in the recipe.

Fixes: a83e4ca26af8 ("kbuild: remove cc-option switch from -Wframe-larger-than=")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com> [build]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a290821e355c..2a249f619467 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -18,9 +18,9 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
+LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
-LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
+LDFLAGS_vde.o = $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 
 targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
 
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

