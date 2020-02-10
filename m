Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 04/28] docs: virt: user_mode_linux.rst: fix URL references
Date: Mon, 10 Feb 2020 07:02:42 +0100
Message-Id: <7703891859ba5dae121fa9fa21914512ba3d3fbb.1581314316.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1581314316.git.mchehab+huawei@kernel.org>
References: <cover.1581314316.git.mchehab+huawei@kernel.org>
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
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-doc@vger.kernel.org, linux-um@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Several URLs are pointing to outdated places.

Update the references for the URLs whose contents still exists,
removing the others.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/uml/user_mode_linux.rst | 71 +++++++++-------------
 1 file changed, 29 insertions(+), 42 deletions(-)

diff --git a/Documentation/virt/uml/user_mode_linux.rst b/Documentation/virt/uml/user_mode_linux.rst
index e0632d80753e..de0f0b2c9d5b 100644
--- a/Documentation/virt/uml/user_mode_linux.rst
+++ b/Documentation/virt/uml/user_mode_linux.rst
@@ -321,7 +321,7 @@ Linux: a port of the Linux kernel as a normal Intel Linux process.
   as modules, especially filesystems and network protocols and filters,
   so most symbols which need to be exported probably already are.
   However, if you do find symbols that need exporting, let  us
-  <http://user-mode-linux.sourceforge.net/>  know, and
+  know at http://user-mode-linux.sourceforge.net/, and
   they'll be "taken care of".
 
 
@@ -383,9 +383,9 @@ Linux: a port of the Linux kernel as a normal Intel Linux process.
 
 
   You will need a filesystem to boot UML from.  There are a number
-  available for download from  here  <http://user-mode-
-  linux.sourceforge.net/> .  There are also  several tools
-  <http://user-mode-linux.sourceforge.net/>  which can be
+  available for download from http://user-mode-linux.sourceforge.net.
+  There are also  several tools at
+  http://user-mode-linux.sourceforge.net/  which can be
   used to generate UML-compatible filesystem images from media.
   The kernel will boot up and present you with a login prompt.
 
@@ -464,10 +464,9 @@ Note:
 
   Here are some examples of UML in action:
 
-  -  A login session <http://user-mode-linux.sourceforge.net/login.html>
-
-  -  A virtual network <http://user-mode-linux.sourceforge.net/net.html>
+  -  A login session http://user-mode-linux.sourceforge.net/old/login.html
 
+  -  A virtual network http://user-mode-linux.sourceforge.net/old/net.html
 
 
 
@@ -1132,11 +1131,6 @@ Note:
 
 
 
-
-  Harald's original README is here <http://user-mode-linux.source-
-  forge.net/>  and explains these in detail, as well as
-  some other issues.
-
   There is also a related point-to-point only "ucast" transport.
   This is useful when your network does not support multicast, and
   all network connections are simple point to point links.
@@ -1219,8 +1213,7 @@ Note:
   make sure that /usr/src/linux points to the headers for the running
   kernel.
 
-  These were pointed out by Tim Robinson <timro at trkr dot net> in
-  <http://www.geocrawler.com/> name="this uml-user post"> .
+  These were pointed out by Tim Robinson <timro at trkr dot net> in the past.
 
 
 
@@ -1914,8 +1907,8 @@ Note:
 
   uml_moo is installed with the UML deb and RPM.  If you didn't install
   UML from one of those packages, you can also get it from the UML
-  utilities <http://user-mode-linux.sourceforge.net/
-  utilities>  tar file in tools/moo.
+  utilities http://user-mode-linux.sourceforge.net/utilities tar file
+  in tools/moo.
 
 
 
@@ -3709,18 +3702,15 @@ Note:
 
 
   This is a syslogd bug.  There's a race between a parent process
-  installing a signal handler and its child sending the signal.  See
-  this uml-devel post <http://www.geocrawler.com/lists/3/Source-
-  Forge/709/0/6612801>  for the details.
+  installing a signal handler and its child sending the signal.
 
 
 
 13.8.  TUN/TAP networking doesn't work on a 2.4 host
 ----------------------------------------------------
 
-  There are a couple of problems which were
-  <http://www.geocrawler.com/lists/3/SourceForge/597/0/> name="pointed
-  out">  by Tim Robinson <timro at trkr dot net>
+  There are a couple of problems which were reported by
+  Tim Robinson <timro at trkr dot net>
 
   -  It doesn't work on hosts running 2.4.7 (or thereabouts) or earlier.
      The fix is to upgrade to something more recent and then read the
