Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwLYP-00085W-2a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 11:18:17 -0700
Received: from relay-cv.club-internet.fr ([194.158.96.103])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwLYN-0002uf-Lo
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 May 2008 11:18:17 -0700
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
Date: Wed, 14 May 2008 20:18:13 +0200
Message-Id: <1210789093.25558.10.camel@localhost>
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

I forgot to tell you, if you launch the daemon as a normal user,
the RSA files of this normal user will be used, and not the root
ones.
And also, the daemon has to mount a file when it creates the ubdb 
config file, one more reason to have the root sticky bit.

This tool is made for network study and tests, a standalone PC
is good enough to use it and observe routing daemons at work.
 

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
