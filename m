Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4FFn-0001ps-OE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 04:02:40 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G4FFl-0007Uy-Lr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 04:02:39 -0700
Date: Sat, 22 Jul 2006 07:02:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060722110215.GA24905@ccure.user-mode-linux.org>
References: <1153557998.5589.20.camel@ubuntu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1153557998.5589.20.camel@ubuntu>
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

On Sat, Jul 22, 2006 at 11:46:37AM +0300, Pekka Enberg wrote:
> I have a problem with UML compiled from 2.6.18-rc2 git head. The kernel
> boots fine and starts up the userspace but hangs completely after
> forking gettys. I have port-helper in /usr/lib/uml but it doesn't seem
> to start up.

The gettys are all sleeping.  I would think that at least some of them
would be reading or selecting.  I believe there's a few second pause
before getty puts out a login prompt.  Maybe the delay code is
horribly broken.

Can you boot it single-user and time a sleep?

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
