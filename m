Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uxWr-00072G-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 10:04:17 -0700
Received: from dhcp47.ists.dartmouth.edu ([129.170.249.147] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19uxWp-0007nr-Kk
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 10:04:15 -0700
Message-Id: <200309041709.h84H9D74016587@uml.karaya.com>
Subject: Re: [uml-devel] Kernel panic: Kernel mode fault at addr 0x0, ip 0x8053457 
In-Reply-To: Your message of "Wed, 20 Aug 2003 15:54:54 +1000."
             <200308201554.54799.russell@coker.com.au> 
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
Date: Thu, 04 Sep 2003 13:09:12 -0400
To: russell@coker.com.au
Cc: user-mode-linux-devel@lists.sourceforge.net

russell@coker.com.au said:
> On http://www.coker.com.au/bug/ls.gz I have a compressed version of ls
> for  i386 that causes a reliable UML crash on 2.6.0test3 with the
> latest test3 UML  patch. 

Could you make a statically linked version of it so I don't have to figure
out where to get the libraries it needs?

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
