Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu81H-0002aB-MI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:12:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu81G-0002bn-UY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:12:47 +0000
Date: Thu, 18 Aug 2011 20:12:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu819-00085K-Vv@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 82/91] um: kill useless argument of
 free_chan() and free_one_chan()
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


delay_free_irq is always 0 for those...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/drivers/chan_kern.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index e040683..420e2c8 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -358,11 +358,11 @@ int chan_window_size(struct list_head *chans, unsigned short *rows_out,
 	return 0;
 }
 
-static void free_one_chan(struct chan *chan, int delay_free_irq)
+static void free_one_chan(struct chan *chan)
 {
 	list_del(&chan->list);
 
-	close_one_chan(chan, delay_free_irq);
+	close_one_chan(chan, 0);
 
 	if (chan->ops->free != NULL)
 		(*chan->ops->free)(chan->data);
@@ -372,14 +372,14 @@ static void free_one_chan(struct chan *chan, int delay_free_irq)
 	kfree(chan);
 }
 
-static void free_chan(struct list_head *chans, int delay_free_irq)
+static void free_chan(struct list_head *chans)
 {
 	struct list_head *ele, *next;
 	struct chan *chan;
 
 	list_for_each_safe(ele, next, chans) {
 		chan = list_entry(ele, struct chan, list);
-		free_one_chan(chan, delay_free_irq);
+		free_one_chan(chan);
 	}
 }
 
@@ -547,7 +547,7 @@ int parse_chan_pair(char *str, struct line *line, int device,
 	char *in, *out;
 
 	if (!list_empty(chans)) {
-		free_chan(chans, 0);
+		free_chan(chans);
 		INIT_LIST_HEAD(chans);
 	}
 
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

