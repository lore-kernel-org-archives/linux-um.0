Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHKBa-0006Kl-Pn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Apr 2004 03:15:02 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHKBa-0002bx-3B for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Apr 2004 03:15:02 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i3OAEwK03411
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Apr 2004 12:14:58 +0200
From: Henrik Nordstrom <hno@marasystems.com>
Message-ID: <Pine.LNX.4.44.0404241208240.3373-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] 2.4 hostfs no longer mounts specified directoryy
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
Date: Sat, 24 Apr 2004 12:14:57 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

Something seems to have changed in how hostfs parses the filesystem flags
option.  It no longer succeeds in specifying the location of the hostfs
directory and the uml instead always uses the host root (/).

Neither rootflags=/... for booting from hostfs or manual mount works. In 
both cases it always gives the host root (/), not the specified directory.

Using the current 2.4 CVS, ported to 2.4.26.

Was previously using the almost current 2.4 CVS (before humfs), ported to 
2.4.26-rc2 with no problem.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
