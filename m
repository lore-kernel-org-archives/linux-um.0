Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdwH9-00012k-OA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:49:59 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AdwH6-0002uf-3F
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:49:56 -0800
Message-Id: <200401061909.i06J9ctd003026@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 06 Jan 2004 19:20:59 +0100."
	<200401061921.00054.blaisorblade_spam@yahoo.it> 
References: <200401061921.00054.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: 2.6-specific UML patches (modules, modversions,
	various other stuff)
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
Date: Tue, 06 Jan 2004 14:09:38 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> There you will find a number of patches for UML 2.6. Some are mine and
> some  come from Ingo and M A Young; I've included everything Ingo
> posted minus the  speedup - breakage for 2.4 host. That is,
> MM_COPY_SEGMENTS is still called by  UML but if the host is a 2.6 that
> is a no-op. 

There's a lot of old stuff in that patch.  It would be more useful to me if
it were against a recent UML patch, like the 2.6.0 patch that I'm working
on at the moment.  That has all the recent 2.4 changes pulled in as well as
updating to 2.6.0.  A patch containing the stuff that you have that I don't
would be useful.

Some more specific things -
	I'm not going to update the skas3 patch again, but I'm glad people are
cleaning it up and updating it.
	I don't like the UML_USER_OBJS thing - feel free to work on it, but
I'm not going to merge it unless I'm desperate.  I continue to think that the
right way to go is to move all the userspace stuff under os-Linux, then fiddle
the build rules there.

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
