Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4214-0000Sx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 10:40:58 -0700
Received: from uswgco34.uswest.com ([199.168.32.123])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4213-0000dx-Eu
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 10:40:57 -0700
Received: from egate-co5.uswc.uswest.com (egate-co5.uswc.uswest.com [151.119.87.232])
	by uswgco34.uswest.com (8/8) with ESMTP id h8TGrg77029705
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 10:53:42 -0600 (MDT)
Received: from itomae2ksm01.AD.QINTRA.COM (localhost [127.0.0.1])
	by egate-co5.uswc.uswest.com (8.12.10/8.12.10) with ESMTP id h8TGrgZY000546
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 10:53:42 -0600 (MDT)
content-class: urn:content-classes:message
Subject: RE: [uml-devel] Separate COW patch.
Message-ID: <2D4B6CD74137D4119A1100104BC6BCBF0BC58605@dubntex006.qwest.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
From: "Montgomery, Kendal L" <kendal.montgomery@qwest.com>
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
Date: Mon, 29 Sep 2003 11:53:40 -0500
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Thanks everyone for the feedback.  I'm looking further into using lvm2
or evms to solve this problem.  However, I'm quite certain that a
standalone COW driver would easily solve this problem as well, so if the
patch set mentioned before by Jeff Dike is ever completed, I'd be
interested in trying it out.

Jeff,

Where can I get what you've worked on so far?  I'd be willing to give it
a try and possibly help to sort out the remaining pieces that need to
make it work.

Kendal.

-----Original Message-----
From: Matt Zimmerman [mailto:mdz@debian.org] 
Sent: Saturday, September 27, 2003 9:45 PM
To: 'user-mode-linux-devel@lists.sourceforge.net'
Subject: Re: [uml-devel] Separate COW patch.


On Fri, Sep 26, 2003 at 06:45:26PM -0400, Montgomery, Kendal L wrote:

> I was wondering if there was anyone who is trying to use the COW 
> filesystem in a normal linux kernel?  Is this possible, or is it tied 
> exclusively to the rest of the UML patch?  How difficult would it be 
> to make a COW only patch?  I have a certain project that I'm working 
> on that the COW filesystem (or really, any other "union" filesystem, 
> but I can't find any that are actively developed or fully cooked) 
> would be perfect for.  I have a read-only filesystem that, 
> occasionally needs to temoroarily have some changed made to it, but 
> then the need to be undone. I've looked into various ways of doing 
> this from "snapshotting," to user-controlled transactions on a 
> journalling filesystem (no such thing seems to exist for ext3 or 
> reiserfs) where I could explicitly begin a transaction, then roll back

> the transaction when I'm done (kinda like a database txn), etc.  The 
> COW filesystem seems like it would be a perfect fit, but before I go 
> trying to merge things into a non-UML kernel on my own I just want to 
> see if anyone else has already done this or not.  Is anyone else even 
> interested in such a

You want the snapshot feature in device-mapper, with lvm2 or evms.  It
does exactly what you've described, with any filesystem.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf _______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
