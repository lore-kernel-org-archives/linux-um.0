Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200501290539.j0T5dlwM007191@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Wed, 26 Jan 2005 23:10:48 +0100."
	<200501262310.49814.blaisorblade@yahoo.it> 
References: <200501262310.49814.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [POLL] Putting UML/2.4 into "fixes-only" mode
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
Date: Sat, 29 Jan 2005 00:39:47 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

blaisorblade@yahoo.it said:
> It's a huge work, but what is more important, it could obviously hurt
> stability...

Yes.

> So, I'd suggest to follow this policy to choose the work to merge:
>
> - reduce *a lot* what is going to be merged... no new features, no
> code  cleanups (especially NOT the Makefiles cleanups)...
>
> - concentrate on stability... and on backing out the hostfs rewrite. 

This makes all kinds of sense.  But, from my point of view, if I'm going 
maintain both 2.4 and 2.6 trees, I want them to be as similar as possible.

We can go through the patches, and I got a nice list of them, and I was 
planning on going through them and applying all of the ones that made sense
in 2.4.

So, your proposal makes sense from the point of a large number of users,
but you're signing me up for a whole lot of extra work.  So, I'm not too
inclined to run a stability 2.4 tree, as much sense as it makes.  

Are you?  Or someone else?  I've got this nice list of patches, and I'll
be happy to go through them and categorize them in terms of their effects
on stability.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
