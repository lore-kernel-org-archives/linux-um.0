Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADsMR-0006VW-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 13:23:43 -0800
Received: from fep01-svc.mail.telepac.pt ([194.65.5.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ADsLh-0007tD-On
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 26 Oct 2003 13:22:57 -0800
Message-ID: <3F9C3B38.6000708@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Problem with Real-Time Scheduling
References: <000001c39b80$e011fbe0$3d4bd540@celery> <200310261909.h9QJ92CN012291@ccure.karaya.com>
In-Reply-To: <200310261909.h9QJ92CN012291@ccure.karaya.com>
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
Date: Sun, 26 Oct 2003 21:23:04 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: ralston@stral.net, user-mode-linux-devel@lists.sourceforge.net

Hi!

Jeff Dike wrote:

[..]

> In skas mode, the first process runs the kernel, the second runs processes, 
> and the other two handle SIGIO emulation and SIGWINCHes.  So, those two don't
> matter, and first two are never running at the same time, so their relative
> priorities don't matter.
> 
> 				Jeff
> 

Wouldn't it be nice if the threads updated their argv[0] to something like
"argv[0]-kernel"
"argv[0]-userspace"
"argv[0]-sigio"
"argv[0]-sigwinch"?

I would send a patch but my first attempt didn't work... Can this be 
done? Maybe renicing the threads could help in environments where you 
have lots of UMLs running? Like having the kernel runnig at -10 and 
userspace at 19 and sigio at 19? Maybe this could make the "time" inside 
UML more consistent in high loads?

Comments?

Regards,
Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
