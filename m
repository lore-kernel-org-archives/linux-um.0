Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6jYt-0006hK-6a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 22:11:51 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D6jYs-0004C0-IX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 22:11:51 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Triage on the pending patches
References: <200503030822.j238MoBY016825@ccure.user-mode-linux.org>
In-Reply-To: <200503030822.j238MoBY016825@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503030008.51336.rob@landley.net>
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
Date: Thu, 3 Mar 2005 00:08:51 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>

On Thursday 03 March 2005 03:22 am, Jeff Dike wrote:
> Since 2.6.11 is out, it's time to decide what patches go into mainline
> first.
>
> Here's my cut:

Well, just in case your job was too easy, here's one more.  Using the
"quiet" option shows a couple of lines being printed out by printf that
should be printed out by printk (so they'll _shut_up_ when you ask it to).

signed-off-by: Rob Landley

diff -ru linux-2.6.10/arch/um/kernel/mem_user.c linux-2.6.10-new/arch/um/kernel/mem_user.c
--- linux-2.6.10/arch/um/kernel/mem_user.c	2005-02-15 08:16:48.000000000 -0600
+++ linux-2.6.10-new/arch/um/kernel/mem_user.c	2005-02-17 05:06:25.000000000 -0600
@@ -88,8 +88,8 @@
 
 	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
 		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
-	printf("Checking PROT_EXEC mmap in /tmp...");
-	fflush(stdout);
+	/* Honor "quiet" option */
+	printk("Checking PROT_EXEC mmap in /tmp...");
 	if(addr == MAP_FAILED){
 		err = errno;
 		perror("failed");
@@ -97,7 +97,7 @@
 			printf("/tmp must be not mounted noexec\n");
 		exit(1);
 	}
-	printf("OK\n");
+	printk("OK\n");
 	munmap(addr, UM_KERN_PAGE_SIZE);
 
 	os_close_file(fd);
diff -ru linux-2.6.10/arch/um/kernel/tt/tracer.c linux-2.6.10-new/arch/um/kernel/tt/tracer.c
--- linux-2.6.10/arch/um/kernel/tt/tracer.c	2005-02-15 08:16:49.000000000 -0600
+++ linux-2.6.10-new/arch/um/kernel/tt/tracer.c	2005-02-17 05:04:57.000000000 -0600
@@ -192,7 +192,7 @@
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
 	tracing_pid = os_getpid();
-	printf("tracing thread pid = %d\n", tracing_pid);
+	printk("tracing thread pid = %d\n", tracing_pid);
 
 	pid = clone(signal_tramp, sp, CLONE_FILES | SIGCHLD, init_proc);
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));


> The skas0 stuff needs more baking.  The os-dependent code movement I'm
> going to sit on until we have it all in hand and can clean it up.

I'm very interested in this (since I want to run UML on an unmodified host
and TT mode means a gcc compile under UML has 2/3 of the CPU usage
accounted to "system" instead of "user".  Unfortunately, I can't find out
where to go for more information.  (Every time I'm pointed at your huge
patch list I drown in x86-64 patches.  Possibly breaking out the ones that
ONLY affect a specific architecture or at least clearly marking them would
be good...)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
