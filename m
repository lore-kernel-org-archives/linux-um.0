Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZU11-0004Z2-HN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 08:04:31 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GZU0y-000777-Rd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 08:04:31 -0700
Date: Mon, 16 Oct 2006 11:02:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061016150259.GA4381@ccure.user-mode-linux.org>
References: <451E9BAB.5030009@linuxbox.cz>
	<200610082130.52498.blaisorblade@yahoo.it>
	<452958FD.3020400@linuxbox.cz>
	<200610140223.09328.blaisorblade@yahoo.it>
	<1160817830.11878.9.camel@nik-nb>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1160817830.11878.9.camel@nik-nb>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64	guest, 
	problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 14, 2006 at 12:23:50PM +0300, Nikola Ciprich wrote:
> 1) You mentioned GIT, do You use it? or Jeff? I haven't noticed any UML
> git branch...

I don't.  I use quilt, although I occasionally construct a git tree
when there's something in -linux that I need to look at.

> 2) I'm still worried about this halt problem on amd64, can You give me
> some tips I could track it down??

The hang happens at the very end of the shutdown sequence, after all
services have been turned off?

IIRC, you said that stracing UML shows a VTALRM-handling loop and that
the UML is consuming all available CPU.  Those two statements are not
consistent, AFIAK, since there should be no busy loops in UML
(although I can imagine bugs which could induce one) and the VTALRM
loop is the sign of the idle loop, which isn't busy.

So, could you confirm all this, and also get a stack trace from the
hang?

			Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
