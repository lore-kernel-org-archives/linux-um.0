Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6iNC-000891-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 20:18:54 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6iNB-0002Vc-LY
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 20:18:54 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9738hj10090
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 23:08:43 -0400
Message-Id: <200310070320.h973KnGj022034@ccure.karaya.com>
Subject: Re: [uml-devel] unkillable UML threads 
In-Reply-To: Your message of "Mon, 06 Oct 2003 21:09:05 EDT."
             <3387.1065488945@marajade.sandelman.ottawa.on.ca> 
References: <3387.1065488945@marajade.sandelman.ottawa.on.ca> 
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
Date: Mon, 06 Oct 2003 23:20:49 -0400
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net, hugh@mimosa.com, Matt Zimmerman <mdz@debian.org>

mcr@sandelman.ottawa.on.ca said:
> Again, if any process becomes unkillable on *nix system, there is at
> *least* a bug in the kernel.

No.  At least not in this case, since the process is quite killable.  It
just needs a SIGCONT before it actually dies.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
