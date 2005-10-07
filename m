Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENtSv-00038u-Rb	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 07:44:53 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ENtSr-0007xh-DL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 07:44:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] echo 0 > /proc/sysemu == failed to wait at end of
	syscall
References: <4344BF5F.8000603@theshore.net>
	<200510062115.54882.blaisorblade@yahoo.it> <434581F8.1070800@theshore.net>
In-Reply-To: <434581F8.1070800@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510071644.55248.blaisorblade@yahoo.it>
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
Date: Fri, 7 Oct 2005 16:44:55 +0200
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 06 October 2005 21:58, Christopher S. Aker wrote:
> Blaisorblade wrote:
> > On Thursday 06 October 2005 08:08, Christopher S. Aker wrote:
> > >2.6.13.3-um

> > Which host, and which guest mode (SKAS0 vs. SKAS3)?

> 2.6.7 with the skas patch right before the strace bug was fixed (like,
> 2.6.7-skas3-v4?) It's ancient, and most likely contributes to this issue.

Ah, in that case it's known, and was fixed at the host level. /proc/sysemu had 
been tested, but only on 2.4 hosts, and 2.6 behaviour differed.

>  > And which SKAS patch (btw, any news on the host SMP crash)?

> Yes, I get crashes with this kernel, too. So, whatever it is, it's 
> likely been in SKAS for a long time.

> -Chris

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
