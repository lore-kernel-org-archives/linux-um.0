Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9vpm-000334-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 17:17:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9vpl-00055L-5t
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 15 Oct 2003 17:17:41 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9G06ij15207
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 20:06:44 -0400
Message-Id: <200310160021.h9G0LO4f029716@ccure.karaya.com>
In-Reply-To: Your message of "Wed, 15 Oct 2003 21:16:02 +0200."
             <200310152116.02073.blaisorblade_spam@yahoo.it> 
References: <200310152116.02073.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH] UML is not consistent with other ARCH's about errno
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
Date: Wed, 15 Oct 2003 20:21:24 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> I posted this patch some time ago, but it was hidden inside an
> unrelated  thread, then it seemed not to be noticed. So I'll repost it
> forever, like if  this were the main LKML.

Don't bother, I saved the first copy you sent.

> On the i386 arch(and I think others, too) the translation from  return
> value(of calls like open(), fork()...) to errno setting is done in
> include/asm-i386/unistd.h. 

This looks reasonable, but I'm going to stare at it some more before merging
it.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
