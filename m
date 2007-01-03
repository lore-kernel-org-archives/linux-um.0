Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H29n8-0004yT-M2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 09:20:43 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H29n3-0004Mw-Pb
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 09:20:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 3 Jan 2007 17:20:15 +0100
References: <20061130202411.GA8628@knob.reflex>
In-Reply-To: <20061130202411.GA8628@knob.reflex>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701031720.15508.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix skas-2.6.19-rc6-v9-pre9 compile for
	linux 2.6.19
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
To: Jason Lunz <lunz@falooley.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 30 November 2006 21:24, Jason Lunz wrote:
> linux/config.h is now included automatically. #including it by hand is a
> build error in 2.6.19; this removes the three instances in the latest
> skas3-2.6 patch.
>
> Jason
I'm sorry to be so late, I've finally fixed this, and released also the 
2.6.19 -v8.2 patchset.
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
