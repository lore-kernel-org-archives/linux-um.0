Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EDlgM-0002dD-Dr	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Sep 2005 09:24:54 -0700
Received: from rwcrmhc12.comcast.net ([204.127.198.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EDlgH-0001DU-6v
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Sep 2005 09:24:51 -0700
From: Christopher Faylor <me@cgf.cx>
Message-ID: <20050909162442.GA11934@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] NPTL status?
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
Date: Fri, 9 Sep 2005 12:24:42 -0400
To: user-mode-linux-devel@lists.sourceforge.net

As I understand it NPTL support in UML is still a work in progress.  Is
this correct?  If so, is there an experimental patch set which works
better with NPTL and might allow things like RHEL4 to boot
out-of-the-box?

I am currently using a 2.6.12 guest kernel with RH9 rootfs and have
moved things around in /lib so as to avoid problems with NPTL but
I was hoping that there might be some improvements which would allow
me to use later versions of glibc without modification.

Is this possible?

cgf


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
