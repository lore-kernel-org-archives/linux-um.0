Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <001f01c3f990$c5c3dba0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <1077259546.6429.56.camel@upupandaway.homenet>
	<200402202139.40555.blaisorblade_spam@yahoo.it>
	<013d01c3f7f5$23ae2790$0201a8c0@hawk>
	<200402221549.24742.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] Host 2.6.2/3 + CFQ + BlaisorBlade
	patches == host panic
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
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
Date: Sun, 22 Feb 2004 16:11:06 -0600
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

> So you have enabled CONFIG_SMP, right? In that situation the code above needs
> to be changed - I need some more thinking to understand what must be done.

Yes, this is a dual-xeon box with CONFIG_SMP.  This machine has been assigned to
active duty back on my 2.4 host kernel, but I have new machines coming in this
week.  I'll gladly test whatever you need.

Thanks,
-Chris



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
