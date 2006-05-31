Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlY9N-0004rc-Tj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 14:22:45 -0700
Received: from smtp1.oregonstate.edu ([128.193.0.11] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FlY9N-0006DN-Lx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 14:22:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by smtp1.oregonstate.edu (Postfix) with ESMTP id 4003E128F24
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 14:22:45 -0700 (PDT)
Received: from smtp1.oregonstate.edu ([127.0.0.1])
	by localhost (smtp1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 28109-03 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 14:22:44 -0700 (PDT)
Received: from NWS-EXCH1.nws.oregonstate.edu (nws-ex1.nws.oregonstate.edu
	[128.193.7.73])
	by smtp1.oregonstate.edu (Postfix) with ESMTP id 902A0128F22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 May 2006 14:22:44 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [uml-devel] Randomize on MAC address when bringing up ethernet
	iface
Message-ID: <7B4268E5ACB878429B58D4BE5B780E83010B6896@NWS-EXCH2.nws.oregonstate.edu>
From: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
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
Date: Wed, 31 May 2006 14:22:43 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

> -----Original Message-----
> On Tue, May 30, 2006 at 08:12:59PM +0200, Blaisorblade wrote:
> > I've being thinking to this and I'm wondering why we 
> shouldn't do it. When we
> > have set no IP or 0.0.0.0, which is not a unique IP, and we 
> bring it up, we 
> > should choose a random MAC to use.
> > Conditions: the broadcast bit must be 0 and the 
> "locally-assigned address 
> > flag" must be 1 (as likely we already do).
> 
> Yeah, this sounds like a good idea.

This sounds good to me, provided we can still override on the
command-line. I like having the flexibility of knowing what MAC address
a guest will have before the instance is launched.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
