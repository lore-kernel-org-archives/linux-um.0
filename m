Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G69mY-0006po-1H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 10:36:22 -0700
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G69mW-0000Cl-10
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 10:36:21 -0700
From: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20060727151540.GA4744@ccure.user-mode-linux.org>
References: <1153557998.5589.20.camel@ubuntu>
	<20060722110215.GA24905@ccure.user-mode-linux.org>
	<1153568869.7543.8.camel@ubuntu>
	<20060727151540.GA4744@ccure.user-mode-linux.org>
Date: Thu, 27 Jul 2006 20:36:14 +0300
Message-Id: <1154021774.7190.0.camel@ubuntu>
Mime-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

On Thu, 2006-07-27 at 11:15 -0400, Jeff Dike wrote:
> This makes me suspicious of the contents of your inittab.  Generally,
> if the getty lines refer to non-existent devices, this will happen.

Aah, you're absolutely right. I was missing /dev/tty[1-6] device nodes.
Thanks!

				Pekka


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
