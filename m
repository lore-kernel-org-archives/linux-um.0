Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxGSH-0006tf-5H
 for linux-um@lists.infradead.org; Sun, 19 Jul 2020 21:02:42 +0000
Received: by mail-wr1-x442.google.com with SMTP id r12so15815887wrj.13
 for <linux-um@lists.infradead.org>; Sun, 19 Jul 2020 14:02:40 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v4 3/3] um: allow static linking for non-glibc implementations
Date: Sun, 19 Jul 2020 22:02:22 +0100
Message-Id: <20200719210222.2811-4-ignat@cloudflare.com>
In-Reply-To: <20200719210222.2811-1-ignat@cloudflare.com>
References: <20200719210222.2811-1-ignat@cloudflare.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, brendanhiggins@google.com, masahiroy@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>

It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
implementations, which do not rely on NSS, such as musl.

Allow static linking in this case.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig         | 6 +++---
 arch/um/drivers/Kconfig | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0c..d888b859c167 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -62,12 +62,12 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
-config FORBID_STATIC_LINK
-	bool
+config MAY_HAVE_RUNTIME_DEPS
+        bool
 
 config STATIC_LINK
 	bool "Force a static link"
-	depends on !FORBID_STATIC_LINK
+	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || !MAY_HAVE_RUNTIME_DEPS
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9160ead56e33..2e7b8e0e7194 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -234,7 +234,7 @@ config UML_NET_DAEMON
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
+	select MAY_HAVE_RUNTIME_DEPS
 	help
 	This User-Mode Linux network driver uses multi-message send
 	and receive functions. The host running the UML guest must have
@@ -246,7 +246,7 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
+	select MAY_HAVE_RUNTIME_DEPS
 	help
 	This User-Mode Linux network transport allows one or more running
 	UMLs on a single host to communicate with each other and also
@@ -294,7 +294,7 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
+	select MAY_HAVE_RUNTIME_DEPS
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

