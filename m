Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYiJD-00078Z-8z for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 02:26:47 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BYiJ2-00057W-Nm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 02:26:36 -0700
Message-ID: <1194.83.109.2.104.1086945968.squirrel@nepa.nlc.no>
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [uml-devel] Hi people. A kernel bug in the vanilla kernel
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
Date: Fri, 11 Jun 2004 11:26:08 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

I'm currently on a small vaccation so I'm quite limited in Internett
connection and alike. I come across a kernel-bug in 2.4.x and 2.6.x
kernels and wondered if the same problemes occures inside UML. Could
somebody just take a small peek?


http://marc.theaimsgroup.com/?l=linux-kernel&m=108681568931323&w=2
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905


Simple compile the small program that is in the report on the gcc bugzilla
system and run it inside UML and see if runs or freezes the UML.



Stian Skjelstad


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
