Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xT9l-0007US-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 08:14:49 -0700
Received: from dhcp71.ists.dartmouth.edu ([129.170.249.171] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xT9l-0000iq-6t
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 08:14:49 -0700
Received: from uml.karaya.com (uml.karaya.com [127.0.0.1])
	by uml.karaya.com (8.12.5/8.12.5) with ESMTP id h8BFKO8R008941
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 11:20:24 -0400
Received: from uml.karaya.com (jdike@localhost)
	by uml.karaya.com (8.12.5/8.12.5/Submit) with ESMTP id h8BFKNfA008937
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 11:20:24 -0400
Message-Id: <200309111520.h8BFKNfA008937@uml.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.22-3
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 11 Sep 2003 11:20:23 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This patch fixes the I/O operation mismatch panic, thanks to Oleg.

There were also some small cleanups and bug fixes.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
