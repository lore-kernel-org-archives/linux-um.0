Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX6A3-0005db-3Z
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 13:58:23 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AX6A1-0002pC-1K
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 13:58:21 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
Message-ID: <20031218221357.GD4090@ccure.user-mode-linux.org>
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <200312171851.18353.blaisorblade_spam@yahoo.it> <200312180119.hBI1JBkS008102@ccure.user-mode-linux.org> <200312182032.50394.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312182032.50394.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Dec 2003 17:13:57 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Dec 18, 2003 at 08:32:50PM +0100, BlaisorBlade wrote:
> I'm going to check... the variables are all set with = so it should work, but 
> my problem is that it seems that the arch/um/Makefile is not included when it 
> descends in sub-directories. 

Hummm, so all the state that's set up by the arch Makefile is made available
in environment variables to the subdir makes?  That's inconvenient.

> However, even if it CAN be put there, I think 
> this should NOT happen, and that it should be cleaned enough to be accepted 
> in mainline. Why?
> I think that it should have to be tuned for each release, and would not be 
> likely to always be tunable(i.e. it could have to be re-engeneered if they 
> change Makefile.lib enough). I don't use in fact an external interface of 
> KBUILD, but I mingle inside its implementation(i.e. I violate encapsulation).

It's UML-specific.  So, if at all possible, it should be in the UML tree,
not in the generic kbuild.

> I don't agree for "instead". I.e. I think that as the first thing this must be 
> fixed, and then we will go hunting the bug for MODVERSIONS(it needs that we 
> post-process userspace files).
> After this, then I could do this user space change(I can't promise for now but 
> I hope I'll be able); 

When the userspace stuff is all nicely hidden under arch/um/os, then whatever
fix you have for the build will apply only to that directory.  Maybe it will
turn out that it can't be hidden in the arch/um/os Makefile, but maybe it
can, and that's the right place to put it, if so.

> but it is a bit problematical because KBUILD isn't 
> built to link objects from different directories.

No one is proposing that.

> Could symlink be accepted as a solution for this(i.e. a symlink from 
> drivers/hostaudio_user.c to some file inside the os/ directory)?

If hostaudio is really Linux-specific, it should just be moved under 
arch/um/os-Linux/drivers along with tuntap and ethertap.

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
