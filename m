Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACsTL-00088a-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 20:18:43 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACqFm-0008KH-En
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 17:56:34 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9O0isj04359
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 20:44:55 -0400
Message-Id: <200310240101.h9O11hmN006339@ccure.karaya.com>
Subject: Re: [uml-devel] Re: Valgrind meets UML 
In-Reply-To: Your message of "Thu, 23 Oct 2003 10:40:09 EDT."
             <3F97E849.1090700@nortelnetworks.com> 
References: <3F97E849.1090700@nortelnetworks.com> 
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
Date: Thu, 23 Oct 2003 21:01:43 -0400
To: Giovanni Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, jeremy@goop.org

gmarzot@nortelnetworks.com said:
> Any words of wisdom appreciated. Has anyone used this combination
> succesfully?

I ran out of free time about a year ago when playing with this, but I did
have UML and Valgrind playing together.

> I wonder what "teaching valgrind about the false positives" entails. 

However, I didn't get anything useful out of it.  This is because Valgrind
knows nothing about the kernel memory allocators.  I started describing them,
but didn't get too far.

IIRC, you add special macros into the allocators when the status of a region
of memory changes.  I.e.
	a buffer being returned from an allocator is declared readable and 
writeable
	a buffer being freed is declared unreadable and unwriteable (or maybe
just inaccessible, I forgot)

These macros expand into different sequences of noops which are recognized
by Valgrind, which is a cute trick.

You've found the UML config changes needed for Valgrind.  If Valgrind itself
has the changes that Jeremy and I made, then you should be all set to at
least run UML under it.

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
