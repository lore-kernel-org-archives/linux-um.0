Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4pzA-0007fQ-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Mar 2004 15:34:36 -0800
Received: from hoth.xs4all.nl ([213.84.241.98] helo=seven.hoth.xs4all.nl)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B4pz7-0000gY-LT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Mar 2004 15:34:33 -0800
From: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Subject: Re: [uml-devel] Kernel panic on UML linux
References: <200403200047.29359.mark.hurenkamp@xs4all.nl>
	<200403200108.i2K18Ipd004482@ccure.user-mode-linux.org>
In-Reply-To: <200403200108.i2K18Ipd004482@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403210034.27325.mark.hurenkamp@xs4all.nl>
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
Date: Sun, 21 Mar 2004 00:34:27 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Can you make it happen with a stock UML.  I've heard things about gentoo
> adding bugs to UML.
Yep, also occurs with stock 2.4.24 kernel with patch (from the sf site) 
applied. I also tried to run it from a Suse 9.0 host, same problem.

> If you can make it happen with a stock UML, get a stack trace from the
> panic.
Forgive me for being ignorant, but how can I create such a stack trace?
The UML doesn't dump core, and I've not been able to run it from gdb
or ddd properly (yet :-).

Regards,
Mark.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
