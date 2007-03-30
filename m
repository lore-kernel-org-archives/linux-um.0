Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXOMK-0000Rk-Ig for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 14:10:11 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXOMI-0004Qq-Pm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 14:10:08 -0700
Date: Fri, 30 Mar 2007 14:04:01 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20070330210401.GE29450@kroah.com>
References: <20070330205938.984247529@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline; filename="uml-fix-epoll.patch"
In-Reply-To: <20070330210334.GA29450@kroah.com>
Subject: [uml-devel] [patch 04/37] UML - fix epoll
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Justin Forbes <jmforbes@linuxtx.org>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Dike <jdike@addtoit.com>

UML/x86_64 needs the same packing of struct epoll_event as x86_64.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/eventpoll.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -31,12 +31,19 @@
 /* 
  * On x86-64 make the 64bit structure have the same alignment as the
  * 32bit structure. This makes 32bit emulation easier.
+ *
+ * UML/x86_64 needs the same packing as x86_64 - UML + UML_X86 +
+ * 64_BIT adds up to UML/x86_64.
  */
 #ifdef __x86_64__
 #define EPOLL_PACKED __attribute__((packed))
 #else
+#if defined(CONFIG_UML) && defined(CONFIG_UML_X86) && defined(CONFIG_64BIT)
+#define EPOLL_PACKED __attribute__((packed))
+#else
 #define EPOLL_PACKED
 #endif
+#endif
 
 struct epoll_event {
 	__u32 events;

-- 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
