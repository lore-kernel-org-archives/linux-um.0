Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5bYu-0007fy-3M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 19:54:56 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5bYS-0007dW-1s
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 19:54:36 -0700
Message-Id: <200409100355.i8A3tEg1005654@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML compile fix 
In-Reply-To: Your message of "Sat, 04 Sep 2004 09:55:23 +0200."
	<20040904075520.GA5799@atrey.karlin.mff.cuni.cz> 
References: <20040904075520.GA5799@atrey.karlin.mff.cuni.cz> 
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
Date: Thu, 09 Sep 2004 23:55:14 -0400
To: Jan Kara <jack@suse.cz>
Cc: user-mode-linux-devel@lists.sourceforge.net

jack@suse.cz said:
> +HOSTCFLAGS := $(subst -fomit-frame-pointer,,$(HOSTCFLAGS)) 

What does this fix?

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
