Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFy0m-0004eh-P8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 09:54:32 -0700
Received: from [151.97.230.17] (helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFy0l-0001Bc-0g for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 09:54:32 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041008165431.EDE238D15@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: don't declare cpu_online - fix
	compilation error
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
Date: Fri, 08 Oct 2004 18:54:31 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Avoid redeclaring again (resulting in a compilation error) cpu_online and
cpu_*_map, which are now declared elsewhere.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/smp.h |    6 ------
 1 files changed, 6 deletions(-)

diff -puN include/asm-um/smp.h~uml-no-decl-cpu_online include/asm-um/smp.h
--- linux-2.6.9-current/include/asm-um/smp.h~uml-no-decl-cpu_online	2004-10-08 18:00:49.000000000 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/smp.h	2004-10-08 18:00:49.000000000 +0200
@@ -8,10 +8,6 @@
 #include "asm/current.h"
 #include "linux/cpumask.h"
 
-extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
-
-
 #define smp_processor_id() (current_thread->cpu)
 #define cpu_logical_map(n) (n)
 #define cpu_number_map(n) (n)
@@ -19,8 +15,6 @@ extern cpumask_t cpu_possible_map;
 extern int hard_smp_processor_id(void);
 #define NO_PROC_ID -1
 
-#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-
 extern int ncpus;
 
 
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
