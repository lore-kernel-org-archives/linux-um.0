Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlWph-0000sC-IQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 12:58:21 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FlWph-00079W-7H
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 12:58:21 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FlWoI-00074Z-WC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 21:56:55 +0200
Received: from jameson.reflexsecurity.com ([72.54.64.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 21:56:54 +0200
Received: from lunz by jameson.reflexsecurity.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 21:56:54 +0200
From: Jason Lunz <lunz@falooley.org>
Message-ID: <e5kscm$tt3$1@sea.gmane.org>
References: <200605302013.00091.blaisorblade@yahoo.it>
	<20060531190553.GA6111@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: Randomize on MAC address when bringing up ethernet
	iface
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
Date: Wed, 31 May 2006 19:56:06 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net

jdike@addtoit.com said:
> So what is the second bit?  I only know about the broadcast/multicast bit, and
> no one has bothered clueing me in on any other special bits :-)

the other one's the "locally administered" bit.  It's a lot like rfc1918
address space in ipv4, only for ethernet. wikipedia's discussion is
decent:

http://en.wikipedia.org/wiki/MAC_address
http://en.wikipedia.org/wiki/Locally_Administered_Address

those are the only two special mac address bits that i'm aware of.

The effect of setting it is that you ensure that your randomly-generated
mac address will never collide with a globally administered one. Of
course, it might collide with other locally-administered ones.

Jason



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
