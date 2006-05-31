Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlUD6-0004Gt-6d for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 10:10:20 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlUD6-0007jq-3G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 10:10:20 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FlUCx-0008UY-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 10:10:17 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FlUCd-000238-Fx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 19:09:51 +0200
Received: from jameson.reflexsecurity.com ([72.54.64.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 19:09:51 +0200
Received: from lunz by jameson.reflexsecurity.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 19:09:51 +0200
From: Jason Lunz <lunz@falooley.org>
Message-ID: <e5kik9$k5d$1@sea.gmane.org>
References: <200605302013.00091.blaisorblade@yahoo.it>
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
Date: Wed, 31 May 2006 17:09:29 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it said:
> I've being thinking to this and I'm wondering why we shouldn't do it. When we 
> have set no IP or 0.0.0.0, which is not a unique IP, and we bring it up, we 
> should choose a random MAC to use.

I agree this makes sense. Currently I'm forced to do it in a script.

It's especially silly that uml virtual ethernet devices *don't* get
random mac addresses automatically, while tuntap virtual ethernet
devices *do* (in the same kernel tree!).

> Conditions: the broadcast bit must be 0 and the "locally-assigned address 
> flag" must be 1 (as likely we already do).

random_ether_addr() in include/linux/etherdevice.h already takes care of
this.

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
