Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joCrr-0005qj-AY
 for linux-um@lists.infradead.org; Wed, 24 Jun 2020 21:23:40 +0000
Received: by mail-wr1-x441.google.com with SMTP id j4so1216944wrp.10
 for <linux-um@lists.infradead.org>; Wed, 24 Jun 2020 14:23:37 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [RFC PATCH] Revert "um: Make CONFIG_STATIC_LINK actually static"
Date: Wed, 24 Jun 2020 22:23:19 +0100
Message-Id: <20200624212319.403689-1-ignat@cloudflare.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, brendanhiggins@google.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>

This reverts commit 3363179385629c1804ea846f4e72608c2201a81e.

This change is too restrictive. I've been running UML statically linked kernel
 with UML_NET_VECTOR networking in a docker "FROM: scratch" container just fine.
As long as we don't reference network peers by hostname and use only IP
addresses, NSS is not needed, so not used. In other words, it is possible to
have statically linked UML and UML_NET_VECTOR (and other networking types) and
use it, although with some restrictions, so let's not disable it.

Additionally, it should be at least theoretically possible to use another libc
(like musl, bionic etc) for static linking. I was able with some hacks to
compile UML against musl, although the executable segfaults for now. But this
option prevents even the research to be done.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 arch/um/Kconfig         | 8 +-------
 arch/um/drivers/Kconfig | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 96ab7026b037..817a4c838a06 100644
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
+	default n
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
@@ -76,9 +73,6 @@ config STATIC_LINK
 	  Additionally, this option enables using higher memory spaces (up to
 	  2.75G) for UML.
 
-	  NOTE: This option is incompatible with some networking features which
-	  depend on features that require being dynamically loaded (like NSS).
-
 config LD_SCRIPT_STATIC
 	bool
 	default y
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

