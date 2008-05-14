Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwLjE-0000sG-Qg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 11:29:28 -0700
Received: from relay-dm.club-internet.fr ([194.158.104.222])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwLjD-0001xF-EW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 11:29:28 -0700
From: vincent-perrier <vincent-perrier@club-internet.fr>
In-Reply-To: <20080514172347.GA10283@c2.user-mode-linux.org>
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
Date: Wed, 14 May 2008 20:29:17 +0200
Message-Id: <1210789757.25724.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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

Sorry if you receive this message twice, but I sent 2 messages
following each other by a few minutes, and received only the 
second one, this was the first one:


Hello,
I know that I should not work as root, but I am too used to it,
so my example is done with the root user.

I am not sure that the network simulator works with another user
for the version you have, but I have checked that for next one, 
a normal user will do as long as the daemon is owned by root and
is suid root.

The daemon has to create taps, open a socket to ping, and configure
an ip address for tap, so it will always have to be suid root even
for a normal user.

The RSA files are copied into the machines at startup so as to be 
able to scp or ssh the machine without any password.
Those files are given to the machines through an ubdb config file
at uml start.

I can garantee that the software does nothing nasty with those files.



On Wed, 2008-05-14 at 13:23 -0400, Jeff Dike wrote:
> On Fri, May 09, 2008 at 07:13:22PM +0200, vincent-perrier wrote:
> > The download is long, the untar too, but the freeze is garanteed!
> > 
> > to start after download: 
> > 
> > "./start_clownix_net virtual_platform_configs/single_machine"
> > 
> > Hope you try it!
> 
> Why is it mucking with root's ssh keys:
> 
>   RSA_PUB=/root/.ssh/id_rsa.pub
>   RSA_PRIV=/root/.ssh/id_rsa
> 
> 			Jeff
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
