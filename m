Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADqEj-00069b-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 11:07:37 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ADqCV-0000Y5-VZ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 26 Oct 2003 11:05:20 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9QIrLj09715
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 13:53:24 -0500
Message-Id: <200310261909.h9QJ92CN012291@ccure.karaya.com>
Subject: Re: [uml-devel] Problem with Real-Time Scheduling 
In-Reply-To: Your message of "Sun, 26 Oct 2003 16:20:30 +1100."
             <000001c39b80$e011fbe0$3d4bd540@celery> 
References: <000001c39b80$e011fbe0$3d4bd540@celery> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Sun, 26 Oct 2003 14:09:02 -0500
To: ralston@stral.net
Cc: user-mode-linux-devel@lists.sourceforge.net

ralston@stral.net said:
> I've come across a problem with running a user-mode-linux instance
> with RR-Scheduling. When I attempt to start a server with chrt the
> host system panics. I can start a uml in normal (other) scheduling,
> and then change it to RR-Scheduling and it works fine, until I try to
> stop the uml... then I get the same kernel panic.

Any time the host panics, it's time to send the details to LKML.

> how would different scheduling the different 'threads' of the UML
> effect performance? As far as I know.. the first 'linux' process
> actually does all the work and the extra processes are for the
> different IO the UML does, eg network, block devices etc? Would
> increasing the priority of the IO over the priority of the main
> process have an effect on network performance for example?

In skas mode, the first process runs the kernel, the second runs processes, 
and the other two handle SIGIO emulation and SIGWINCHes.  So, those two don't
matter, and first two are never running at the same time, so their relative
priorities don't matter.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
