Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHUVQ-0004UY-NE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 16:29:49 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HHUVM-00072B-QP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 16:29:46 -0800
Date: Wed, 14 Feb 2007 19:22:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070215002205.GA8099@ccure.user-mode-linux.org>
References: <E1HFEIB-0000nJ-00@dorka.pomaz.szeredi.hu>
	<20070208195711.GA6607@ccure.user-mode-linux.org>
	<E1HFFeC-0000wJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1HFFeC-0000wJ-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] UML hang with 100% CPU
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 08, 2007 at 09:13:36PM +0100, Miklos Szeredi wrote:
> Strangely enough after continuing in gdb, UML is back to normal, and I
> can't make it hang any more.  It must be something timing related.

Can you see if the patch below fixes it?

				Jeff
-- 
Work email - jdike at linux dot intel dot com


Index: linux-2.6.18-mm/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/sigio.c	2007-02-08 16:48:00.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/sigio.c	2007-02-14 19:16:22.000000000 -0500
@@ -97,20 +97,22 @@ static int write_sigio_thread(void *unus
 
 static int need_poll(struct pollfds *polls, int n)
 {
-	if(n <= polls->size){
-		polls->used = n;
+	struct pollfd *new;
+
+	if(n <= polls->size)
 		return 0;
-	}
-	kfree(polls->poll);
-	polls->poll = um_kmalloc_atomic(n * sizeof(struct pollfd));
-	if(polls->poll == NULL){
+
+	new = um_kmalloc_atomic(n * sizeof(struct pollfd));
+	if(new == NULL){
 		printk("need_poll : failed to allocate new pollfds\n");
-		polls->size = 0;
-		polls->used = 0;
 		return -ENOMEM;
 	}
+
+	memcpy(new, polls->poll, polls->used * sizeof(struct pollfd));
+	kfree(polls->poll);
+
+	polls->poll = new;
 	polls->size = n;
-	polls->used = n;
 	return 0;
 }
 
@@ -171,15 +173,15 @@ int add_sigio_fd(int fd)
 			goto out;
 	}
 
-	n = current_poll.used + 1;
-	err = need_poll(&next_poll, n);
+	n = current_poll.used;
+	err = need_poll(&next_poll, n + 1);
 	if(err)
 		goto out;
 
-	for(i = 0; i < current_poll.used; i++)
-		next_poll.poll[i] = current_poll.poll[i];
-
-	next_poll.poll[n - 1] = *p;
+	memcpy(next_poll.poll, current_poll.poll,
+	       current_poll.used * sizeof(struct pollfd));
+	next_poll.poll[n] = *p;
+	next_poll.used = n + 1;
 	update_thread();
  out:
 	sigio_unlock();
@@ -214,6 +216,7 @@ int ignore_sigio_fd(int fd)
 		if(p->fd != fd)
 			next_poll.poll[n++] = *p;
 	}
+	next_poll.used = current_poll.used - 1;
 
 	update_thread();
  out:
@@ -331,10 +334,9 @@ void maybe_sigio_broken(int fd, int read
 
 	sigio_lock();
 	err = need_poll(&all_sigio_fds, all_sigio_fds.used + 1);
-	if(err){
-		printk("maybe_sigio_broken - failed to add pollfd\n");
+	if(err)
 		goto out;
-	}
+
 	all_sigio_fds.poll[all_sigio_fds.used++] =
 		((struct pollfd) { .fd  	= fd,
 				   .events 	= read ? POLLIN : POLLOUT,

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
