Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AIeeH-0002ya-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 08 Nov 2003 17:45:53 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AIeeG-0007Qv-Mb
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 08 Nov 2003 17:45:52 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA91Wo105097
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 8 Nov 2003 20:32:51 -0500
Message-Id: <200311090153.hA91rRiR003443@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] remove duplicate #includes 
In-Reply-To: Your message of "Tue, 21 Oct 2003 18:59:06 EDT."
             <20031021225906.GB4471@rushmore> 
References: <20031021225906.GB4471@rushmore> 
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
Date: Sat, 08 Nov 2003 20:53:27 -0500
To: rwhron@earthlink.net
Cc: user-mode-linux-devel@lists.sourceforge.net

rwhron@earthlink.net said:
> Remove doubley #included headers files. 

Applied, thanks.

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
