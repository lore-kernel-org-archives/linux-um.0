Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWmZr-0008PP-5p
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 17:03:43 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWmZp-0001xd-5m
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 17:03:41 -0800
Message-Id: <200312180119.hBI1JBkS008102@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix 
In-Reply-To: Your message of "Wed, 17 Dec 2003 18:51:18 +0100."
             <200312171851.18353.blaisorblade_spam@yahoo.it> 
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <200312132019.hBDKJ8rL002905@ccure.user-mode-linux.org>  <200312171851.18353.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 17 Dec 2003 20:19:11 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> If not, I can just patch this way scripts/Makefile.lib: 

This seems promising.  Can the new infrastructure be put in arch/um/Makefile?

This would isolate it nicely to UML since it's the only arch which needs it.

Although, thinking about this some more, this isn't the right way to do it
in the long run.  Ultimately, the userspace stuff will be confined to 
arch/um/os, along with the userspace CFLAGS.  So, the arch/um/os/Makefile
will contain this nonsense, and nothing outside there will have to worry
about it.

So, if you want to sign up to a longer project, you might start moving the
userspace stuff into arch/um/os-Linux instead of trying to fix the build.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
