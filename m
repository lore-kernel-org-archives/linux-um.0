Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpFVr-00014B-Mc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:40:27 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpFVm-0000kC-KW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:40:27 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Fix stack corruption
References: <200501121856.j0CIuMiZ003766@ccure.user-mode-linux.org>
	<200501140127.09333.blaisorblade@yahoo.it>
	<001201c4f9d0$fbde9a40$0201a8c0@hawk>
In-Reply-To: <001201c4f9d0$fbde9a40$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501140142.45389.blaisorblade@yahoo.it>
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
Date: Fri, 14 Jan 2005 01:42:45 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 14 January 2005 01:35, Christopher S. Aker wrote:
> > > I believe we've figured out that this is skas3 specific.  Once you
> > > start ping-flooding the UML, it crashes within a second.
> >
> > I wasn't able to riproduce it... I ran two instances of the above loop +
> > a ping flood from the host, but it didn't crash UML, even after letting
> > it that way for some minutes.
>
> What UML version are you running?  Also, can you reproduce it without
> Jeff's patch?
Sorry, forgot about that - I did the test only on 2.6.9-SKASv7 host and 
2.6.9-bb4 guest.
> Under skas3, I can't crash my UML's using Jeff's "ls > /dev/null" method,
> with or without his patch.

> I've been able to reproduce my crash
I've forgot to look at your recipe - I'll do it tomorrow.
> with two different host kernels, an 
> older 2.6.4, and the newest 2.6.10+skas-v7.  Guest kernels that crash that
> I've tried include 2.6.9-bb4, 2.6.10, and 2.6.10-mm2 plus the incrementals
> from yesterday.  Also, I believe Frank Sorenson is also able to reproduce
> this crash.

> Thanks,
> -Chris
Thanks to you!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
