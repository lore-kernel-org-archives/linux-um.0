Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOLqd-0001Cx-Kw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:40:09 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOLqX-0007C7-Ft
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:40:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 5 Mar 2007 23:39:39 +0100
References: <e3156df0612142300if4a4d8akabae7f81d0d6695e@mail.gmail.com>
In-Reply-To: <e3156df0612142300if4a4d8akabae7f81d0d6695e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703052339.39509.blaisorblade@yahoo.it>
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
Cc: Ilkka Tengvall <ilkka.tengvall@iki.fi>

On Friday 15 December 2006 08:00, Ilkka Tengvall wrote:
> Howdy,
>
> I just dowloaded uml and gave it a shot. Seems to work nice on
> 2.6.19-rc6. While at it, I fixed the rpm spec file. It had old tag for
> license, incorrect directory name for build and was missing jail_uml
> from files list. I built it on fedora-release-6-89 .

> There is also a minor bug in the skas patch, it still uses
> include/config.h in some proc-mm files even config.h is removed from
> 19-rc6 version of kernel. Just remove those includes, and it works for
> me...
(Fixed time ago).
> I'm not a subscriber to the list.
Thanks, I've applied this some time ago to my tree, on uml_util.spec.in.

Bye
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
