Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnzT8-0000hF-3i for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 05:20:26 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CnzT6-0008A6-Cf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 05:20:26 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
Message-ID: <20050110131003.GA6121@bytesex>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<20050103133412.GA25262@bytesex>
	<200501031531.19246.Armin.Warda@gmx.de>
	<200501081315.34841.blaisorblade_personal@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501081315.34841.blaisorblade_personal@yahoo.it>
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
Date: Mon, 10 Jan 2005 14:10:03 +0100
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Armin.Warda@gmx.de, "Christopher S. Aker" <caker@theshore.net>

> Roland McGrath:
> 
>   o fix bogus ECHILD return from wait* with zombie group leader
> 
> I'm not sure this is the fix, but it is possible indeed, given that the 
> problem UML triggered was, IIRC, that when it exited, there wasn't a proper 
> cleanup of the status, and the process became invisible but still kept a 
> reference to the file in /tmp, preventing it from being deleted...

Yep, that makes sense.  The race thing also explains why it doesn't
allways happen.  I still can't reproduce it on my machine btw, so it's
hard for me to test whenever that really fixes it or not.

> I think you can search for it on linux.bkbits.net... I'll do that when I have 
> time...

Attached below for reference.

  Gerd

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/17 09:18:41-08:00 roland@redhat.com 
#   [PATCH] fix bogus ECHILD return from wait* with zombie group leader
#   
#   Klaus Dittrich observed this bug and posted a test case for it.
#   
#   This patch fixes both that failure mode and some others possible.  What
#   Klaus saw was a false negative (i.e.  ECHILD when there was a child)
#   when the group leader was a zombie but delayed because other children
#   live; in the test program this happens in a race between the two threads
#   dying on a signal.
#   
#   The change to the TASK_TRACED case avoids a potential false positive
#   (blocking, or WNOHANG returning 0, when there are really no children
#   left), in the race condition where my_ptrace_child returns zero.
#   
#   Signed-off-by: Roland McGrath <roland@redhat.com>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# kernel/exit.c
#   2004/12/17 00:09:08-08:00 roland@redhat.com +13 -2
#   fix bogus ECHILD return from wait* with zombie group leader
# 
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2005-01-10 14:00:38 +01:00
+++ b/kernel/exit.c	2005-01-10 14:00:38 +01:00
@@ -1319,6 +1319,10 @@
 
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
+	/*
+	 * We will set this flag if we see any child that might later
+	 * match our criteria, even if we are not able to reap it yet.
+	 */
 	flag = 0;
 	current->state = TASK_INTERRUPTIBLE;
 	read_lock(&tasklist_lock);
@@ -1337,11 +1341,14 @@
 
 			switch (p->state) {
 			case TASK_TRACED:
-				flag = 1;
 				if (!my_ptrace_child(p))
 					continue;
 				/*FALLTHROUGH*/
 			case TASK_STOPPED:
+				/*
+				 * It's stopped now, so it might later
+				 * continue, exit, or stop again.
+				 */
 				flag = 1;
 				if (!(options & WUNTRACED) &&
 				    !my_ptrace_child(p))
@@ -1377,8 +1384,12 @@
 						goto end;
 					break;
 				}
-				flag = 1;
 check_continued:
+				/*
+				 * It's running now, so it might later
+				 * exit, stop, or stop and then continue.
+				 */
+				flag = 1;
 				if (!unlikely(options & WCONTINUED))
 					continue;
 				retval = wait_task_continued(


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
