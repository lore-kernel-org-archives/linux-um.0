Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW1cV-0003m3-TH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 16:27:35 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BW1cV-0001Zi-36 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 16:27:35 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BW1cS-0007h6-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 04 Jun 2004 01:27:32 +0200
Received: from pd9e58e6d.dip.t-dialin.net ([217.229.142.109])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 04 Jun 2004 01:27:32 +0200
Received: from skoehler by pd9e58e6d.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 04 Jun 2004 01:27:32 +0200
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c9oc52$a3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [BUG] "too many open files" when using hostfs
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
Date: Fri, 04 Jun 2004 01:27:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net

hi,

i mounted the directory /usr/portage from my host into my UML-machine 
(also to /usr/portage). The directory is mounted read-only. After that, 
i did "emerge -upD world" which must have accessed many many files. 
emerge crashed with the exception "too many open files" and indeed, the 
processes inside the UML cannot open any file anymore.

If i do an "lsof" on the host, i see that the kernel-process has still 
opened many many files from /usr/portage - too many files ;-)

So this should be bug in hostfs, so that hostfs doesn't close files on 
the host if they are closed inside the UML. Is there a fix for that already?

Thx
   Sven



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
