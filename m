Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8iL-0004AT-Qq	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:49:01 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI8iL-0006Iv-EE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:49:02 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921172928.10219.63412.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 09/10] Uml: use GFP_ATOMIC for allocations under
	spinlocks.
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
Date: Wed, 21 Sep 2005 19:29:28 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

setup_initial_poll is only called with sigio_lock() held, so use appropriate
allocation.

Also, parse_chan() can also be called when holding a spinlock (see line_open()
 -> parse_chan_pair()).

I have sporadical problems (spinlock taken twice, with spinlock debugging on
UP) which could be caused by a sequence like "take spinlock, alloc and go to
sleep, take again the spinlock in the other thread".

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/chan_kern.c |    2 +-
 arch/um/kernel/sigio_user.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -465,7 +465,7 @@ static struct chan *parse_chan(char *str
 	data = (*ops->init)(str, device, opts);
 	if(data == NULL) return(NULL);
 
-	chan = kmalloc(sizeof(*chan), GFP_KERNEL);
+	chan = kmalloc(sizeof(*chan), GFP_ATOMIC);
 	if(chan == NULL) return(NULL);
 	*chan = ((struct chan) { .list	 	= LIST_HEAD_INIT(chan->list),
 				 .primary	= 1,
diff --git a/arch/um/kernel/sigio_user.c b/arch/um/kernel/sigio_user.c
--- a/arch/um/kernel/sigio_user.c
+++ b/arch/um/kernel/sigio_user.c
@@ -340,7 +340,7 @@ static int setup_initial_poll(int fd)
 {
 	struct pollfd *p;
 
-	p = um_kmalloc(sizeof(struct pollfd));
+	p = um_kmalloc_atomic(sizeof(struct pollfd));
 	if(p == NULL){
 		printk("setup_initial_poll : failed to allocate poll\n");
 		return(-1);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
