Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF0qs-0007FB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 16:39:50 -0800
Received: from [212.55.154.26] (helo=sapo.pt)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AF0qr-0000oV-V4
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 29 Oct 2003 16:39:50 -0800
Message-ID: <3FA05DEA.2090507@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Problem with Real-Time Scheduling
References: <000001c39b80$e011fbe0$3d4bd540@celery> <200310261909.h9QJ92CN012291@ccure.karaya.com> <3F9C3B38.6000708@vgertech.com> <200310292012.10949.blaisorblade_spam@yahoo.it>
In-Reply-To: <200310292012.10949.blaisorblade_spam@yahoo.it>
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
Date: Thu, 30 Oct 2003 00:40:10 +0000
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello!

BlaisorBlade wrote:
> Alle 22:23, domenica 26 ottobre 2003, Nuno Silva ha scritto:
> 
>>Hi!
>>
>>Wouldn't it be nice if the threads updated their argv[0] to something like
>>"argv[0]-kernel"
>>"argv[0]-userspace"
>>"argv[0]-sigio"
>>"argv[0]-sigwinch"?
>>
>>I would send a patch but my first attempt didn't work... Can this be
>>done?
>>Maybe renicing the threads could help in environments where you
>>have lots of UMLs running? Like having the kernel runnig at -10 and
>>userspace at 19 and sigio at 19?
> 
> Avoid nice=19 since there have been some notable patches in 2.5(even present 
> in 2.4-ck tree) to make such task run only in place of the idle task. And 
> having the kernel running at -10 means having high permissions.
> Adding an option to make UML switch to some UID after startup is not 
> difficult. But first we need to know until which point it needs root 


I wasn't talking about running UML as root. Just an easy way to identify 
each thread.

After a script (maybe run by root, maybe not) can easily spot which 
thread does what we could renice the process, remove linux capabilities, 
killall -STOP linux-sigio, etc... ;)


> priviledges. And probably, capabilities are just enough. And at some point, 
> in 2.6 there will be setcapability extended attributes(it's not hard now that 
> extended attrs work).
> 
>>Maybe this could make the "time" inside
>>UML more consistent in high loads?
>>

This would be really good! :)

Regards,
Nuno Silva



>>Comments?
>>
>>Regards,
>>Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
