Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A8X1X-0007L2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 11 Oct 2003 20:36:03 -0700
Received: from fed1mtao03.cox.net ([68.6.19.242])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A8X1V-0003H6-7m
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 11 Oct 2003 20:36:01 -0700
Message-ID: <3F88CCD5.8080508@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Patch for buffer overrun in serial/console device
 logic
References: <3F830C2C.8010308@easyco.com> <200310072151.h97LphCt003529@ccure.karaya.com>  <3F833EAC.20903@easyco.com> <200310110149.h9B1n94f006954@ccure.karaya.com>
In-Reply-To: <200310110149.h9B1n94f006954@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 11 Oct 2003 20:39:01 -0700
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> doug@easyco.com said:
> 
>>The code itself involves a lot of extra parameters from kernel to user
>> space as things like the current user aren't propogated down.  I
>>personally think that our current patch set is "100% ugly" and would
>>not  consider posting it as-is.  If people are interested in
>>transparent  numeric UID/GID to hostfs, then I would be happy to clean
>>up what we  have and submit it. 
> 
> 
> OK, that ain't the way to do it.  Anything that involves passing a parallel
> set of creds through VFS will cause Al Viro to lop my head off.  Since I'm
> somewhat attached to it, I will not propose such a thing, no matter how cleaned
> up it is.

There are actually a couple of sets of issues here.

1.  The "_user" stuff needs to get to UID, GID, and UMASK.

2.  When the "_user" stuff does IO, it should "become" the users in 
UID/GID.  This way permissions "just work" and you don't have to clean 
anything up after the fact.

Addressing (1), I could always just transition a pointer to "current" 
and really open up a can of worms.

This breaks just about every rule of "object orientation", but on the 
other hand, file systems usually do have access to the process state, so 
maybe this is the "correct" approach.

Doing a seteuid(...) ... around the IO calls is actually pretty clean. 
I implemented it with a "change" / "unchange" set of helper routines and 
it pretty much worked first shot.

> What would work is to store the creds in a separate container of some sort
> on the host, and reference that inside hostfs when doing permission checks.
> 
> This is more or less what UMSDOS does, from what I understand, and it keeps
> the nastiness contained within hostfs.
> 
> That journalling is a neat idea, BTW.
> 
> 				Jeff

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
