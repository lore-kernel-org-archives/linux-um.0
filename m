Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWepX-00066M-S8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 09:51:55 -0800
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWepW-0000va-MI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 09:51:55 -0800
Received: from mail (dopez.xs4all.nl [213.84.79.27])
	by smtp-vbr10.xs4all.nl (8.12.11/8.12.11) with ESMTP id iANHpp4r004699
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Nov 2004 18:51:51 +0100 (CET)
	(envelope-from lists@dopez.xs4all.nl)
Received: from lanclt1 ([192.168.2.101] helo=p2800.dopez.hq)
	by dopez.xs4all.nl with esmtp (Exim 3.35 #1 (Debian))
	id 1CWepS-0005YP-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Nov 2004 18:51:50 +0100
From: dopez <lists@dopez.xs4all.nl>
Subject: Re: [uml-devel] Re: 2.6.9-bb3 creates zombie threads in SKAS
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
	<001001c4d184$ca00b9f0$0201a8c0@hawk>
In-Reply-To: <001001c4d184$ca00b9f0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200411231853.31315.lists@dopez.xs4all.nl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Tue, 23 Nov 2004 18:53:31 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 23 November 2004 18:49, Christopher S. Aker wrote:

> > What the hell! This should *not* happen. What did we (I mean developers)
> > do?
>
> Just to be clear, these were zombies *inside* UML, not on the host.  I'm
> happy to blame it on the older SKAS version.

i am running 2.6.9-skas3-v7 with 2.6.9-bb3 and i too am seeing zombies in skas 
mode, inside the UML

i also saw this with 2.6.9-bb2 btw, is there anything usefull i can send to 
the list ? (kernel configs, dmesg?)

fwiw, running debian sarge on both the host and uml's


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
