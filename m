Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3bmz-00063T-4G for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:03:21 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3bmx-0004wK-Hi
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:03:21 -0700
Date: Tue, 3 Jun 2008 15:02:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080603190235.GA9511@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/6] UML - Deal with host time going backwards
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
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Nix <nix@esperi.org.uk>

Protection against the host's time going backwards - keep track of the
time at the last tick and if it's greater than the current time, keep
time stopped until the host catches up.

Cc: Nix <nix@esperi.org.uk>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/time.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6-git/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/time.c	2008-05-14 10:44:02.000000000 -0400
+++ linux-2.6-git/arch/um/os-Linux/time.c	2008-06-02 15:43:53.000000000 -0400
@@ -106,6 +106,10 @@ static void deliver_alarm(void)
 	unsigned long long this_tick = os_nsecs();
 	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
 
+	/* Protection against the host's time going backwards */
+	if ((last_tick != 0) && (this_tick < last_tick))
+		this_tick = last_tick;
+
 	if (last_tick == 0)
 		last_tick = this_tick - one_tick;
 
@@ -148,6 +152,9 @@ static int after_sleep_interval(struct t
 		start_usecs = usec;
 
 	start_usecs -= skew / UM_NSEC_PER_USEC;
+	if (start_usecs < 0)
+		start_usecs = 0;
+
 	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
 				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
 	interval = ((struct itimerval) { { 0, usec }, tv });

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
