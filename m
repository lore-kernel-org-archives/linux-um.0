Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1UxYya-0007xn-AS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 08:45:16 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UxYyV-0005Ay-EA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 08:45:13 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1UxYyN-000163-40 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 10:45:03 +0200
Received: from pro75-5-88-162-203-35.fbx.proxad.net ([88.162.203.35])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Jul 2013 10:45:03 +0200
Received: from g2p.code by pro75-5-88-162-203-35.fbx.proxad.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Jul 2013 10:45:03 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
Date: Fri, 12 Jul 2013 08:44:07 +0000 (UTC)
Message-ID: <krofkn$tfo$1@ger.gmane.org>
References: <51DF367C.5050307@gmail.com>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: /run/shm has replaced /dev/shm
To: user-mode-linux-devel@lists.sourceforge.net

Sorry, I didn't look at the list before sending.

The other patch does a realpath on /dev/shm which makes things
work when there's a compatibility symlink.
You might still consider a global s|/dev/shm|/run/shm|g
to be more future-proof.

> Look at /run/shm instead of /dev/shm.
> 
> Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
> To: Jeff Dike <jdike@addtoit.com>
> To: Richard Weinberger <richard@nod.at>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> ---
> There's a TMPDIR fallback so I haven't complicated this change with a fallback to /dev/shm.
> 
>  arch/um/os-Linux/mem.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)



------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

