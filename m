Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2dZt-0004WC-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 14:23:09 -0700
Received: from dhcp121.ists.dartmouth.edu ([129.170.249.221] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A2dZs-0006F2-B3
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 25 Sep 2003 14:23:08 -0700
Message-Id: <200309252130.h8PLU47q003279@uml.karaya.com>
Subject: Re: [uml-devel] mounting filesystems - mount crashes 
In-Reply-To: Your message of "Thu, 25 Sep 2003 11:45:39 PDT."
             <20030925184539.19093.qmail@web60302.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 25 Sep 2003 17:30:04 -0400
To: Terry <td3201@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

td3201@yahoo.com said:
> Child 23701 exited with signal 11
> Any ideas on how to get around this?  It works if I put the mount
> command in rc.local but I need the filesystem way before that gets
> ran. 

This is fixed in recent patches.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
