Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyAVc-0000iw-FC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 11:54:56 -0700
Received: from relay-bm.club-internet.fr ([194.158.104.68])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JyAVb-0002JP-1v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 11:54:56 -0700
From: vincent-perrier <vincent-perrier@club-internet.fr>
In-Reply-To: <1210789757.25724.3.camel@localhost>
References: <20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
	<877ieb4s4n.fsf@hades.wkstn.nix>
	<20080509151604.GC10169@c2.user-mode-linux.org>
	<1210353202.31648.8.camel@localhost>
	<20080514172347.GA10283@c2.user-mode-linux.org>
	<1210789757.25724.3.camel@localhost>
Date: Mon, 19 May 2008 20:54:19 +0200
Message-Id: <1211223259.5412.7.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] plug_and_play_clownix_network
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net

You are right, the private key is useless for my purposes, the clownix
daemon just has to copy the public key to the ssh authorized keys file
inside the UML guest machines, then the access to the UML guests can
be done without password.
In my next version of the clownix network, I will not "muck" with the
private rsa key. 
> > 
> > Why is it mucking with root's ssh keys:
> > 
> >   RSA_PUB=/root/.ssh/id_rsa.pub
> >   RSA_PRIV=/root/.ssh/id_rsa
> > 
> > 			Jeff
> > 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
