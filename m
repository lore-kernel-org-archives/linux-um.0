Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSCV0-0001ce-Ao	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 04:20:34 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DSCUy-0007sv-KO	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 04:20:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [UML] Compile error when building with seperate
	source and object directories
References: <1114570958.5983.50.camel@mythical>
	<20050428202647.GA25451@ccure.user-mode-linux.org>
	<20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505011330.58205.blaisorblade@yahoo.it>
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
Date: Sun, 1 May 2005 13:30:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>

On Thursday 28 April 2005 23:53, Al Viro wrote:
> On Thu, Apr 28, 2005 at 04:26:47PM -0400, Jeff Dike wrote:
> > > That's because that stuff is not merged yet.  Speaking of which, where
> > > does the current UML tree live and who should that series be Cc'ed to?
> >
> > My patchset lives at http://user-mode-linux.sf.net/patches.html, and
> > things like this should be CC-ed to me.
> >
> > > I've got a decent split-up and IMO that should be mergable.  Patches
> > > are on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of
> > > mail. That's a sanitized and split version of old UML-kbuild patch.
> >
> > Thanks, merged into my tree.  It'll be visible at the above URL next time
> > I push the site out, and I'll merge this and a bunch of other stuff to
> > Linus and Andrew shortly.
>
> OK...  Out of old UML-kbuild only the chunk in ptrace.c is not covered
> by that (note that e.g. top-level Makefile is not modified at all in
> the new version).  arch/um/kernel/ptrace.c is a separate story - we
> need per-arch helper there.
For now I've added an #ifdef to re-include that code for x86, while excluding 
it for x86_64. Also, is that up-to-date wrt. 2.6.12-rc3? I had merged part of 
your code (at least the most urgent ones).

Also, I'm thinking to a generic support for those conditional double 
includes... I'll post it when it'll be ready.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
