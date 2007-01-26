Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HAXX3-0003aO-7d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 12:18:45 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HAXX1-0008Gs-Mg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 12:18:45 -0800
Date: Fri, 26 Jan 2007 15:16:54 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
In-Reply-To: <20070126151328.GA4436@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0701261448180.3159@sparrow>
References: <Pine.LNX.4.64.0701260101250.5924@sparrow>
	<20070126151328.GA4436@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] Possible hostfs uml kernel data corruption with
	missing host directory (fc6, 2.6.20-rc5-git3 on opteron)
Reply-To: William Stearns <wstearns@pobox.com>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: William Stearns <wstearns@pobox.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Good morning, Jeff, all,

On Fri, 26 Jan 2007, Jeff Dike wrote:

> On Fri, Jan 26, 2007 at 04:07:05AM -0500, William Stearns wrote:
>> 	After bisecting the difference between the two root filesystems,
>> the critical change was a line in /etc/fstab:
>>
>> none            /mirrors        hostfs  defaults,/home/mirrors  0 0
>>
>> 	Woah.
>
> Hmmm.
>
> Can you enable all of the memory debugging options under Kernel
> Hacking and try this again?  The slab debugging may trap it closer to
> the actual bug.

 	You got it:

[wstearns@ford kernels]$ diff -bd -U 0 <(sort config-2.6.20-rc5-git3-1 ) 
<(sort config-2.6.20-rc5-git3-debugging-2 )
-# CONFIG_DEBUG_LIST is not set
+CONFIG_DEBUG_LIST=y
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RT_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
-# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_PI_LIST=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_RWSEMS=y
+CONFIG_DEBUG_SLAB_LEAK=y
+CONFIG_DEBUG_SLAB=y
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
-# CONFIG_DEBUG_VM is not set
+CONFIG_DEBUG_SPINLOCK_SLEEP=y
+CONFIG_DEBUG_VM=y

 	But no additional debugging messages showed up; just a similar 
kernel panic at bringing up networking.
 	If you want to take a look, I've placed the root filesystem and 
the new debug-enabled kernel at http://ford.stearns.org/uml/ , along with 
the command used to invoke.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
     "My PID is Inigo Montoya. You kill -9 my parent process. Prepare to
vi."
     - TVmisGuided on Slashdot
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
