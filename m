Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArRjM-0000sg-36
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 17:02:56 -0800
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1ArRhv-00019T-Dx
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 17:01:27 -0800
From: Michael Koehne <kraehe@copyleft.de>
Subject: Re: [uml-devel] Which UPS simulator?
Message-ID: <20040213010127.GA3172@bakunin.copyleft.de>
References: <20040212052823.GA4203@erizo.shearer.org> <20040212150023.GA32317@bakunin.copyleft.de> <20040212230844.GV4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212230844.GV4203@erizo.shearer.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 02:01:27 +0100
To: Dan Shearer <dan@shearer.org>, user-mode-linux-devel@lists.sourceforge.net

Moin Dan Shearer,

> That is exactly what I want to avoid. I want a more accurate UML where
> no UML-specific logic is needed for communication -- from one point of
> view that is what communication is all about. There are plenty of ways
> of introducing new communications methods (such as you have done, or a
> special listening port, etc) into the UML. 

  implementing an UPS would also only require existing uml technics, as
  APC and Berkin UPS are talking to a serial line. But it would require
  some special program running inside and outside your UML, while my
  simple script only require to cad line to be right.

  see http://quasar.mathstat.uottawa.ca/~selinger/ups/simulator.c
  for Berkin simulator and demons, or reference apcupsd for APC 
  and reverse enginier a simulator.

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
