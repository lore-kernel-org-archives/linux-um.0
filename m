Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7H53-0003L5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 08 Oct 2003 09:22:29 -0700
Received: from fed1mtao03.cox.net ([68.6.19.242])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A7H51-0007cp-Ry
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 08 Oct 2003 09:22:27 -0700
Message-ID: <3F843A79.6060600@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Patch for buffer overrun in serial/console device
 logic
References: <3F830C2C.8010308@easyco.com> <p05111b00bba97b88a68d@[10.96.96.13]>
In-Reply-To: <p05111b00bba97b88a68d@[10.96.96.13]>
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
Date: Wed, 08 Oct 2003 09:25:29 -0700
To: Hannes Schulz <schulz@schwaar.com>, user-mode-linux-devel@lists.sourceforge.net

Hannes Schulz wrote:

> [...]
> 
>> We also have a much messier, in-house patch that we apply to hostfs.c 
>> so that root mounts will correctly honor ownerships and rights.  Is 
>> anyone else working on this.  The 2.4.20-5um release appears to have a 
>> lot of missing stuff in this area, but if someone else is re-working 
>> this, I will put my patch down for a while and wait.  Otherwise, I 
>> will clean it up and submit it.
>>
> 
> I did such a patch (see below). How does yours fix the problem ?
> Unfortunately I have another problem with hostfs: munmap does not write 
> out the changes to the file. I looked at the code but I am afraid this 
> is beyound me.

[ ... snipped ... ]

My patch was quite a bit more involved.

The problem that I saw was that the actual IO operations in 
hostfs_user.c were always being executed as the user that start UML.  In 
order to get all of the UID/GIDs to map transparently, you have to do 
setegid(...) and seteuid(...) operations around all of the IO operations 
that have the potential to create a file or directory.  This includes 
open and a bunch of others.  Unfurtunately, the calling UID/GID is never 
visible to the functons in hostfs_user.c, so hostfs_kern.c needs a new 
call (or new parameters) to pass this down.  Umask also needs to travel 
down to hostfs_user.c.

My patch is very tangled in with my "transaction journel" that we use 
for replication.  The replication stuff is very "non trivial" to 
implement from a setup point of view, so I don't want to give that to 
anyone at this point.  Plus, the patch as stands has lots of debugging 
lines commented out and is just plain ugly.  My reputation would not be 
served well to show it to anyone at this point.  My real question was 
whether there is a need to more transparent UID/GID/UMASK processing to 
hostfs (with the caveat that UML must boot root or at least SUID root).


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
