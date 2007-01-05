Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6L-0001QO-Jr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6H-0007RC-3J
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Message-Id: <200701051842.l05IgDS5004612@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/9] UML - Use LIST_HEAD where possible
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

A couple of list_head declarations can be improved through the use of 
LIST_HEAD().

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/mconsole_kern.c |    2 +-
 arch/um/drivers/port_kern.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_kern.c	2007-01-01 13:27:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c	2007-01-01 13:30:00.000000000 -0500
@@ -371,7 +371,7 @@ struct unplugged_pages {
 
 static DECLARE_MUTEX(plug_mem_mutex);
 static unsigned long long unplugged_pages_count = 0;
-static struct list_head unplugged_pages = LIST_HEAD_INIT(unplugged_pages);
+static LIST_HEAD(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
 
 static int mem_config(char *str, char **error_out)
Index: linux-2.6.18-mm/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_kern.c	2007-01-01 13:29:38.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/port_kern.c	2007-01-01 13:30:00.000000000 -0500
@@ -130,7 +130,7 @@ static int port_accept(struct port_list 
 }
 
 static DECLARE_MUTEX(ports_sem);
-static struct list_head ports = LIST_HEAD_INIT(ports);
+static LIST_HEAD(ports);
 
 void port_work_proc(struct work_struct *unused)
 {


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
