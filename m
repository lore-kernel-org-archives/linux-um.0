Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AIw8d-00080H-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 12:26:23 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AIw8d-0004BS-2e
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 12:26:23 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA9KDI116941
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 9 Nov 2003 15:13:18 -0500
Message-Id: <200311092034.hA9KY5xD011971@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] __pa() in modules requres to_phys to be exported 
In-Reply-To: Your message of "Sun, 12 Oct 2003 00:04:11 +0200."
             <Pine.LNX.4.44.0310120002150.14937-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0310120002150.14937-100000@filer.marasystems.com> 
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
Date: Sun, 09 Nov 2003 15:34:05 -0500
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

hno@marasystems.com said:
> af_packet uses __pa() and thus requires the to_phys symbol to be
> exported (__pa() is a macro in um, expanding to a call to to_phys) 

Thanks.  to_virt was already there, so I guess that was an oversight.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
