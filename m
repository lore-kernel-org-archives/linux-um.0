Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwRkC-0000yW-3R for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 12:04:28 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101]
	helo=sparrow.stearns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwRad-000124-AX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 11:54:35 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] [PATCH] fix for 2.6 scheduler crashes
In-Reply-To: <20040226180157.GA3192@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0402261447560.2524-100000@sparrow>
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
Date: Thu, 26 Feb 2004 14:54:19 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>
Cc: blaisorblade_spam@yahoo.it, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good afternoon, Jeff,

On Thu, 26 Feb 2004, Jeff Dike wrote:

> The patch below fixes the 2.6 scheduler crash.  It's another subtle signal
> problem.  This one is caused by siglongjmp restoring the old signal mask
> before calling longjmp.  See the comment for the gory details.  I've had
> the stress test running for more than an hour with this patch.  Without it,
> it would be lucky to go for five minutes.

	Many thanks for the work!
	I've got one vm with 25 copies of "while /bin/true ; do /bin/true 
; done &" running and me repeatedly logging in over ssh from the outside 
world; the load is high, but no crashes.  The system even stays 
responsive.
	Only 25 minutes of testing so far, but it looks good.  I'd like to 
give a tentative thumbs up.
	For others hoping to try this patch out, you'll need to use the 
"-l" parameter to patch to apply this; the tabs in the actual source were 
replaced with 8 spaces in Jeff's patch.
	If you'd simply like a precompiled binary, the one I'm testing is 
at http://www.stearns.org/uml/ ; the config, System.map, and linux all end 
with norecurs-patch2{,.bz2}.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "It is easy to be blinded to the essential uselessness of
computers by the sense of accomplishment you get from getting them to
work at all."
        -- Douglas Adams
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
