Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp.al2klimov.de ([78.46.175.9])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsuGy-00027V-LX
 for linux-um@lists.infradead.org; Tue, 07 Jul 2020 20:33:02 +0000
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: user-mode Linux
Date: Tue,  7 Jul 2020 22:32:46 +0200
Message-Id: <20200707203246.53158-1-grandmaster@al2klimov.de>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, corbet@lwn.net, johannes.berg@intel.com, brendanhiggins@google.com, erelx.geron@intel.com, linux@roeck-us.net, arnd@arndb.de, linux-um@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.
 Rationale:
 I'd like not to submit patches much faster than you maintainers apply them.

 Documentation/virt/uml/user_mode_linux.rst | 2 +-
 arch/um/drivers/Kconfig                    | 2 +-
 arch/um/drivers/harddog_kern.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/uml/user_mode_linux.rst b/Documentation/virt/uml/user_mode_linux.rst
index de0f0b2c9d5b..775d3de84331 100644
--- a/Documentation/virt/uml/user_mode_linux.rst
+++ b/Documentation/virt/uml/user_mode_linux.rst
@@ -3753,7 +3753,7 @@ Note:
 
 
   Documentation on IP Masquerading, and SNAT, can be found at
-  http://www.netfilter.org.
+  https://www.netfilter.org.
 
 
   If you can reach the local net, but not the outside Internet, then
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9160ead56e33..85e170149e99 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -259,7 +259,7 @@ config UML_NET_VDE
 	To use this form of networking, you will need to run vde_switch
 	on the host.
 
-	For more information, see <http://wiki.virtualsquare.org/>
+	For more information, see <https://wiki.virtualsquare.org/>
 	That site has a good overview of what VDE is and also examples
 	of the UML command line to use to enable VDE networking.
 
diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index e6d4f43deba8..7a39b8b7ae55 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -3,7 +3,7 @@
  *	SoftDog	0.05:	A Software Watchdog Device
  *
  *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
- *				http://www.redhat.com
+ *				https://www.redhat.com
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
-- 
2.27.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

