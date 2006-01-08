Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvRZk-0003Pc-Sx for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jan 2006 19:50:36 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvRZi-0001OL-Ka
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jan 2006 19:50:37 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<20060107023713.GA13285@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601072150.14855.rob@landley.net>
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
Date: Sat, 7 Jan 2006 21:50:14 -0600
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

On Saturday 07 January 2006 09:12, Jan Engelhardt wrote:
> >The skas vs tt distinction is the address space part of this.  How we
> > nullify system calls is separate.  That's the PTRACE_SYSCALL vs
> > PTRACE_SYSEMU (which is now in mainline) thing.
>
> ...
> So there is no way to get UML compile on non-Linux.

Not out of the box, no.  You need some equivalent debugging facility, but 
that's not too high a barrier.  It's really that there's no way for a 
userspace process to fiddle around with the MMU the way an OS wants to, 
unless you A) put hooks in the OS, or B) have multiple processes with 
different memory contexts, which means debugging hooks if you want one thread 
to intercept the syscalls made by another thread.

There have been occasional attempts at doing this, by the way.  (If I had 
gotten a mac mini I was going to give it a try, but about two _hours_ before 
I had scheduled an extra long lunch hour to go visit the Apple store in the 
barton creek mall, I heard about Jobs' announcement of the switchover to 
Intel processors, so I didn't.  Not like I really _need_ another todo item 
that's going to wind up taking up six months of my free time.  Just use 
qemu...)

> Jan Engelhardt

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
