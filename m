Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvnlN-0005rL-LK
 for linux-um@lists.infradead.org; Wed, 15 Jul 2020 20:12:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id z15so4166950wrl.8
 for <linux-um@lists.infradead.org>; Wed, 15 Jul 2020 13:12:21 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v3 3/3] um: allow static linking for non-glibc implementations
Date: Wed, 15 Jul 2020 21:11:59 +0100
Message-Id: <20200715201159.54166-4-ignat@cloudflare.com>
In-Reply-To: <20200715201159.54166-1-ignat@cloudflare.com>
References: <20200715201159.54166-1-ignat@cloudflare.com>
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
 arch/um/Kconfig         | 5 +----
 arch/um/drivers/Kconfig | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0c..beb98b3b9f75 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -62,12 +62,9 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
-config FORBID_STATIC_LINK
-	bool
-
 config STATIC_LINK
 	bool "Force a static link"
-	depends on !FORBID_STATIC_LINK
+	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9160ead56e33..72d417055782 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -234,7 +234,6 @@ config UML_NET_DAEMON
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
 	help
 	This User-Mode Linux network driver uses multi-message send
 	and receive functions. The host running the UML guest must have
@@ -246,7 +245,6 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
 	help
 	This User-Mode Linux network transport allows one or more running
 	UMLs on a single host to communicate with each other and also
@@ -294,7 +292,6 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

