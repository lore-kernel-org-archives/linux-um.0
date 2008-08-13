Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTLBq-0005sC-2w for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 11:35:22 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KTLBo-0006t4-Ro
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 11:35:22 -0700
Received: from vandebo (helo=localhost)
	by abydos.NerdBox.Net with local-esmtp (Exim 4.67)
	(envelope-from <vandebo-uml@NerdBox.Net>) id 1KTLBo-0002dH-8U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Aug 2008 11:35:20 -0700
Date: Wed, 13 Aug 2008 11:35:20 -0700 (PDT)
From: Steve VanDeBogart <vandebo-uml@NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808131118490.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] get_wchan() can return incorrect results
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Another problem detected by running UML under Valgrind;  UML implements
a architecture independent version of get_wchan() in arch/um/kernel/process.c
It examines each word on the stack, looking for the first one that 
appears to be a non-scheduler instruction pointer.  Other architectures
are more precise, doing things like finding the base pointer and only 
examining the value that should be the return address.

The UML version seems reasonable except that some values on the stack
may not be initialized and will therefore have a random value, possibly
a return address from a previous function call.

The value of get_wchan() is exported to userspace in proc, so it's not 
clear to me how important it is to get this value right.

--
Steve


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
