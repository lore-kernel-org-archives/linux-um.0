Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADClr-0007It-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 17:59:11 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ADCjw-0003CS-VD
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 24 Oct 2003 17:57:13 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9P0jUj17711
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 20:45:30 -0400
Message-Id: <200310250102.h9P12WaK003944@ccure.karaya.com>
Subject: Re: [uml-devel] Re: Valgrind meets UML 
In-Reply-To: Your message of "Fri, 24 Oct 2003 10:22:03 +0200."
             <Pine.LNX.4.44.0310241018400.24620-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0310241018400.24620-100000@filer.marasystems.com> 
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
Date: Fri, 24 Oct 2003 21:02:32 -0400
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Giovanni Marzot <gmarzot@nortelnetworks.com>, user-mode-linux-devel@lists.sourceforge.net, jeremy@goop.org

hno@marasystems.com said:
> Which alone should trap some stupid mistakes with uninitialized
> variables, even if the memory allocation/deallocation integration is
> not set yet so  it it not totally fruitless.

In the small amount of testing I did (boot up tomsrtbt and halt it), it didn't
find anything real.  It found some structures that I was passing into system
calls that were incompletely initialized (because it didn't make sense to
initialize some fields or because there was a union in it and the code was
using one of the smaller arms), and a few similar things.

It's going to require more extensive of UML under valgrind to start finding
bugs.

> It should also allow for the cachegrind mode, which some people might
> find useful. 

Cachegrind would be particularly interesting, and cache behavior along a
particular code path would be interesting to people, so this wouldn't
necessarily need a real workload to be useful.

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
