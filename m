Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wWh7-00085h-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 17:49:21 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19wWh6-00009L-Eu
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Sep 2003 17:49:20 -0700
Message-ID: <3F5D2369.9090704@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch
References: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com>
In-Reply-To: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 08 Sep 2003 20:48:41 -0400
To: Adam Heath <adam@doogie.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Adam Heath wrote:
> All these combinations had this problem.  However, Host 2.4.21-1um, UML
> 2.4.20-6um and host 2.4.22, UML 2.4.20-6um ran fine.

I'd bet the mmap stuff broke it - I was going to try to back out the v3 
COW stuff and mmap, but I figured that was basically -6um anyway ;-)

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
