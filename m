Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wiHJ-0005JJ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 06:11:29 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wiHH-00038m-T5
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 06:11:28 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h89D3ej09584
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 9 Sep 2003 09:03:40 -0400
Message-Id: <200309091310.h89DAt2J002539@ccure.karaya.com>
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch 
In-Reply-To: Your message of "Mon, 08 Sep 2003 19:38:55 CDT."
             <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com> 
References: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com> 
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
Date: Tue, 09 Sep 2003 09:10:55 -0400
To: Adam Heath <adam@doogie.org>
Cc: David Coulson <david@davidcoulson.net>, user-mode-linux-devel@lists.sourceforge.net

adam@doogie.org said:
> All these combinations had this problem.  However, Host 2.4.21-1um,
> UML 2.4.20-6um and host 2.4.22, UML 2.4.20-6um ran fine. 

I've been playing with this quite a bit and I can't make it misbehave.  So,
I need some clues as to what you're doing that I'm not.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
