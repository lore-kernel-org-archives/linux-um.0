Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJcob-0000Ba-73 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 12:05:05 -0700
Received: from dsl-29-66.cofs.net ([68.142.29.66] helo=kevlar.burdell.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJcoa-0005Ed-K8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 12:05:05 -0700
From: Sonny Rao <sonny@burdell.org>
Subject: Re: [uml-devel] Re: [uml-user] UML on PPC? state of the art
Message-ID: <20041018190251.GA7836@kevlar.burdell.org>
References: <415408E40001A675@ms001msg.mail.fw>
	<200410181948.22460.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410181948.22460.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 18 Oct 2004 15:02:51 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, stefano.melchior@fastwebnet.it
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 18, 2004 at 07:48:22PM +0200, BlaisorBlade wrote:
> On Monday 18 October 2004 17:58, SteX wrote:
> > Hi all,
> > does anyone know if the porting of UML on PPC has still been staled? or
> > anyone has started working on?
> > My Apple Powerbook is crying! ((:-((
> 
> > I found something about the porting on Chris Emerson's home page, but it
> > is staled sice july 2001!
> Where's that page?
> > Let me know.
> >
> > Thank you in advance
> >
> > Regards
> >
> > SteX
> Nobody is working on the PPC port. If someone wants to start helping, we will 
> welcome him. Currently, the interest in UML is increasing, new developers 
> come in, and after a lot of time, a new architecture (x86_64) is being 
> supported. Also we've seen messages from people starting work to port UML 
> even to ARM machines(!). No actual code, yet, so I suppose they stopped.
> 
> However, nobody removed the old code from UML. It has even been accepted in 
> the 2.6 kernel, even if it is completely broken.
> 
> If you can bring up this issue on any place where someone could pick it up, 
> you could find someone helping.
> 

The linuxppc64-dev@ozlabs.org is probably a good place to get help on
the ppc64 stuff.  Those guys know ppc so I'm guessing that asking
about ppc32 stuff is cool as well.  

I'd be willing to test UML on PPC64 if work commences, I have access
to some IBM Power[345] machines.  I'd love to help in development, but
I'm pretty busy right now, so I'll just volunteer to test it. 

Sonny Rao
--
LTC Kernel Performance Team


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
