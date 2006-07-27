Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6AOg-0007YG-PP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 11:15:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G67ar-0004kA-Lt
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 08:16:11 -0700
Date: Thu, 27 Jul 2006 11:15:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060727151540.GA4744@ccure.user-mode-linux.org>
References: <1153557998.5589.20.camel@ubuntu>
	<20060722110215.GA24905@ccure.user-mode-linux.org>
	<1153568869.7543.8.camel@ubuntu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1153568869.7543.8.camel@ubuntu>
Subject: Re: [uml-devel] UML hangs after forking gettys
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
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 22, 2006 at 02:47:49PM +0300, Pekka Enberg wrote:
> Oh, and if I wait long enough, I get:
> 
> Starting PCMCIA services: module directory /lib/modules/2.6.16/pcmcia
> not found.
> Starting deferred execution scheduler: atd.
> Starting periodic command scheduler: cron.
> INIT: Id "1" respawning too fast: disabled for 5 minutes
> INIT: Id "2" respawning too fast: disabled for 5 minutes
> INIT: Id "3" respawning too fast: disabled for 5 minutes
> INIT: Id "4" respawning too fast: disabled for 5 minutes
> INIT: Id "5" respawning too fast: disabled for 5 minutes
> INIT: Id "6" respawning too fast: disabled for 5 minutes
> INIT: no more processes left in this runlevel

This makes me suspicious of the contents of your inittab.  Generally,
if the getty lines refer to non-existent devices, this will happen.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
