Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWJOI-0005Rw-Et
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 09:53:50 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AWJOH-0005Yc-Qu
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 09:53:50 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] uml-patch-2.4.22-7 
In-Reply-To: <200312161756.hBGHuqkS002588@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312161250240.3476-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 16 Dec 2003 12:53:39 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Matt Ayres <matta@tektonic.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Good day, Matt,

On Tue, 16 Dec 2003, Jeff Dike wrote:

> matta@tektonic.net said:
> > Does reboot work inside UML's properly yet? :P (in the sense it will
> > restart the UML)  
> 
> It works now, and as far as I know, it has always worked.

	I can confirm it works in at least my setup on the UML Coop.  
Reboot shuts down the current VM, starting a new one in its place.  Can 
you describe what doesn't work?
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Love is a snowmobile racing across the tundra and then suddenly it
flips over, pinning you underneath.  At night, the ice weasels come."
	-- Matt Groening
(Courtesy of Steve Dodd <dirk@loth.demon.co.uk>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
