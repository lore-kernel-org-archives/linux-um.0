Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AIb0c-0005vj-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 08 Nov 2003 13:52:43 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AIb0c-0007Wk-9Q
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 08 Nov 2003 13:52:42 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA8Ldf103552
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 8 Nov 2003 16:39:42 -0500
Message-Id: <200311082200.hA8M0EiR003062@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 30 Oct 2003 17:05:00 +0100."
             <20031030160500.GC19575@bytesex.org> 
References: <20031030155757.GA19575@bytesex.org>  <20031030160500.GC19575@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [patch] serial console support
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
Date: Sat, 08 Nov 2003 17:00:14 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

kraxel@bytesex.org said:
> This patch adds serial console support to the uml virtual serial
> lines. 

Applied, how do you test it?

BTW, it would be good to take this code, and merge it with its twin in 
stdio_console.c into line.c.  Those drivers are nearly identical, and this
patch makes them more so.

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