@@ -3763,7 +3753,7 @@ Note:
 
 
   Documentation on IP Masquerading, and SNAT, can be found at
-  www.netfilter.org  <http://www.netfilter.org> .
+  http://www.netfilter.org.
 
 
   If you can reach the local net, but not the outside Internet, then
@@ -4113,14 +4103,14 @@ Note:
 
   Rusty Russell <rusty at linuxcare.com.au>  -
 
-  -  wrote the  HOWTO <http://user-mode-
-     linux.sourceforge.net/UserModeLinux-HOWTO.html>
+  -  wrote the  HOWTO
+     http://user-mode-linux.sourceforge.net/old/UserModeLinux-HOWTO.html
 
   -  prodded me into making this project official and putting it on
      SourceForge
 
-  -  came up with the way cool UML logo <http://user-mode-
-     linux.sourceforge.net/uml-small.png>
+  -  came up with the way cool UML logo
+     http://user-mode-linux.sourceforge.net/uml-small.png
 
   -  redid the config process
 
@@ -4148,17 +4138,15 @@ Note:
   Jim Leu <jleu at mindspring.com>  - Wrote the virtual ethernet driver
   and associated usermode tools
 
-  Lars Brinkhoff <http://lars.nocrew.org/>  - Contributed the ptrace
-  proxy from his own  project <http://a386.nocrew.org/> to allow easier
-  kernel debugging
+  Lars Brinkhoff http://lars.nocrew.org/  - Contributed the ptrace
+  proxy from his own  project to allow easier kernel debugging
 
 
   Andrea Arcangeli <andrea at suse.de>  - Redid some of the early boot
   code so that it would work on machines with Large File Support
 
 
-  Chris Emerson <http://www.chiark.greenend.org.uk/~cemerson/>  - Did
-  the first UML port to Linux/ppc
+  Chris Emerson - Did the first UML port to Linux/ppc
 
 
   Harald Welte <laforge at gnumonks.org>  - Wrote the multicast
@@ -4173,7 +4161,7 @@ Note:
   wrote the iomem emulation support
 
 
-  Henrik Nordstrom <http://hem.passagen.se/hno/>  - Provided a variety
+  Henrik Nordstrom http://hem.passagen.se/hno/  - Provided a variety
   of patches, fixes, and clues
 
 
@@ -4208,16 +4196,15 @@ Note:
   submitted patches for the slip transport and lots of other things.
 
 
-  David Coulson <http://davidcoulson.net>  -
+  David Coulson http://davidcoulson.net  -
 
-  -  Set up the usermodelinux.org <http://usermodelinux.org>  site,
+  -  Set up the http://usermodelinux.org  site,
      which is a great way of keeping the UML user community on top of
      UML goings-on.
 
   -  Site documentation and updates
 
   -  Nifty little UML management daemon  UMLd
-     <http://uml.openconsultancy.com/umld/>
 
   -  Lots of testing and bug reports
 
@@ -4390,12 +4377,12 @@ Note:
   work with RH 6.2.
 
   Michael Jennings <mikejen at hevanet.com>  sent in some material which
-  is now gracing the top of the  index  page <http://user-mode-
-  linux.sourceforge.net/>  of this site.
+  is now gracing the top of the  index  page
+  http://user-mode-linux.sourceforge.net/  of this site.
 
-  SGI <http://www.sgi.com>  (and more specifically Ralf Baechle <ralf at
-  uni-koblenz.de> ) gave me an account on oss.sgi.com
-  <http://www.oss.sgi.com> .  The bandwidth there made it possible to
+  SGI (and more specifically Ralf Baechle <ralf at
+  uni-koblenz.de> ) gave me an account on oss.sgi.com.
+  The bandwidth there made it possible to
   produce most of the filesystems available on the project download
   page.
 
@@ -4412,5 +4399,5 @@ Note:
 
   Chris Reahard built a specialized root filesystem for running a DNS
   server jailed inside UML.  It's available from the download
-  <http://user-mode-linux.sourceforge.net/dl-sf.html>  page in the Jail
+  http://user-mode-linux.sourceforge.net/old/dl-sf.html  page in the Jail
   Filesystems section.
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

