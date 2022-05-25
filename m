Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntqSt-00B9PO-KN
	for linux-um@lists.infradead.org; Wed, 25 May 2022 12:50:17 +0000
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B08DC3FBC8
	for <linux-um@lists.infradead.org>; Wed, 25 May 2022 12:50:09 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id q12-20020a056402040c00b0042a84f9939dso14854144edv.7
        for <linux-um@lists.infradead.org>; Wed, 25 May 2022 05:50:09 -0700 (PDT)
From: Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/2] um/drivers: Kconfig: Fix indentation
Date: Wed, 25 May 2022 14:50:01 +0200
Message-Id: <20220525125001.47009-3-juerg.haefliger@canonical.com>
In-Reply-To: <20220525125001.47009-1-juerg.haefliger@canonical.com>
References: <20220525125001.47009-1-juerg.haefliger@canonical.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Juerg Haefliger <juerg.haefliger@canonical.com>

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/um/drivers/Kconfig | 54 ++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index f145842c40b9..27e09e421d50 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -236,37 +236,37 @@ config UML_NET_VECTOR
 	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
-	This User-Mode Linux network driver uses multi-message send
-	and receive functions. The host running the UML guest must have
-	a linux kernel version above 3.0 and a libc version > 2.13.
-	This driver provides tap, raw, gre and l2tpv3 network transports
-	with up to 4 times higher network throughput than the UML network
-	drivers.
+	  This User-Mode Linux network driver uses multi-message send
+	  and receive functions. The host running the UML guest must have
+	  a linux kernel version above 3.0 and a libc version > 2.13.
+	  This driver provides tap, raw, gre and l2tpv3 network transports
+	  with up to 4 times higher network throughput than the UML network
+	  drivers.
 
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
-	This User-Mode Linux network transport allows one or more running
-	UMLs on a single host to communicate with each other and also
-	with the rest of the world using Virtual Distributed Ethernet,
-	an improved fork of uml_switch.
+	  This User-Mode Linux network transport allows one or more running
+	  UMLs on a single host to communicate with each other and also
+	  with the rest of the world using Virtual Distributed Ethernet,
+	  an improved fork of uml_switch.
 
-	You must have libvdeplug installed in order to build the vde
-	transport into UML.
+	  You must have libvdeplug installed in order to build the vde
+	  transport into UML.
 
-	To use this form of networking, you will need to run vde_switch
-	on the host.
+	  To use this form of networking, you will need to run vde_switch
+	  on the host.
 
-	For more information, see <http://wiki.virtualsquare.org/>
-	That site has a good overview of what VDE is and also examples
-	of the UML command line to use to enable VDE networking.
+	  For more information, see <http://wiki.virtualsquare.org/>
+	  That site has a good overview of what VDE is and also examples
+	  of the UML command line to use to enable VDE networking.
 
-	NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
-	migrate to UML_NET_VECTOR.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
 
-	If unsure, say N.
+	  If unsure, say N.
 
 config UML_NET_MCAST
 	bool "Multicast transport (obsolete)"
@@ -296,19 +296,19 @@ config UML_NET_PCAP
 	depends on UML_NET
 	select MAY_HAVE_RUNTIME_DEPS
 	help
-	The pcap transport makes a pcap packet stream on the host look
-	like an ethernet device inside UML.  This is useful for making
-	UML act as a network monitor for the host.  You must have libcap
-	installed in order to build the pcap transport into UML.
+	  The pcap transport makes a pcap packet stream on the host look
+	  like an ethernet device inside UML.  This is useful for making
+	  UML act as a network monitor for the host.  You must have libcap
+	  installed in order to build the pcap transport into UML.
 
 	  For more information, see
 	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
 	  has examples of the UML command line to use to enable this option.
 
-	NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
-	migrate to UML_NET_VECTOR.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
 
-	If unsure, say N.
+	  If unsure, say N.
 
 config UML_NET_SLIRP
 	bool "SLiRP transport (obsolete)"
-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

