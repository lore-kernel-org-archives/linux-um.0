Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A70JM-0002Jn-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 07 Oct 2003 15:28:08 -0700
Received: from fed1mtao07.cox.net ([68.6.19.124])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A70JL-0002RM-Kp
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 07 Oct 2003 15:28:07 -0700
Message-ID: <3F833EAC.20903@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
References: <3F830C2C.8010308@easyco.com> <200310072151.h97LphCt003529@ccure.karaya.com>
In-Reply-To: <200310072151.h97LphCt003529@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Patch for buffer overrun in serial/console device logic
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
Date: Tue, 07 Oct 2003 15:31:08 -0700
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> doug@easyco.com said:
> 
>>We also have a much messier, in-house patch that we apply to hostfs.c
>>so  that root mounts will correctly honor ownerships and rights.  
> 
> 
> Does this involve some sort of list on the side which keeps track of ownership
> and permissions of the host files?  If so, hostfs has needed something like
> this for a long time.
> 
> 
>>Is anyone  else working on this.
> 
> 
> Not that I know of.  It comes up every once in a while, but no one has actually
> written any code.
> 
> 				Jeff

The in-house patch that we are running assumes that you boot UML as 
root, although I have considered a SUID root variant.

It looks at numeric UID/GIDs and maintains all of these all the way down 
to the user IO calls.  Thus the files created in the hostfs have 
parellel UID/GID values and priviledges.

The code itself involves a lot of extra parameters from kernel to user 
space as things like the current user aren't propogated down.  I 
personally think that our current patch set is "100% ugly" and would not 
consider posting it as-is.  If people are interested in transparent 
numeric UID/GID to hostfs, then I would be happy to clean up what we 
have and submit it.

Our reason for doing the patch in-house is that we have added UML kernel 
code that supports an in-house application that causes hostfs to keep a 
"journel" of file IO transactions and posts this journel to a host pipe. 
  We then have host daemons (outside of the virtual) that move this 
journel to a distant machine achieving remote filesystem replication. 
We use this for high-reliability mail and web services.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
