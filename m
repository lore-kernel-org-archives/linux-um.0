Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2U3a-00066O-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 04:13:10 -0700
Received: from [202.155.84.178] (helo=ns1.its-sby.edu)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2U3X-0007wt-HB
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 04:13:08 -0700
Message-ID: <40929.10.126.13.181.1064488183.squirrel@202.155.84.178>
From: <kooper@inf.its-sby.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] (no subject)
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
Date: Thu, 25 Sep 2003 18:09:43 -0700 (WIT)
To: user-mode-linux-devel@lists.sourceforge.net

i knew that in skas mode there is one thread that used as userspace
and switch processes (processes is traced by UML kernel). What i need to
know is how process that is traced by UML is stopped when entering in kernel
mode which is triggered by signal handling in UML kernel. Or process still
running while executing signal handler..
I dont know in which code i could find that...

Thank,
Eddy




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
