Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb5JI-0001fo-98 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:06:00 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb5JG-0000T3-Ga
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:06:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 03:05:50 +0200
References: <452C29F2.8050908@theshore.net>
	<200610140243.00086.blaisorblade@yahoo.it>
	<20061016144453.GB4350@ccure.user-mode-linux.org>
In-Reply-To: <20061016144453.GB4350@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210305.50736.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x92c00000, ip 0x80bcead
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
Cc: Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>

On Monday 16 October 2006 16:44, Jeff Dike wrote:
> On Sat, Oct 14, 2006 at 02:42:59AM +0200, Blaisorblade wrote:
> > > > Kernel panic - not syncing: Kernel mode fault at addr 0x92c00000, ip
> > > > 0x80bcead
> >
> > Jeff, are these addresses normal? They tell that the binary is a
> > statically linked one - but what is the memory layout? Chris, can you
> > post
> > cat /proc/<pid>/maps on a running instance of that kernel, together with
> > host and guest config (the guest's one is contained there, I know, but I
> > don't have the time to extract).
>
> I'm not sure.  I've never trusted the numbers coming from that panic
> message (which hurts debugging, I know).  I don't believe the fault
> address, and the IP doesn't match anything in the symbol table, so I
> don't believe that either.
Ok, this is an issue, too.
> Yup, that sounds like a good idea.
>
> 				Jeff
Btw fixing even the above issue (if possible) would be another good idea - any 
major difficulty on that?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
