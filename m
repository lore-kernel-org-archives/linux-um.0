Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwwQd-0001Jt-Qm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 21:54:51 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CwwQc-0007vq-QP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 21:54:51 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [POLL] Putting UML/2.4 into "fixes-only" mode
References: <200501262310.49814.blaisorblade@yahoo.it>
	<200501290539.j0T5dlwM007191@ccure.user-mode-linux.org>
In-Reply-To: <200501290539.j0T5dlwM007191@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502040654.03388.blaisorblade@yahoo.it>
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
Date: Fri, 4 Feb 2005 06:54:03 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Saturday 29 January 2005 06:39, you wrote:
> blaisorblade@yahoo.it said:
> > It's a huge work, but what is more important, it could obviously hurt
> > stability...

> Yes.

> > So, I'd suggest to follow this policy to choose the work to merge:
> >
> > - reduce *a lot* what is going to be merged... no new features, no
> > code  cleanups (especially NOT the Makefiles cleanups)...
> >
> > - concentrate on stability... and on backing out the hostfs rewrite.

> This makes all kinds of sense.  But, from my point of view, if I'm going
> maintain both 2.4 and 2.6 trees, I want them to be as similar as possible.

> We can go through the patches, and I got a nice list of them, and I was
> planning on going through them and applying all of the ones that made sense
> in 2.4.

> So, your proposal makes sense from the point of a large number of users,
> but you're signing me up for a whole lot of extra work.  So, I'm not too
> inclined to run a stability 2.4 tree, as much sense as it makes.

> Are you?  Or someone else?  I've got this nice list of patches, and I'll
> be happy to go through them and categorize them in terms of their effects
> on stability.

Well, there are two things that you can do to *avoid* increasing your work:

- avoid backporting cleanups, like the bh one... it's just lost time.

- avoid if possible to backport new features...

- concentrate on the recent security fixes, if possible... the 
syscall-security-1/6 fixes were not enough on 2.6 to fix everything, so for 
me it's evident they cannot suffice on 2.4.

Also, it's not the kind of work which is easy to delegate (to me at least) - 
those patches hack the UML core and I've not followed them well - for missing 
time and for their difficulty.

Also, now, I'm doing some more work on the 2.4 tree - I've some fixes I found 
useful, like the 2.6.4 scheduler fixes which weren't merged in 2.4 and some 
more recent ones.

I did that to try fixing the /dev/urandom bug, before realizing that the 
problem is in some code related to the urandom driver... the reported panic 
is just a "scheduling in interrupt" one. It means also that the problem is 
due probably to something in UML that is used by the driver. Suggestions:

- timing code
- interrupt code (they are entropy sources).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
