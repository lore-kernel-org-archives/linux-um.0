Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ0eT-0004Wp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 17:15:33 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ0eS-0006G0-Fa
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 17:15:32 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hAA12P119132
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 9 Nov 2003 20:02:26 -0500
Message-Id: <200311100123.hAA1N6xD012768@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] compile error with 2.4.22-uml4 and 2.4.23-pre4-djc2-4um 
In-Reply-To: Your message of "Tue, 16 Sep 2003 13:29:39 CDT."
             <200309161329.39725.user-mode-linux-devel@goldenspud.com> 
References: <200309161329.39725.user-mode-linux-devel@goldenspud.com> 
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
Date: Sun, 09 Nov 2003 20:23:06 -0500
To: "Matthew R. Scott" <user-mode-linux-devel@goldenspud.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

user-mode-linux-devel@goldenspud.com said:
> When I look at line 41, 42, and 43 in arch/um/include/os.h though,
> there  doesn't seem to be any sort of problems.  Those lines are in
> the middle of a  perfectly valid-looking struct. 

This should be fixed now.  The problem was that those field names were
#defined in a header to be something else.

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
