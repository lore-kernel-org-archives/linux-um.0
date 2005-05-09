Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVI1B-0004xF-GH	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:50:33 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVI17-00022k-68	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:50:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200505100110.16920.blaisorblade@yahoo.it>
	<20050509164546.0d6d136b.akpm@osdl.org>
In-Reply-To: <20050509164546.0d6d136b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100139.02512.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 0/6] latest bugfixes for 2.6.12
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
Date: Tue, 10 May 2005 01:39:00 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, bstroesser@fujitsu-siemens.com

On Tuesday 10 May 2005 01:45, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > Here are some more fixes intended for 2.6.12 (and well tested). Can you
> > merge them soon, Andrew? Thanks.
>
> Sure.

> > The first is a particularly bad one since it shows up when you *start*
> > compiling UML (due to a quilt patch -> normal patch conversion problem, a
> > file wasn't actually deleted, but it was when applied through quilt). Was
> > this too quick a merge, maybe? What's your "merging policy" (if any) for
> > patches?

> Jeff sent in fixes which were dependent on other things I had, we're maybe
> several weeks away from 2.6.12,
Several weeks away? Ok, that's nice to know, so we are not in a hurry 
(especially since I'm totally busy). When I'll have time I'll flush out the 
rest of what I have in my tree.
> so I figured there was plenty of time to 
> get things fixed up - best to get it all flushed out and fix any fallout
> rather than hang around, given that UML seems to be still changing in
> fairly significant ways.
Ok, I had guessed we were near to the release instead.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
