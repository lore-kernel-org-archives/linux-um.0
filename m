Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbTYY-0007hf-Bj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 17:18:02 -0700
Received: from ns.theshore.net ([216.156.129.65] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbTYX-0006Es-VU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 17:18:02 -0700
Received: from hawk (pcp08670149pcs.500ash01.tn.comcast.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id i5J0I02n014663
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 18 Jun 2004 20:18:00 -0400
Message-ID: <000f01c45593$35c20e00$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel panic: handle_trap - failed to wait at end of
	syscall, errno = 4, status = 1151
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
Date: Fri, 18 Jun 2004 19:19:57 -0500
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hey all,

I just had a user experience this panic:

Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4, status =
1151

UML: 2.6.5 vanilla + uml-patch-2.6.4-1
HOST: 2.6.4 + SKAS patch

From arch/um/kernel/skas/process.c:

        err = waitpid(pid, &status, WUNTRACED);
        if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
                panic("handle_trap - failed to wait at end of syscall, "
                      "errno = %d, status = %d\n", errno, status);

Any thoughts?  I've never seen this before...

-Chris



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
