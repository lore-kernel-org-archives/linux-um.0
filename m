Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rusty@ozlabs.org>) id 1YSOj5-0004M4-Nd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Mar 2015 11:41:31 +0000
Received: from ozlabs.org ([103.22.144.67])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YSOj3-0005dX-U9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Mar 2015 11:41:31 +0000
From: Rusty Russell <rusty@rustcorp.com.au>
Date: Mon,  2 Mar 2015 22:05:48 +1030
Message-Id: <1425296150-4722-7-git-send-email-rusty@rustcorp.com.au>
In-Reply-To: <1425296150-4722-1-git-send-email-rusty@rustcorp.com.au>
References: <1425296150-4722-1-git-send-email-rusty@rustcorp.com.au>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 07/16] um: fix up obsolete cpu function usage.
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, user-mode-linux-devel@lists.sourceforge.net

Thanks to spatch.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/smp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
index 5c8c3ea7db7b..74077892b34a 100644
--- a/arch/um/kernel/smp.c
+++ b/arch/um/kernel/smp.c
@@ -67,12 +67,12 @@ static int idle_proc(void *cpup)
 	os_set_fd_async(cpu_data[cpu].ipi_pipe[0]);
 
 	wmb();
-	if (cpu_test_and_set(cpu, cpu_callin_map)) {
+	if (cpumask_test_and_set_cpu(cpu, &cpu_callin_map)) {
 		printk(KERN_ERR "huh, CPU#%d already present??\n", cpu);
 		BUG();
 	}
 
-	while (!cpu_isset(cpu, smp_commenced_mask))
+	while (!cpumask_test_cpu(cpu, &smp_commenced_mask))
 		cpu_relax();
 
 	notify_cpu_starting(cpu);
@@ -111,7 +111,7 @@ void smp_prepare_cpus(unsigned int maxcpus)
 		set_cpu_possible(i, true);
 
 	set_cpu_online(me, true);
-	cpu_set(me, cpu_callin_map);
+	cpumask_set_cpu(me, &cpu_callin_map);
 
 	err = os_pipe(cpu_data[me].ipi_pipe, 1, 1);
 	if (err < 0)
@@ -127,11 +127,11 @@ void smp_prepare_cpus(unsigned int maxcpus)
 		init_idle(idle, cpu);
 
 		waittime = 200000000;
-		while (waittime-- && !cpu_isset(cpu, cpu_callin_map))
+		while (waittime-- && !cpumask_test_cpu(cpu, &cpu_callin_map))
 			cpu_relax();
 
 		printk(KERN_INFO "%s\n",
-		       cpu_isset(cpu, cpu_calling_map) ? "done" : "failed");
+		       cpumask_test_cpu(cpu, &cpu_calling_map) ? "done" : "failed");
 	}
 }
 
@@ -142,7 +142,7 @@ void smp_prepare_boot_cpu(void)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	cpu_set(cpu, smp_commenced_mask);
+	cpumask_set_cpu(cpu, &smp_commenced_mask);
 	while (!cpu_online(cpu))
 		mb();
 	return 0;
-- 
2.1.0


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

