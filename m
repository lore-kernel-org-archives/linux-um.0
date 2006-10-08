Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWePZ-0001b0-3A for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 12:34:09 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GWePX-0007Ro-Fw
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 12:34:09 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 8 Oct 2006 21:30:52 +0200
References: <451E9BAB.5030009@linuxbox.cz>
	<200610081304.39570.blaisorblade@yahoo.it>
	<45294CBD.2010602@linuxbox.cz>
In-Reply-To: <45294CBD.2010602@linuxbox.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610082130.52498.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>

On Sunday 08 October 2006 21:08, Nikola Ciprich wrote:
> Hello Paolo,
> I've spent half a day today trying all variants, and well, I'm no longer
> able to reproduce the problem :(
> In fact now APPLYING your patch seems to cause the problem, which is of
> course weird.
The patch will cause the problem if applied without another certain patch, so 
it means that 2.6.18-mm2 does not contain it. I can't be sure without the 
compilation error but I can guess it is the problem.

> So please consider this false bugreport until I'm able to find out how
> the hell did I manage to do it.
> If I'm reading my confusing posts to this list, I'm starting to feel a
> bit stupid, sorry for them :-/
Do not worry, it happens - you've falsified your bugreport, normally someone 
else must do it (in one occasion I've received configuration files from the 
wrong machine, i.e. "this is my host config" while it was the guest one, 
wondered a bit and then pointed kindly this possibility to the poster, who 
recognized promptly his error).

> I'll certainly have to track all my attempts and compilations, as I'm
> having quite a mess in it then...
> n.
>
> > Since you've said that that patch does not fix pcap compilation, post the
> > compilation error (both with and without the patch) so I know what
> > happens there. Assuming that pcap compiles on your system for stable
> > kernels (i.e. libpcap.a is installed), as you imply in your report.
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your opinions on IT & business topics through brief surveys -- and earn
> cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
