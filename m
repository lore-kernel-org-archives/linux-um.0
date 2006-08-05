Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9Kcp-0003sa-IX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Aug 2006 04:47:27 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G9Kcm-00011M-Lc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Aug 2006 04:47:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 5 Aug 2006 13:47:26 +0200
References: <200607070033.k670XhQR008707@ccure.user-mode-linux.org>
	<517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
In-Reply-To: <517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608051347.26926.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 10/19] UML - Remove spinlock wrapper functions
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
To: user-mode-linux-devel@lists.sourceforge.net, sandr8@gmail.com
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Friday 04 August 2006 15:00, alessandro salvatori wrote:
> Jeff,
>
>    the new lock irq_lock is still static, but we now have preprocessor
> macros to be included from a header file

Are you talking about spin_lock_irqsave & co? In that case you have maybe 
missed that the removed functions were simply wrappers for spin_lock_irqsave. 
Those wrappers existed to be used in files which can't include kernel headers 
(long story).

> instead of non-static functions in 
> the same module as the static irq_lock.

> Am I missing something?
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
