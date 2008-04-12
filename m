Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JkhSL-000773-OG for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 08:15:53 -0700
Received: from qb-out-0506.google.com ([72.14.204.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JkhSL-0008Oi-BJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 08:15:53 -0700
Received: by qb-out-0506.google.com with SMTP id c8so912228qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 08:15:52 -0700 (PDT)
Date: Sat, 12 Apr 2008 23:12:12 +0800 (CST)
Message-Id: <20080412.231212.103246256.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] UML: Remove a useless function
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
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


arch/um/drivers/chan_kern.c::chan_out_fd() is not used by anyone.
Remove it.

Compile testing passed.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
 arch/um/drivers/chan_kern.c |   13 -------------
 arch/um/include/chan_kern.h |    1 -
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index de22a10..6e51424 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -583,19 +583,6 @@ int parse_chan_pair(char *str, struct line *line, int device,
 	return 0;
 }
 
-int chan_out_fd(struct list_head *chans)
-{
-	struct list_head *ele;
-	struct chan *chan;
-
-	list_for_each(ele, chans) {
-		chan = list_entry(ele, struct chan, list);
-		if (chan->primary && chan->output)
-			return chan->fd;
-	}
-	return -1;
-}
-
 void chan_interrupt(struct list_head *chans, struct delayed_work *task,
 		    struct tty_struct *tty, int irq)
 {
diff --git a/arch/um/include/chan_kern.h b/arch/um/include/chan_kern.h
index de5f697..1e65145 100644
--- a/arch/um/include/chan_kern.h
+++ b/arch/um/include/chan_kern.h
@@ -44,7 +44,6 @@ extern void close_chan(struct list_head *chans, int delay_free_irq);
 extern int chan_window_size(struct list_head *chans, 
 			     unsigned short *rows_out, 
 			     unsigned short *cols_out);
-extern int chan_out_fd(struct list_head *chans);
 extern int chan_config_string(struct list_head *chans, char *str, int size,
 			      char **error_out);
 
-- 
1.5.2.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
