Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADDAt-0001FS-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 18:25:03 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ADD7F-0004Oc-A6
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 24 Oct 2003 18:21:18 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9P19Yj18086
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 21:09:34 -0400
Message-Id: <200310250126.h9P1QfaK004048@ccure.karaya.com>
Subject: Re: [uml-devel] uml_switch 
In-Reply-To: Your message of "Thu, 23 Oct 2003 11:46:28 -0300."
             <20031023144628.88438.qmail@web20209.mail.yahoo.com> 
References: <20031023144628.88438.qmail@web20209.mail.yahoo.com> 
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
Date: Fri, 24 Oct 2003 21:26:41 -0400
To: =?iso-8859-1?q?Nelio=20Pereira?= <nelio_pereira@yahoo.com.br>
Cc: Nuno Silva <nuno.silva@vgertech.com>, user-mode-linux-devel@lists.sourceforge.net

nelio_pereira@yahoo.com.br said:
> The code itself doesn't seem very complicated. I just would like to
> know how a message is transmited to its recipient, then I could
> intercept this message in the right place. 

As Matt said, this is an Ethernet switch, and as such, knows nothing about
IP.  The stuff inside the frames may not even be IP.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
