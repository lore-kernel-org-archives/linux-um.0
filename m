Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlipU-0006F0-PX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 01:46:56 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FlipT-0001H0-Ds
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 01:46:56 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Randomize on MAC address when bringing up ethernet
	iface
References: <7B4268E5ACB878429B58D4BE5B780E83010B6896@NWS-EXCH2.nws.oregonstate.edu>
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83010B6896@NWS-EXCH2.nws.oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011046.20338.blaisorblade@yahoo.it>
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
Date: Thu, 1 Jun 2006 10:46:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>

On Wednesday 31 May 2006 23:22, Brock, Anthony - NET wrote:
> > -----Original Message-----
> >
> > On Tue, May 30, 2006 at 08:12:59PM +0200, Blaisorblade wrote:
> > > I've being thinking to this and I'm wondering why we
> >
> > shouldn't do it. When we
> >
> > > have set no IP or 0.0.0.0, which is not a unique IP, and we
> >
> > bring it up, we
> >
> > > should choose a random MAC to use.
> > > Conditions: the broadcast bit must be 0 and the
> >
> > "locally-assigned address
> >
> > > flag" must be 1 (as likely we already do).
> >
> > Yeah, this sounds like a good idea.

> This sounds good to me, provided we can still override on the
> command-line. I like having the flexibility of knowing what MAC address
> a guest will have before the instance is launched.
For sure.

I've thought to add a check that the address is a 
http://en.wikipedia.org/wiki/Locally_Administered_Address
But I think the Linux network stack doesn't enforce that (inside the guest you 
can violate the rule with ifconfig) so it wouldn't make sense to enforce it 
ourselves.
We should add a warning though, for the user who cares and who didn't want to 
break rules.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
