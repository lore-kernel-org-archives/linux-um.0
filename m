Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xVWa-00028A-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 10:46:33 -0700
Received: from dhcp71.ists.dartmouth.edu ([129.170.249.171] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xVWa-00060v-Bw
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 10:46:32 -0700
Message-Id: <200309111752.h8BHqEFw010093@uml.karaya.com>
Subject: Re: [uml-devel] uml-patch-2.4.22-3 
In-Reply-To: Your message of "Thu, 11 Sep 2003 16:24:33 +0200."
             <22298.193.212.97.12.1063290273.squirrel@pluto.nixia.no> 
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
Date: Thu, 11 Sep 2003 13:52:13 -0400
To: stian@nixia.no
Cc: user-mode-linux-devel@lists.sourceforge.net

stian@nixia.no said:
> Just saw a little detail. If clone() fails in io_start_thread in
> ubd_user.c, *fd (thread_fd in caller) is given a value, when it should
> close the pipe and don't touch *fd 

Looks good, I might restructure that a bit.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
