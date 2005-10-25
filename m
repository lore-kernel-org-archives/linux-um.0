Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUX0q-00051i-DL	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUX0p-0000Yt-4Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051025221253.21106.22572.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel
	EM64T [for 2.6.14?]
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
Date: Wed, 26 Oct 2005 00:12:54 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current value was correct before the introduction of Intel EM64T support -
but now L1_CACHE_SHIFT_MAX can be less than L1_CACHE_SHIFT, which _is_ funny!

Between the few users of ____cacheline_maxaligned_in_smp, we also have (for
example) rcu_ctrlblk, and struct zone, with zone->{lru_,}lock. I.e. we have a
lot of excess cacheline bouncing on them.

No correctness issues, obviously. So this could even be merged for 2.6.14 (I'm
not a fan of this idea, though).

CC: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-x86_64/cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/cache.h b/include/asm-x86_64/cache.h
--- a/include/asm-x86_64/cache.h
+++ b/include/asm-x86_64/cache.h
@@ -9,6 +9,6 @@
 /* L1 cache line size */
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
-#define L1_CACHE_SHIFT_MAX 6	/* largest L1 which this arch supports */
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
 #endif



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
