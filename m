Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMxMG-0000gl-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 14:33:04 -0800
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AMxMG-0007Kd-DV
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 14:33:04 -0800
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311201956.39623.Frank.dekervel@student.kuleuven.ac.Be> <200311202037.14480.blaisorblade_spam@yahoo.it>
In-Reply-To: <200311202037.14480.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311202332.56549.Frank.dekervel@student.kuleuven.ac.Be>
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
Date: Thu, 20 Nov 2003 23:32:56 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Op Thursday 20 November 2003 20:37, schreef BlaisorBlade:
> > i saw the same crash.
>
> Only an oops on linux or the same oops? If the second, it's useful news

the second ... exactly the same backtrace iirc. i'll try to find the oops, but 
i'm almost sure. i've posted here to uml-devel once (subject hostfs-crash i 
believe) but google cannot find it.

> In fact, I'm seeing now 4:40, the time the oops happens, is when the
> slackware every day runs updatedb.

a-ha ! exactly the same, my oops also happent when doing updatedb...

> I think hostfs reads files just as any normal process on the host, right?
> Or it does anything special or at least unusual?

well, you could try to let uml run without hostfs a couple of days to see if 
it happens. not using hostfs definately solved my problem (uml has an uptime 
of 1month now, before i disabled hostfs it crashed every night). I also used 
skas mode, don't know if it happens in TT mode.

greetings,
frank


-- 
Frank Dekervel
Mechelsestraat 88
3000 Leuven
frank.dekervel@student.kuleuven.ac.be, (nieuw) 0473/94.34.21


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
