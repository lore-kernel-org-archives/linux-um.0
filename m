Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuYLE-0001H6-JO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 07:47:24 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CuYKj-000556-Mm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 07:47:24 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] [POLL] Putting UML/2.4 into
	"fixes-only" mode
References: <200501262310.49814.blaisorblade@yahoo.it>
	<41F85058.8050106@enterasys.com>
In-Reply-To: <41F85058.8050106@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281646.29630.blaisorblade@yahoo.it>
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
Date: Fri, 28 Jan 2005 16:46:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "D. Bahi" <dbahi@enterasys.com>

On Thursday 27 January 2005 03:22, D. Bahi wrote:
> I would like a 2.4 that is stable. with a working hostfs.
Tried 2.4.27-bs1?
> (that i can run valgrind against - heh, not umls fault here.)
I've never seen valgrind actually working against UML - Jeff Dike did some 
work on Valgrind on this area time ago, but it wasn't merged and the Valgrind 
author said that Valgrind does not at all supports program using the "clone" 
call. And UML is one heavy user of this call.

> Also, the uml web site needs to be authoritative. building
> the above should not require patching from additional
> sources announced on the list.

> That said, 2.4 and 2.6 are both 'stable' kernel branches
> that have had quite a bit of UML development in them. So,
> if it helps future maintaining of both 2.4 and 2.6, at
> least until 2.7 appears, then do what you need to do.
> please don't abandon 2.4 until 2.7 is well under way.
This does not work... nobody knows if 2.7 will ever start *at all* (really).
> Maybe you could break up the 2.4 patches into 'stable'
> 'testing' and 'experimental' ?
Time is limited - managing two trees (in this case, two 2.4 trees) and porting 
patches back and forth between them is a hard, difficult, error-prone work.

However, I've not claimed "abandoning" the 2.4 tree.

However, who uses the 2.4 tree wants stability over everything else (in most 
cases), otherwise would use the 2.6 tree.

So, actually, we cannot debug invasive patches on 2.4: you need lots of users 
testing and reporting about them and helping to narrow down possible bugs.

So, for instance, it would be useless to backport the /proc/sysemu feature 
(which was a bit tricky to get right on 2.6 already, especially because 
uncovered some bugs in the SYSEMU host patch).

> Blaisorblade wrote:
> >Jeff, I've seen the beginning of your work on back-porting all the patches
> >from 2.6 to 2.4...

> >It's a huge work, but what is more important, it could obviously hurt
> >stability...

> >So, I'd suggest to follow this policy to choose the work to merge:

> >- reduce *a lot* what is going to be merged... no new features, no code
> >cleanups (especially NOT the Makefiles cleanups)...

> >- concentrate on stability... and on backing out the hostfs rewrite.

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
