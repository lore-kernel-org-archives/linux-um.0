Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wiH5-0005Gw-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 06:11:15 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wiH3-0002nx-7t
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 06:11:13 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h89D3Mj09565
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 9 Sep 2003 09:03:24 -0400
Message-Id: <200309091310.h89DAo2J002530@ccure.karaya.com>
Subject: Re: [uml-devel] UML 2.4.22-2 Compile Problem 
In-Reply-To: Your message of "Mon, 08 Sep 2003 20:50:52 BST."
             <20030908195052.GA20529@roadrunner.ichilton.net> 
References: <20030908195052.GA20529@roadrunner.ichilton.net> 
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
Date: Tue, 09 Sep 2003 09:10:50 -0400
To: Ian Chilton <ian@ichilton.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

mailinglist@ichilton.co.uk said:
> arch/um/main.o(.text.init+0x2): In function `do_uml_initcalls': :
> undefined reference to `__uml_initcall_start' 

You botched the build.  Do an mrproper and rebuild it.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
