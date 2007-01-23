Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9GZz-0008F5-1m for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 00:00:31 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H9GZx-0007dU-GO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 00:00:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 23 Jan 2007 09:00:09 +0100
References: <420863.17264.qm@web15301.mail.cnb.yahoo.com>
In-Reply-To: <420863.17264.qm@web15301.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701230900.10008.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Something wrong with booting the UML in new kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

On Sunday 21 January 2007 03:34, An Ching wrote:
> Hi,
>
> I had recompiled my host kernel with setting the EXT2_FS_SECURITY and
> EXT3_FS_SECURITY in filesystem configuration. My UML is OK before doing
> this, but now I can not boot the UML in the new-recompiled kernel. It just
> went to the step...
>
> [root@RH9 linux-2.6.17]# ./linux root=/dev/sda1 rootflags=/
> rootfstype=hostfs ro con0=fd:0,fd;1 init/bin/sh -l Checking that ptrace can
> change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...OK
> Checking PROT_EXEC mmap in /dev/shm/...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
>
> Just down to this step, and not any response next...
>
> I guessed maybe the kernel of UML didn't support the XATTR  of filesystem
> and then I reconfigured the UML and set EXT2_XATTR, EXT2_FS_SECURITY,
> EXT3_XATTR, EXT3_FS_SECURITY to "Y".
This wouldn't matter, since UML is using hostfs (which does not support XATTR 
at all, to my knowledge) and not ext2/ext3.
> But after I recompiled the kernel of 
> UML and run it,  I  was given the same  message mentioned above.
>
> What should do  next?   Could anybody  give me some advices?

There are few reasons usually for using hostfs, normally using a dedicated 
root_fs is a better solution. And using hostfs on your / can cause trouble to 
both your host and your guest (well, if you boot with init=/bin/sh then there 
are less problems).
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
