Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUdZk-0007Hj-6O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 23:48:38 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HUdZf-00008Q-JB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 23:48:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 23 Mar 2007 07:47:50 +0100
References: <20070322160643.GA7012@c2.user-mode-linux.org>
In-Reply-To: <20070322160643.GA7012@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703230747.50306.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [ PATCH 4/7 ] UML - create as-layout.h
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
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On Thursday 22 March 2007 17:06, Jeff Dike wrote:
> This patch moves all the the symbols defined in um_arch.c, which are
> mostly boundaries between different parts of the UML kernel address
> space, to a new header, as-layout.h.  There are also a few things here
> which aren't really related to address space layout, but which don't
> really have a better place to go.

Hey, I do like _these_ patches! A nice picture in that header could then be 
added (in the very future ;-) ), but at least one knows there are so much of 
them. And user_util.h is no more!

;-)

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
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
