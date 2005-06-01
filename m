Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdWzY-0002Ts-PL	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:26:56 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DdWzX-00053l-2L	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:26:56 -0700
Message-Id: <200506011710.j51HA6rP011968@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1 
In-Reply-To: Your message of "Tue, 31 May 2005 16:01:17 PDT."
             <s29c8a5a.087@ORANGE.OUS.EDU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 01 Jun 2005 13:10:06 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Anthony_Brock@ous.edu said:
> fixdep: arch/um/sys-i386/.stub_segv.o.d: No such file or directory
> make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 2
> make: *** [arch/um/sys-i386] Error 2

I don't understand this at all, but rerunning the build gives me a good UML.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
