Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zikI-0002o2-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 13:17:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zikG-0000eN-Jx
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 13:17:48 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8HK9Gj03232
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 16:09:17 -0400
Message-Id: <200309172018.h8HKIjNu020871@ccure.karaya.com>
In-Reply-To: Your message of "Tue, 16 Sep 2003 17:28:54 BST."
             <Pine.GSO.4.53.0309161720480.4325@algedi.dur.ac.uk> 
References: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk> <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk>  <Pine.GSO.4.53.0309161720480.4325@algedi.dur.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: uml segfaults on redhat beta "severn"
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
Date: Wed, 17 Sep 2003 16:18:45 -0400
To: M A Young <m.a.young@durham.ac.uk>
Cc: User-mode-linux-devel@lists.sourceforge.net

m.a.young@durham.ac.uk said:
> The exec-shield code appears to have been modified in the latest
> redhat beta kernel with the result that uml kernels no longer crash -
> presumably the memory allocations aren't stirred up quite so much.
> Hence patching this problem may now be unnecessary. 

Excellent.  I looked at mingo's original description briefly, and didn't see
anything which would obviously break UML.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
