Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A3Qe2-0006H1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Sep 2003 18:46:42 -0700
Received: from panoramix.vasoftware.com
	([198.186.202.147] helo=externalmx.vasoftware.com ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A3Qe1-0001ug-MK
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Sep 2003 18:46:41 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:47663)
	by externalmx.vasoftware.com with esmtp (Exim 4.22 #1 (Debian))
	id 1A3QcQ-0008Pj-BP
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Sep 2003 18:45:02 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 1A3Qbw-0006cA-00
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Sep 2003 21:44:32 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 1A3Qbw-0007U1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Sep 2003 21:44:32 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Separate COW patch.
Message-ID: <20030928014432.GP9124@alcor.net>
References: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net>
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
Date: Sat, 27 Sep 2003 21:44:32 -0400
To: "'user-mode-linux-devel@lists.sourceforge.net'" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Sep 26, 2003 at 06:45:26PM -0400, Montgomery, Kendal L wrote:

> I was wondering if there was anyone who is trying to use the COW
> filesystem in a normal linux kernel?  Is this possible, or is it tied
> exclusively to the rest of the UML patch?  How difficult would it be to
> make a COW only patch?  I have a certain project that I'm working on that
> the COW filesystem (or really, any other "union" filesystem, but I can't
> find any that are actively developed or fully cooked) would be perfect
> for.  I have a read-only filesystem that, occasionally needs to
> temoroarily have some changed made to it, but then the need to be undone.
> I've looked into various ways of doing this from "snapshotting," to
> user-controlled transactions on a journalling filesystem (no such thing
> seems to exist for ext3 or reiserfs) where I could explicitly begin a
> transaction, then roll back the transaction when I'm done (kinda like a
> database txn), etc.  The COW filesystem seems like it would be a perfect
> fit, but before I go trying to merge things into a non-UML kernel on my
> own I just want to see if anyone else has already done this or not.  Is
> anyone else even interested in such a

You want the snapshot feature in device-mapper, with lvm2 or evms.  It does
exactly what you've described, with any filesystem.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
