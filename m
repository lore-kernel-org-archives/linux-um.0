Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvFkc-0002cf-Il for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jan 2006 07:13:02 -0800
Received: from linux01.gwdg.de ([134.76.13.21] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvFkb-0007OQ-0l
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jan 2006 07:13:02 -0800
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
In-Reply-To: <20060107023713.GA13285@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<20060105161436.GA4426@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
	<200601061801.17497.rob@landley.net>
	<20060107023713.GA13285@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 7 Jan 2006 16:12:50 +0100 (MET)
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

>> Doing both of these things (a seperate host process for each UML process, and
>> calling getpid() for all system calls), is what "Tracing Thread" mode did.  
>> The UML kernel was one thread among several, and it was kinda slow.
>
>The skas vs tt distinction is the address space part of this.  How we nullify
>system calls is separate.  That's the PTRACE_SYSCALL vs PTRACE_SYSEMU (which
>is now in mainline) thing.
>

...
So there is no way to get UML compile on non-Linux.


Jan Engelhardt
-- 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
