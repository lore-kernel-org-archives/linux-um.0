Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpFQA-0000ow-70 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:34:34 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CpFQ8-0008K7-Pi for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:34:34 -0800
Message-ID: <001201c4f9d0$fbde9a40$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200501121856.j0CIuMiZ003766@ccure.user-mode-linux.org>
	<002001c4f9c7$de282ec0$0201a8c0@hawk>
	<200501140127.09333.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Fix stack corruption
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 13 Jan 2005 18:35:43 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > I believe we've figured out that this is skas3 specific.  Once you start
> > ping-flooding the UML, it crashes within a second.
> I wasn't able to riproduce it... I ran two instances of the above loop + a
> ping flood from the host, but it didn't crash UML, even after letting it that
> way for some minutes.

What UML version are you running?  Also, can you reproduce it without Jeff's patch?

Under skas3, I can't crash my UML's using Jeff's "ls > /dev/null" method, with or
without his patch.

I've been able to reproduce my crash with two different host kernels, an older 2.6.4,
and the newest 2.6.10+skas-v7.  Guest kernels that crash that I've tried include
2.6.9-bb4, 2.6.10, and 2.6.10-mm2 plus the incrementals from yesterday.  Also, I
believe Frank Sorenson is also able to reproduce this crash.

Thanks,
-Chris



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
