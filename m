Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uw4f-0002eI-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 08:31:05 -0700
Received: from dhcp47.ists.dartmouth.edu ([129.170.249.147] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19uw4a-00058b-9l
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 08:31:00 -0700
Received: from uml.karaya.com (uml.karaya.com [127.0.0.1])
	by uml.karaya.com (8.12.5/8.12.5) with ESMTP id h84Fa3P4013687
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 4 Sep 2003 11:36:03 -0400
Received: from uml.karaya.com (jdike@localhost)
	by uml.karaya.com (8.12.5/8.12.5/Submit) with ESMTP id h84Fa3f8013683
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 4 Sep 2003 11:36:03 -0400
Message-Id: <200309041536.h84Fa3f8013683@uml.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] host-skas3a-RH8.patch
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
Date: Thu, 04 Sep 2003 11:36:03 -0400
To: user-mode-linux-devel@lists.sourceforge.net

There have been a number of requests for skas patches for RH kernels.  Since
I did skas3 for RH8 a while ago, I have that lying around, and got around
to releasing it.

It's basically the same as the current skas3 patch, except for a fix which
allows a !CONFIG_PROC_MM kernel to build, hence the 'a' in the name.

Get it at the usual place.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
