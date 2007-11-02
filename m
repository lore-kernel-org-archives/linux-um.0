Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InyiF-0001A5-Jo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:45:35 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Inyi9-0000Rx-5Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:45:30 -0700
Date: Fri, 2 Nov 2007 11:40:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071102154013.GA10268@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/6] UML - Fix URLs in Kconfig and help strings
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Karol Swietlicki <magotari@gmail.com>

From: Karol Swietlicki <magotari@gmail.com>

This patch updates links which broke during the transition to the new 
UML website.

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Kconfig             |    2 +-
 arch/um/Kconfig.char        |    2 +-
 arch/um/Kconfig.debug       |    4 ++--
 arch/um/Kconfig.net         |   12 ++++++------
 arch/um/include/chan_user.h |    2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6.22/arch/um/Kconfig
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig	2007-10-25 12:23:06.000000000 -0400
+++ linux-2.6.22/arch/um/Kconfig	2007-10-26 15:38:03.000000000 -0400
@@ -145,7 +145,7 @@ config HPPFS
 	  by removing or changing anything in /proc which gives away the
 	  identity of a UML.
 
-	  See <http://user-mode-linux.sf.net/hppfs.html> for more information.
+	  See <http://user-mode-linux.sf.net/old/hppfs.html> for more information.
 
 	  You only need this if you are setting up a UML honeypot.  Otherwise,
 	  it is safe to say 'N' here.
Index: linux-2.6.22/arch/um/Kconfig.char
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig.char	2007-10-18 23:39:13.000000000 -0400
+++ linux-2.6.22/arch/um/Kconfig.char	2007-10-26 15:38:03.000000000 -0400
@@ -18,7 +18,7 @@ config SSL
           lines on the UML that are usually made to show up on the host as
           ttys or ptys.
 
-          See <http://user-mode-linux.sourceforge.net/input.html> for more
+          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
           information and command line examples of how to use this facility.
 
           Unless you have a specific reason for disabling this, say Y.
Index: linux-2.6.22/arch/um/Kconfig.debug
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig.debug	2007-10-18 23:39:13.000000000 -0400
+++ linux-2.6.22/arch/um/Kconfig.debug	2007-10-26 15:38:03.000000000 -0400
@@ -9,7 +9,7 @@ config GPROF
 	  This allows profiling of a User-Mode Linux kernel with the gprof
 	  utility.
 
-	  See <http://user-mode-linux.sourceforge.net/gprof.html> for more
+	  See <http://user-mode-linux.sourceforge.net/old/gprof.html> for more
 	  details.
 
 	  If you're involved in UML kernel development and want to use gprof,
@@ -22,7 +22,7 @@ config GCOV
 	  This option allows developers to retrieve coverage data from a UML
 	  session.
 
-	  See <http://user-mode-linux.sourceforge.net/gprof.html> for more
+	  See <http://user-mode-linux.sourceforge.net/old/gprof.html> for more
 	  details.
 
 	  If you're involved in UML kernel development and want to use gcov,
Index: linux-2.6.22/arch/um/Kconfig.net
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig.net	2007-10-12 12:09:00.000000000 -0400
+++ linux-2.6.22/arch/um/Kconfig.net	2007-10-26 15:38:03.000000000 -0400
@@ -14,7 +14,7 @@ config UML_NET
 
         For more information, including explanations of the networking and
         sample configurations, see
-        <http://user-mode-linux.sourceforge.net/networking.html>.
+        <http://user-mode-linux.sourceforge.net/old/networking.html>.
 
         If you'd like to be able to enable networking in the User-Mode
         linux environment, say Y; otherwise say N.  Note that you must
@@ -38,7 +38,7 @@ config UML_NET_ETHERTAP
         CONFIG_NETLINK_DEV configured as Y or M.
 
         For more information, see
-        <http://user-mode-linux.sourceforge.net/networking.html>  That site
+        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
         has examples of the UML command line to use to enable Ethertap
         networking.
 
@@ -72,7 +72,7 @@ config UML_NET_SLIP
         To use this, your host must support slip devices.
 
         For more information, see
-        <http://user-mode-linux.sourceforge.net/networking.html>.  That site
+        <http://user-mode-linux.sourceforge.net/old/networking.html>.
         has examples of the UML command line to use to enable slip
         networking, and details of a few quirks with it.
 
@@ -96,7 +96,7 @@ config UML_NET_DAEMON
         networking daemon on the host.
 
         For more information, see
-        <http://user-mode-linux.sourceforge.net/networking.html>  That site
+        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
         has examples of the UML command line to use to enable Daemon
         networking.
 
@@ -144,7 +144,7 @@ config UML_NET_MCAST
         To use this, your host kernel(s) must support IP Multicasting.
 
         For more information, see
-        <http://user-mode-linux.sourceforge.net/networking.html>  That site
+        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
         has examples of the UML command line to use to enable Multicast
         networking, and notes about the security of this approach.
 
@@ -165,7 +165,7 @@ config UML_NET_PCAP
 	installed in order to build the pcap transport into UML.
 
         For more information, see
-        <http://user-mode-linux.sourceforge.net/networking.html>  That site
+        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
         has examples of the UML command line to use to enable this option.
 
 	If you intend to use UML as a network monitor for the host, say
Index: linux-2.6.22/arch/um/include/chan_user.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/chan_user.h	2007-10-12 12:06:56.000000000 -0400
+++ linux-2.6.22/arch/um/include/chan_user.h	2007-10-26 15:38:03.000000000 -0400
@@ -48,7 +48,7 @@ extern void register_winch_irq(int fd, i
 #define __channel_help(fn, prefix) \
 __uml_help(fn, prefix "[0-9]*=<channel description>\n" \
 "    Attach a console or serial line to a host channel.  See\n" \
-"    http://user-mode-linux.sourceforge.net/input.html for a complete\n" \
+"    http://user-mode-linux.sourceforge.net/old/input.html for a complete\n" \
 "    description of this switch.\n\n" \
 );
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
