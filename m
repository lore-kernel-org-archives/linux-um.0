Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AN0nK-0007KL-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 18:13:14 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AN0nH-00054J-ED
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 18:13:11 -0800
Message-Id: <200311210222.hAL2Mt4L004145@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm 
In-Reply-To: Your message of "Thu, 20 Nov 2003 20:37:14 +0100."
             <200311202037.14480.blaisorblade_spam@yahoo.it> 
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311201956.39623.Frank.dekervel@student.kuleuven.ac.Be>  <200311202037.14480.blaisorblade_spam@yahoo.it> 
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
Date: Thu, 20 Nov 2003 21:22:55 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> I think hostfs reads files just as any normal process on the host,
> right? Or  it does anything special or at least unusual?

Nothing unusual, just normal file IO.

> Could the unusual thing be the context switching of SKAS? I'll test if
> it happens within TT mode. 

I doubt there's any difference.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
