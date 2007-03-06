Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOewc-0001KT-Qs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 11:03:31 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOewZ-0001kA-WC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 11:03:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 6 Mar 2007 20:02:54 +0100
References: <e3156df0612142300if4a4d8akabae7f81d0d6695e@mail.gmail.com>
	<200703052339.39509.blaisorblade@yahoo.it>
	<007a01c75f7f$9ee595c0$fe0fa8c0@ispbrasil>
In-Reply-To: <007a01c75f7f$9ee595c0$fe0fa8c0@ispbrasil>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703062002.54337.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] broken uml_util.spec
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
Cc: Ilkka Tengvall <ilkka.tengvall@iki.fi>, Itamar Reis Peixoto <itamar@ispbrasil.com.br>

On Tuesday 06 March 2007 00:40, Itamar Reis Peixoto wrote:
> about uml_util.spec, this patch have yo fixed the problem of unpackaged
> file (jail_uml)?
>
> %attr(755,root,root)                    %{_sbindir}/jail_uml
Yes, it includes this change.
Note I've not yet published a new release. It will be published on my 
homepage.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
