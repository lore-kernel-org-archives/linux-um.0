Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWD99-0007tx-Sa for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Oct 2006 07:27:23 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GWD98-0005OC-8n
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Oct 2006 07:27:23 -0700
Message-ID: <4527B93B.8070508@linuxbox.cz>
Date: Sat, 07 Oct 2006 17:27:07 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <451E9BAB.5030009@linuxbox.cz>	<200610011725.16069.blaisorblade@yahoo.it>	<451FE3F0.1070304@linuxbox.cz>
	<200610052214.31864.blaisorblade@yahoo.it>
In-Reply-To: <200610052214.31864.blaisorblade@yahoo.it>
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

Yes, You're right, reverting this particular patch fixed the problem, so 
it boots now...
All other problems (halt problem with x86_64 guest and hang trying to 
run i386 guest) persist
Is there something else I could try to fix those or find where the 
problem is?
thanks in advance!
nik.

Blaisorblade wrote:
> Ok, you are the second user reporting this problem. Some option is not being 
> parsed correctly by UML, so it is passed to init.
>
> So you obtain this as a regression in -bb1... try unapplying 
> patches/tls/x86-64-support.diff (you find separate patches in the broken-out 
> folder in the archive).
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
