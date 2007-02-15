Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHdXC-00005o-IV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 02:08:14 -0800
Received: from mail-gw2.sa.eol.hu ([212.108.200.109])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHdXA-0005mX-TJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 02:08:14 -0800
In-reply-to: <20070215002205.GA8099@ccure.user-mode-linux.org> (message from
	Jeff Dike on Wed, 14 Feb 2007 19:22:05 -0500)
References: <E1HFEIB-0000nJ-00@dorka.pomaz.szeredi.hu>
	<20070208195711.GA6607@ccure.user-mode-linux.org>
	<E1HFFeC-0000wJ-00@dorka.pomaz.szeredi.hu>
	<20070215002205.GA8099@ccure.user-mode-linux.org>
Message-Id: <E1HHdWm-0005jr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 Feb 2007 11:07:48 +0100
Subject: Re: [uml-devel] UML hang with 100% CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> > Strangely enough after continuing in gdb, UML is back to normal, and I
> > can't make it hang any more.  It must be something timing related.
> 
> Can you see if the patch below fixes it?

Yay!  Got my nice fast UML back instead of ugly slow QEmu ;)

Seems to work perfectly now.

Thanks,
Miklos

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
