Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4Ger-0001HJ-3X for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 05:32:37 -0700
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G4Gep-0000VI-NN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 05:32:37 -0700
From: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20060722120530.GA25188@ccure.user-mode-linux.org>
References: <1153557998.5589.20.camel@ubuntu>
	<20060722110215.GA24905@ccure.user-mode-linux.org>
	<1153567351.7543.4.camel@ubuntu>
	<20060722120530.GA25188@ccure.user-mode-linux.org>
Date: Sat, 22 Jul 2006 15:32:32 +0300
Message-Id: <1153571552.7543.12.camel@ubuntu>
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

Hi,

On Sat, Jul 22, 2006 at 02:22:31PM +0300, Pekka Enberg wrote:
> > This is a new installation for me, so anything I should check?

On Sat, 2006-07-22 at 08:05 -0400, Jeff Dike wrote:
> I.e. both a new kernel and new filesystem?  If so, can you vary them
> to see which is at fault?

I have never run UML on this box, so yeah, everything is new including
the host. I can try a known working image on Monday when I get access to
that box. 2.6.18-rc2 works on the other box too.

Could be Ubuntu userspace too. Any known problems with that?

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
