Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFy9c-000632-22 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2004 09:31:24 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BFy9b-0007jI-QV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2004 09:31:23 -0700
Message-ID: <20040420163121.17795.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Problems with the SKAS patch and 2.6
Content-Type: Text/Plain;
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
Date: 20 Apr 2004 16:31:21 -0000
To: user-mode-linux-devel@lists.sourceforge.net

> Well, what you did is correct (you had to apply both the UML
patch and that 

> version of the SKAS patch); the problem is that for 2.6.6-rc1
you need one 

> more fix for the UML patch (it was posted here by Jeff Chua
and it's 2 thread 

> before this one).



Yeah I figured this out, and applied it, but wasn't able to finish
compiling an UML guest, started getting error in /usr/innclude/asm
directory.  Dealing with mpsecc.h, I think this is cause Debian
(unstable/SID) doesn't have new enough kernel-headers, does that
sound about right?



> You must undo your changes to the Makefile since that patch
already contains 

> it.



Actually I only applied part of Jeff's patch.  I've had problems
with some of his Makefile changes, but have up til now been able
to compile fine without those changes.



> The steps.



> Thanks, it is always important to post them, so that the help
can be more 

> detailed.



> > The 2.6.6-rc1 host is doing good though.



> Thanks for this test: the SKAS patch is very well tested, but
I absolutely did 

> not have the time to test that little change (2 lines, so don't
worry).



No problem, least I could do with you putting it out there is
try it, and wanted to provide feedback for those that might be
thinking about trying it.  That's what I use this box for.  To
'mess around' with UML. :) At this point I'll add that this box
is not an SMP box and I don't have SMP features enabled.



George



----------------------------------------------------

Need to store your files online? 

Upload them for free in Praize Briefcase

http://www.praize.com/cgi-bin/members/mybriefcase.cgi



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
