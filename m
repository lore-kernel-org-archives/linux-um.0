Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyC8G-0003Ie-Ol	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 10:25:20 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DyC8G-0005ct-6o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 10:25:20 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050728160555.EA9C23EF@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: avoid unnecessary pcap rebuild
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 28 Jul 2005 18:05:55 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Just a Kbuild subtlety, not listing a target file inside targets causes it to
be rebuilt each time, and as a consequence everything depending on it is
rebuilt.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/Makefile~uml-avoid-rebuild arch/um/drivers/Makefile
--- linux-2.6.git/arch/um/drivers/Makefile~uml-avoid-rebuild	2005-07-28 18:05:35.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/Makefile	2005-07-28 18:05:35.000000000 +0200
@@ -19,6 +19,8 @@ harddog-objs := harddog_kern.o harddog_u
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
 
+targets := pcap_kern.o pcap_user.o
+
 $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
 	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
 #XXX: The call below does not work because the flags are added before the
@@ -26,7 +28,7 @@ $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)
 #$(call if_changed,ld)
 
 # When the above is fixed, don't forget to add this too!
-#targets := $(obj)/pcap.o
+#targets += $(obj)/pcap.o
 
 obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) += ssl.o
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
