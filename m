Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Werner Almesberger <werner@almesberger.net>
Message-ID: <20040305100144.E26293@almesberger.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
Subject: [uml-devel] hack: avoid "Registered protocol family 2" hang
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
Date: Fri, 5 Mar 2004 10:01:44 -0300
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net



--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've attached a little hack that should make the hang after
NET: Registered protocol family 2
disappear. This isn't the real solution (haven't yet figured
out how this is truly supposed to work on non-SMP), but it 
gives me a happier UML :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

--- linux-2.6.1-orig/arch/um/kernel/time_kern.c	2004-03-05 13:37:14.638203216 +0100
+++ linux-2.6.1/arch/um/kernel/time_kern.c	2004-03-05 13:14:03.159740096 +0100
@@ -172,6 +172,7 @@
 	update_process_times(user_context(UPT_SP(regs)));
 	local_irq_enable();
 #endif
+	update_process_times(user_context(UPT_SP(regs)));
 	if(current_thread->cpu == 0)
 		timer_irq(regs);
 }

--CUfgB8w4ZwR/yMy5--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
