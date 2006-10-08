Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWe1C-0007dB-9K for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 12:08:58 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GWe19-00028a-Kj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 12:08:58 -0700
Message-ID: <45294CBD.2010602@linuxbox.cz>
Date: Sun, 08 Oct 2006 22:08:45 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <451E9BAB.5030009@linuxbox.cz>
	<45202C79.5080502@linuxbox.cz>	<200610051333.15711.blaisorblade@yahoo.it>
	<200610081304.39570.blaisorblade@yahoo.it>
In-Reply-To: <200610081304.39570.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello Paolo,
I've spent half a day today trying all variants, and well, I'm no longer 
able to reproduce the problem :(
In fact now APPLYING your patch seems to cause the problem, which is of 
course weird.
So please consider this false bugreport until I'm able to find out how 
the hell did I manage to do it.
If I'm reading my confusing posts to this list, I'm starting to feel a 
bit stupid, sorry for them :-/
I'll certainly have to track all my attempts and compilations, as I'm 
having quite a mess in it then...
n.

> Since you've said that that patch does not fix pcap compilation, post the 
> compilation error (both with and without the patch) so I know what happens 
> there. Assuming that pcap compiles on your system for stable kernels (i.e. 
> libpcap.a is installed), as you imply in your report.
>
>   

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
