Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGDyW-0005Y7-Ph for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 07:15:24 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KGDyV-0003AB-Ue
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 07:15:24 -0700
Message-ID: <48737664.3000608@gmx.de>
Date: Tue, 08 Jul 2008 16:15:00 +0200
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

Jeff Dike wrote:

>> 1. If a file is held read-only by one process it cannot by creat()'ed by 
>> another one:
>>
[...]
>>
>> I tracked that problem down to the set_attr() function in hostfs_user.c: 
>> It tries to ftruncate() the read-only file descriptor. The file should 
>> be re-opened writable before changing its length.
> 
> Looks like a good diagnosis.  There is code in host_file_open which is
> supposed to handle this case, but it's not being hit when the shell
> opens the file, which I don't understand.

I tracked that down step-by-step on Saturday: If the O_TRUNC flag is set 
in the open() syscall the file will first be truncated and then opened.

The call stack for truncating the file:

  - sys_open (fs/open.c)
  - do_sys_open (fs/open.c)
  - do_filp_open (fs/open.c)
  - open_namei (fs/namei.c)
  - may_open (fs/namei.c)
  - do_truncate (fs/open.c)

And the call stack for actually opening the file:

  - sys_open (fs/open.c)
  - do_sys_open (fs/open.c)
  - do_filp_open (fs/open.c)
  - nameidata_to_filp (fs/open.c)
  - __dentry_open (fs/open.c)

Maybe that helps.


> Correct.  I've pondered using [id]notify to track changes on the host
> and either invalidate the UML cache or update it.  Both involve
> interactions with the page cache that I'm not entirely comfortable
> with right now.

That problem is actually more severe for my UML use case: I'm developing 
firmware for an embedded device, and I'm using UML because it's quicker 
and more convenient than developing on the target hardware. Now, if I 
re-compile some library which is still in use by another process the 
changes will not be visible until I reboot (or kill these background 
processes).
How do similar filesystems (e.g. NFS) solve that problem?

Cheers,
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
