Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGfZz-0005mC-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jul 2008 12:43:55 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KGfZy-0005x1-0s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jul 2008 12:43:55 -0700
Message-ID: <487514EE.3000903@gmx.de>
Date: Wed, 09 Jul 2008 21:43:42 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
References: <486FC187.6010802@gmx.de>
	<20080707203912.GB7648@c2.user-mode-linux.org>
In-Reply-To: <20080707203912.GB7648@c2.user-mode-linux.org>
Subject: Re: [uml-devel] hostfs oddities
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike schrieb:

>> I guess this is some kind of caching effect, because strace shows that 
>> there is only a single read to the actual physical file. Maybe hostfs 
>> should check whether the outside file has changed and invalidate the 
>> cache if necessary.
> 
> Correct.  I've pondered using [id]notify to track changes on the host
> and either invalidate the UML cache or update it.  Both involve
> interactions with the page cache that I'm not entirely comfortable
> with right now.

I gave all this a little more thought: The ideal solution would be to 
somehow share the host's page cache for that file. That way concurrent 
read and write accesses on both sides would be automatically 
synchronized, just as when multiple regular processes access the same 
file. I guess that's not easily possible, is it?

If it turns out we have to invalidate the cache whenever the file is 
changed on the host side it looks like invalidate_inode_pages2() is the 
function to use: If I modify the aio_read in hostfs_kern.c to call this 
function on iocb->ki_filp->f_mapping before every read changes made on 
the host become immediately visible on the guest. This is also what nfs 
seems to do.

Regards,
Ingo

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
