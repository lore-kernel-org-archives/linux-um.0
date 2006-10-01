Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU2yi-00082r-Qv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:11:40 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GU2yf-0006m2-7k
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:11:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 1 Oct 2006 17:08:45 +0200
References: <451E9BAB.5030009@linuxbox.cz> <451F0985.4090100@linuxbox.cz>
	<451F0FAA.2090402@linuxbox.cz>
In-Reply-To: <451F0FAA.2090402@linuxbox.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9n9HFNmI4Bw2Rkz"
Message-Id: <200610011708.45909.blaisorblade@yahoo.it>
Subject: Re: [uml-devel]
	=?iso-8859-1?q?SKAS_mode_not_working=2C_x86=5F64_SMP_?=
	=?iso-8859-1?q?host=2C_x86=5F64=09guest_=2C_problems_with_noprocmm?=
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>

--Boundary-00=_9n9HFNmI4Bw2Rkz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 01 October 2006 02:45, Nikola Ciprich wrote:
> Jeff,
> I'm terribly sorry, please ignore previous two emails. Problem was not
> in UML itself, but in my scripts, as it happened that I was running it
> with setarch i386, which caused guest uml report i386 architecture, and
> it made quite a mess when I was testing it...
> once again I'm sorry, I guess I really should rather have some sleep :(
> n.

> PS: but anyways, I wonder, is this behavior bug or feature? that running
> x86_64 uml using setarch i386 then causes guest UML report i686 arch?
> (even it's still x86_64)

It is a bug. Under setarch i386, uname returns i686; however, UML should 
correct this. A 32bit UML says i686 on a 64bit host. Patch attached 
(compile-tested).
Please report whether it works or not.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_9n9HFNmI4Bw2Rkz
Content-Type: text/x-diff; charset="iso-8859-1";
	name="fix-uname-under-setarch-i386"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-uname-under-setarch-i386"

Index: linux-2.6.git/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.git.orig/arch/um/os-Linux/util.c
+++ linux-2.6.git/arch/um/os-Linux/util.c
@@ -81,11 +81,18 @@ void setup_machinename(char *machine_out
 	struct utsname host;
 
 	uname(&host);
-#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
+#ifdef UML_CONFIG_UML_X86
+# ifndef UML_CONFIG_64BIT
 	if (!strcmp(host.machine, "x86_64")) {
 		strcpy(machine_out, "i686");
 		return;
 	}
+# else
+	if (!strcmp(host.machine, "i686")) {
+		strcpy(machine_out, "x86_64");
+		return;
+	}
+# endif
 #endif
 	strcpy(machine_out, host.machine);
 }

--Boundary-00=_9n9HFNmI4Bw2Rkz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_9n9HFNmI4Bw2Rkz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_9n9HFNmI4Bw2Rkz--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

