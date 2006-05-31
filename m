Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlUkj-0000MN-RO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 10:45:05 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlUkj-0002Qj-Tz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 10:45:05 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FlUkf-00019m-IO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 10:45:05 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Randomize on MAC address when bringing up
	ethernet iface
References: <200605302013.00091.blaisorblade@yahoo.it>
	<e5kik9$k5d$1@sea.gmane.org>
In-Reply-To: <e5kik9$k5d$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605311924.03674.blaisorblade@yahoo.it>
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
Date: Wed, 31 May 2006 19:24:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jason Lunz <lunz@falooley.org>

On Wednesday 31 May 2006 19:09, Jason Lunz wrote:
> blaisorblade@yahoo.it said:
> > I've being thinking to this and I'm wondering why we shouldn't do it.
> > When we have set no IP or 0.0.0.0, which is not a unique IP, and we bring
> > it up, we should choose a random MAC to use.

> I agree this makes sense. Currently I'm forced to do it in a script.
>
> It's especially silly that uml virtual ethernet devices *don't* get
> random mac addresses automatically, while tuntap virtual ethernet
> devices *do* (in the same kernel tree!).

> > Conditions: the broadcast bit must be 0 and the "locally-assigned address
> > flag" must be 1 (as likely we already do).
>
> random_ether_addr() in include/linux/etherdevice.h already takes care of
> this.

Correct, it would have been a pity if this didn't exist. Thanks a lot!

But because of the bit order problem, when I saw on some messages randomly 
assigned MACs (either for TAP or for some other interfaces) I wrongly thought 
they were global MACs (I expected to see 0x80 as highest-order bit, for 
multicast/broadcast, and 0x40 as "local" flag).
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
