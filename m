Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H29n5-0004yN-LC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 09:20:41 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H29n1-0004Lu-Eq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 09:20:37 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 3 Jan 2007 17:17:43 +0100
References: <45846DC1.80009@theshore.net>
In-Reply-To: <45846DC1.80009@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701031717.43505.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS v8.2 for 2.6.19 and beyond?
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
Cc: "Christopher S. Aker" <caker@theshore.net>

On Saturday 16 December 2006 23:05, Christopher S. Aker wrote:
> Blaisorblade,
>
> Any chance you'll be creating a skas v8.2 patch for 2.6.19/20 any time
> soon?  I'm still weary of this issue with skas-v9pre:
>
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=116008558424368&w=2
>
> Would it be as simple as taking the broken-out skas-v9 patch for 2.6.19
> and only patching up to a certain point in the series?
>
> Thanks!
> -Chris
Ok, I've done this release, and fixed the problem about including config.h. 
I'm aware about the other problems but I can't help at the very moment.

Bye!
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
