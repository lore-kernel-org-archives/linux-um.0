Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGqxB-0001PW-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 03 Nov 2003 18:29:57 -0800
Received: from pool-151-203-5-11.bos.east.verizon.net ([151.203.5.11] helo=uml.karaya.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AGqx9-0002dL-Sz
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 03 Nov 2003 18:29:56 -0800
Message-Id: <200311021424.hA2EOpti019560@uml.karaya.com>
Subject: Re: [uml-devel] Sleeping process getting segfault signal 
In-Reply-To: Your message of "Sat, 01 Nov 2003 21:51:16 GMT."
             <Pine.GSO.4.58.0311012137370.355@altair.dur.ac.uk> 
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
Date: Sun, 02 Nov 2003 09:24:51 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

m.a.young@durham.ac.uk said:
> I have a reproduceable crash, at least with certain host kernels (eg.
> from RedHat's current beta), and a 2.6 uml kernel, and get errors like
> sleeping process 1786 got unexpected signal : 11 

I just saw this.  Looked at it a bit and am mystified :-)  Stay tuned...

				Jeff





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
