Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ya6Y-0005zk-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 09:52:06 -0700
Received: from bay7-f54.bay7.hotmail.com ([64.4.11.54] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ya6X-0003k6-Tz
	for User-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 09:52:05 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] uml-patch-2.4.22-4
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F54n3c6xpwW35B0000883e@hotmail.com>
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
Date: Sun, 14 Sep 2003 16:51:35 +0000
To: david@davidcoulson.net
Cc: User-mode-linux-devel@lists.sourceforge.net

david@davidcoulson.net
>+               if(n < 0) return(n)
>+               return(-EIO);
>
>Someone, er, missed off a ; :-)

Whoops me. and not only once:

tty_log.c:log_chunk() and harddog_user.c:ping_watchdog().

I didn't have either option on in my .config.  I'll re-audit what I did.

Steve

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*   
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
