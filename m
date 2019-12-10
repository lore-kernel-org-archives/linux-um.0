Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iemwq-0005BX-Tc
 for linux-um@lists.infradead.org; Tue, 10 Dec 2019 21:21:38 +0000
Received: by mail-pl1-x64a.google.com with SMTP id 62so507507ple.19
 for <linux-um@lists.infradead.org>; Tue, 10 Dec 2019 13:21:35 -0800 (PST)
Date: Tue, 10 Dec 2019 13:21:08 -0800
Message-Id: <20191210212108.222514-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, johannes.berg@intel.com

Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
UML_NET_PCAP; this is because glibc tries to load NSS which does not
support being statically linked. So make CONFIG_STATIC_LINK depend on
!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.

Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 2a6d04fcb3e91..1ddc8745123f2 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config STATIC_LINK
 	bool "Force a static link"
+	depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP
 	default n
 	help
 	  This option gives you the ability to force a static link of UML.
@@ -72,6 +73,9 @@ config STATIC_LINK
 	  Additionally, this option enables using higher memory spaces (up to
 	  2.75G) for UML.
 
+	  NOTE: This option is incompatible with some networking features which
+	  depend on features that require being dynamically loaded (like NSS).
+
 config LD_SCRIPT_STATIC
 	bool
 	default y
-- 
2.24.0.525.g8f36a354ae-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

