Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wndI-0000Za-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 11:54:32 -0700
Received: from ogi.bezeqint.net ([192.115.106.14])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wndH-00076p-K2
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 11:54:31 -0700
Message-ID: <3F5E231C.109@bezeqint.net>
From: Etay Meiri <etay-m@bezeqint.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Child exit when booting uml 2.4.20 on 2.6.0-test4
 host
References: <3F59DC82.7070900@bezeqint.net> <200309081647.h88Glrjh030128@ccure.karaya.com>
In-Reply-To: <200309081647.h88Glrjh030128@ccure.karaya.com>
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
Date: Tue, 09 Sep 2003 21:59:40 +0300
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> etay-m@bezeqint.net said:
> 
>>Mounting local filesystems:  Child 15433 exited with signal 11 
> 
> 
> Try it with the latest patch.  It should be fixed - I applied a different
> fix from the one suggested by Michael Young.
> 
> 				Jeff
> 
> 

I tried it with patch 2.6.0-test3-1 (from Aug 15). Isn't that
the latest one?


-- 
--------------------------------
Etay Meiri
etay-m@bezeqint.net
--------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
