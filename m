Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ3jR-0003Ii-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 20:32:53 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ3jQ-0000Fa-Bp
	for User-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 20:32:52 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hAA4Jg120629
	for <User-mode-linux-devel@lists.sourceforge.net>; Sun, 9 Nov 2003 23:19:43 -0500
Message-Id: <200311100440.hAA4eWxD013278@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml failes to build with pcap enabled 
In-Reply-To: Your message of "Tue, 30 Sep 2003 23:51:35 +0200."
             <045401c3879d$06745b90$6f01a8c0@alex> 
References: <045401c3879d$06745b90$6f01a8c0@alex> 
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
Date: Sun, 09 Nov 2003 23:40:32 -0500
To: Alexander Newald <alexander@newald.de>
Cc: User-mode-linux-devel@lists.sourceforge.net

alexander@newald.de said:
> I've tried to use uml with pcap but I fail to build the linux binary. 

Can you try with -6 when it comes out?  I haven't seen that problem here,
but I cleaned up that build a little to make it go away.

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
