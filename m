Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWKfx-0000kj-QT
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 11:16:09 -0800
Received: from tektonic.net
	([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AWKfx-0007h6-Bz
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 11:16:09 -0800
Subject: Re: [uml-devel] uml-patch-2.4.22-7
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <Pine.LNX.4.44.0312161250240.3476-100000@sparrow>
References: <Pine.LNX.4.44.0312161250240.3476-100000@sparrow>
Content-Type: text/plain
Message-Id: <1071602165.3374.23.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Dec 2003 14:16:05 -0500
To: William Stearns <wstearns@pobox.com>
Cc: Jeff Dike <jdike@addtoit.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Well, when reboot/shutdown -r is run from within a UML it shuts down and
then states "INIT: no more processes in this runlevel" running
2.4.22-um6.  I searched Google and saw that some people had this problem
when UM_FASTCALL wasn't set, however I did a grep on my .config file and
didn't not find that option.

Is this most likely why my reboots are not working?  How do I enable it?
Right now I am using the djc 2.4.23 kernel so I would assume he would
turn this on.

A point in the right direction would be very appreciated as this is a
bit of a pain at the moment.  I'll also be testing the /dev/anon
functionality very much as soon as that is released.

On Tue, 2003-12-16 at 12:53, William Stearns wrote:
> Good day, Matt,
> 
> On Tue, 16 Dec 2003, Jeff Dike wrote:
> 
> > matta@tektonic.net said:
> > > Does reboot work inside UML's properly yet? :P (in the sense it will
> > > restart the UML)  
> > 
> > It works now, and as far as I know, it has always worked.
> 
> 	I can confirm it works in at least my setup on the UML Coop.  
> Reboot shuts down the current VM, starting a new one in its place.  Can 
> you describe what doesn't work?
> 	Cheers,
> 	- Bill
> 
> ---------------------------------------------------------------------------
> 	"Love is a snowmobile racing across the tundra and then suddenly it
> flips over, pinning you underneath.  At night, the ice weasels come."
> 	-- Matt Groening
> (Courtesy of Steve Dodd <dirk@loth.demon.co.uk>)
> --------------------------------------------------------------------------
> William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
> rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
> Linux articles at:                         http://www.opensourcedigest.com
> --------------------------------------------------------------------------
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
