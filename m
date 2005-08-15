Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4jVn-0004Bz-Bl	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 11:16:39 -0700
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E4jVl-0006y5-T7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 11:16:39 -0700
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7FIGR0r012309
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Aug 2005 14:16:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	j7FIGRos259474	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Aug 2005 14:16:27 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7FIGRkB023084
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Aug 2005 14:16:27 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <20050815181626.GQ2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
Subject: [uml-devel] [-mm PATCH 14/32] um: fix-up schedule_timeout() usage
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
Date: Mon, 15 Aug 2005 11:16:26 -0700
To: jdike@karaya.com
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 arch/um/drivers/random.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -urpN 2.6.13-rc5-mm1/arch/um/drivers/random.c 2.6.13-rc5-mm1-dev/arch/um/drivers/random.c
--- 2.6.13-rc5-mm1/arch/um/drivers/random.c	2005-08-07 09:57:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/arch/um/drivers/random.c	2005-08-08 13:55:26.000000000 -0700
@@ -58,10 +58,8 @@ static ssize_t rng_dev_read (struct file
                         if (filp->f_flags & O_NONBLOCK)
                                 return ret ? : -EAGAIN;
 
-                        if(need_resched()){
-                                current->state = TASK_INTERRUPTIBLE;
-                                schedule_timeout(1);
-                        }
+                        if(need_resched())
+                                schedule_timeout_interruptible(1);
                 }
                 else return n;
 		if (signal_pending (current))


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
