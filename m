Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yYaU-0000ia-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 08:14:54 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19yYaU-0001UP-Ax
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 08:14:54 -0700
Message-ID: <3F6485EA.5040609@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml-patch-2.4.22-4
References: <200309140317.h8E3H2e4008178@ccure.karaya.com>
In-Reply-To: <200309140317.h8E3H2e4008178@ccure.karaya.com>
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
Date: Sun, 14 Sep 2003 11:14:50 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> This is a major cleanup patch.  It's mostly due to Steve Schmidtke, the 
> wild and wacky guy who brought sound support to UML.  He seems to be taking
> his medications more consistently now, with the result that he sent in a 
> comparatively sane patch which makes UML make much better use of the os_* 
> interfaces.

+               if(n < 0) return(n)
+               return(-EIO);

Someone, er, missed off a ; :-)

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
