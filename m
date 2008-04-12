Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JkhMN-0005jQ-UC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 08:09:44 -0700
Received: from qb-out-0506.google.com ([72.14.204.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JkhMN-0007hB-Jo
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 08:09:43 -0700
Received: by qb-out-0506.google.com with SMTP id c8so910786qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 08:09:42 -0700 (PDT)
Date: Sat, 12 Apr 2008 23:05:58 +0800 (CST)
Message-Id: <20080412.230558.258868812.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] UML: Make a function static
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
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


arch/um/drivers/chan_kern.c::open_chan() can become static.

Compile testing passed.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
 arch/um/drivers/chan_kern.c |    2 +-
 arch/um/include/chan_kern.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index db3082b..de22a10 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -125,7 +125,7 @@ static int open_one_chan(struct chan *chan)
 	return 0;
 }
 
-int open_chan(struct list_head *chans)
+static int open_chan(struct list_head *chans)
 {
 	struct list_head *ele;
 	struct chan *chan;
diff --git a/arch/um/include/chan_kern.h b/arch/um/include/chan_kern.h
index 624b510..de5f697 100644
--- a/arch/um/include/chan_kern.h
+++ b/arch/um/include/chan_kern.h
@@ -31,7 +31,6 @@ extern void chan_interrupt(struct list_head *chans, struct delayed_work *task,
 			   struct tty_struct *tty, int irq);
 extern int parse_chan_pair(char *str, struct line *line, int device,
 			   const struct chan_opts *opts, char **error_out);
-extern int open_chan(struct list_head *chans);
 extern int write_chan(struct list_head *chans, const char *buf, int len,
 			     int write_irq);
 extern int console_write_chan(struct list_head *chans, const char *buf, 
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
