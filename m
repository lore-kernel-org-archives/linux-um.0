Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfPr0-0002ES-Vp for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Jan 2004 12:37:06 -0800
Received: from tektonic.net ([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AfPr0-00059D-Hc for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Jan 2004 12:37:06 -0800
From: Matt Ayres <matta@tektonic.net>
Content-Type: text/plain
Message-Id: <1073767023.5714.6.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] ubd=mmap hang during boot
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
Date: Sat, 10 Jan 2004 15:37:04 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I've never been able to get ubd=mmap to work properly, however after
sitting down and trying to get it working I have some doubts if the
problem is user error now.

I am using 2.4.24 with the 2.4.23-1um patch.  I have also tried this
with 2.4.23.  I've built the kernel and it functions without problems.

When I start a UML with the "ubd=mmap" option it hangs at the beginning
of init.  On a RedHat 9 server it displays the following and then hangs
forever:

VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
INIT: version 2.84 booting
                Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.

Under a Debian server it is very similiar.   What information is needed
from me so to assist the developers is debugging this behavior?



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
