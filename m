Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9aDd-00083x-RH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 19:17:25 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1C9aDb-00026z-5x
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 19:17:24 -0700
Message-Id: <200409210321.i8L3LgdR015667@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Managing 2.6 merge - url for the patches sent to
	merge 
In-Reply-To: Your message of "Mon, 20 Sep 2004 20:30:49 +0200."
	<200409202030.49422.blaisorblade_personal@yahoo.it> 
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<200409191338.12871.blaisorblade_personal@yahoo.it>
	<878yb51drm.fsf@bytesex.org>
	<200409202030.49422.blaisorblade_personal@yahoo.it> 
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
Date: Mon, 20 Sep 2004 23:21:42 -0400
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

blaisorblade_personal@yahoo.it said:
> Don't use uml-use-va_end.patch, it breaks UML on rebooting. 

How?  That patch looks completely safe to me.

Rebooting is broken (in tt mode anyway) because the file lock on the root
ubd file descriptor isn't dropped.  Mysteriously, setting that descriptor
CLOEXEC doesn't seem to help.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
