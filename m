Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <004f01c40486$3adfa2c0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200402221604.19495.blaisorblade_spam@yahoo.it>
	<20040223083801.GA28222@elte.hu>
	<200402231851.i1NIp2mX024424@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] New Skas patch for 2.6 and SMP
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
Date: Sun, 7 Mar 2004 14:53:20 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net

> I've uploaded a new SKAS patch on the site. Follow instructions on the 
> homepage (http://www.user-mode-linux.org/~blaisorblade). It is against 2.6.3 
> but applies cleanly on 2.6.0 and probably the kernels in between. It contains 
> a change for CONFIG_SMP only, which I hope will solve the problems you get.
> 
> The change has been reviewed on uml-devel, however be careful with it - I do 
> not have any SMP box to test it.
> 
> For UP kernels that patch carries no changes.
> 
> Hope It Works! Bye

This has been working great for me for the past couple of days -- no problems!

Thanks,
-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
