Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aicky-0001wG-7b for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 09:00:08 -0800
Received: from pool-141-154-56-2.bos.east.verizon.net ([141.154.56.2]
	helo=uml.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Aickx-0005e0-Oe
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 09:00:07 -0800
Received: from uml.user-mode-linux.org (uml.user-mode-linux.org [127.0.0.1])
	by uml.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id i0HFlQ0m009270
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 10:48:07 -0500
Received: from uml.user-mode-linux.org (jdike@localhost)
	by uml.user-mode-linux.org (8.12.5/8.12.5/Submit) with ESMTP id
	i0HFlPtk009266 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 10:47:26 -0500
Message-Id: <200401171547.i0HFlPtk009266@uml.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.23-2
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
Date: Sat, 17 Jan 2004 10:47:25 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This patch fixes a number of bugs including
	with ubd-mmap in force, device data remaining mapped after the device
was closed - this should fix the EBADF errors some people were seeing on UML
shutdown, it allows 2.6 to boot with ubd-mmap, and there's some potential that
it fixed file corruption.  Anyone who has been seeing ubd-mmap problems should
test this and let me know one way or the other.
	/dev/anon is now correctly checked for and used if it's available
	fixed the linker script to get rid of the segfaults seen with RH and
Fedora
	mhz is now a long long, so UML again will stop hanging on fast hosts
	lots of small changes to fix minor bugs, compilation problems, and
to reduce the number of diffs between the 2.4 and 2.6 trees

CVS hasn't been updated yet because SF is broken again.  I'll check everything
in when the CVS server is back up.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
