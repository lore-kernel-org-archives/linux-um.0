Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wpAq-0005su-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 13:33:16 -0700
Received: from boof.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wpAn-00014D-De
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 13:33:13 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch
In-Reply-To: <20030909164152.GB7799@alcor.net>
Message-ID: <Pine.LNX.4.44.0309091530570.26334-100000@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 9 Sep 2003 15:32:39 -0500 (CDT)
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 9 Sep 2003, Matt Zimmerman wrote:

> On Tue, Sep 09, 2003 at 09:10:55AM -0400, Jeff Dike wrote:
>
> > adam@doogie.org said:
> > > All these combinations had this problem.  However, Host 2.4.21-1um,
> > > UML 2.4.20-6um and host 2.4.22, UML 2.4.20-6um ran fine.
> >
> > I've been playing with this quite a bit and I can't make it misbehave.  So,
> > I need some clues as to what you're doing that I'm not.
>
> Likewise.  Adam can actually reproduce this with the exact same UML binary
> that I'm using (the one from my user-mode-linux .deb), but I can't reproduce
> it at all.  We're also both using Debian unstable (I think), so most other
> factors should be the same as well.  My host kernel is Debian's 2.4.21 with
> skas3 and device-mapper.

Well, not unstable.  The machine I was running this on is a server, not my
workstation(which tends to follow unstable, but isn't always uptodate).  The
machine that had the problems had a libc6 version of 2.3.2-5.

Unfortunately, I installed an older uml binary(2.4.20-6um), so that we could
continue to run our uml hosts on it.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
