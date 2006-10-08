Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWWVU-0005Ew-UO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 04:07:44 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GWWVQ-0006R9-9b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 04:07:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 8 Oct 2006 13:04:39 +0200
References: <451E9BAB.5030009@linuxbox.cz> <45202C79.5080502@linuxbox.cz>
	<200610051333.15711.blaisorblade@yahoo.it>
In-Reply-To: <200610051333.15711.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610081304.39570.blaisorblade@yahoo.it>
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

On Thursday 05 October 2006 13:33, Blaisorblade wrote:
> On Sunday 01 October 2006 23:00, Nikola Ciprich wrote:
> > OK, so I've tested 2.6.18-mm2, results are:
> > pcap network transport seems to be broken, and doesn't compile, I had to
> > disable it
>
> Attached patch should fix it (it's against git head but should be the same
> thing).
Since you've said that that patch does not fix pcap compilation, post the 
compilation error (both with and without the patch) so I know what happens 
there. Assuming that pcap compiles on your system for stable kernels (i.e. 
libpcap.a is installed), as you imply in your report.

> > apart from that, all of behavior described before remains the same,
> > nothing behaves neither better, nor worse...
> > n.

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
