Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhZOF-0005L7-RG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 11:12:19 -0800
Received: from thebsh.namesys.com ([212.16.7.65])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AhZOF-00021Q-8D for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 11:12:19 -0800
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16392.14211.847713.994092@laputa.namesys.com>
Subject: [uml-devel] [PATCH]: arch/um/os-Linux/process.c:os_usr1_process()
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
Date: Fri, 16 Jan 2004 22:12:03 +0300
To: Jeff Dike <JDike@Karaya.COM>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello,

to compile 2.6.1 UML on the host kernel without tkill (for example,
2.4.21, that I use), I need the following patch (not sure it is right
one):

----------------------------------------------------------------------
diff -puN arch/um/os-Linux/process.c~uml-use-tkill-conditionally.diff arch/um/os-Linux/process.c
--- lobby/arch/um/os-Linux/process.c~uml-use-tkill-conditionally.diff	Fri Jan 16 20:21:34 2004
+++ lobby-nikita/arch/um/os-Linux/process.c	Fri Jan 16 20:21:34 2004
@@ -93,8 +93,11 @@ void os_kill_process(int pid, int reap_c
 
 void os_usr1_process(int pid)
 {
+#if defined(__NR_tkill)
 	syscall(__NR_tkill, pid, SIGUSR1); 
-	/* kill(pid, SIGUSR1); */
+#else
+	kill(pid, SIGUSR1);
+#endif
 }
 
 int os_getpid(void)

_
----------------------------------------------------------------------

Nikita.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
