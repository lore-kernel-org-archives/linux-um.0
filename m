Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alh7W-0006Vs-WB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:16:06 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alh7W-0002PL-Dy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:16:06 -0800
Message-Id: <200401280439.i0S4dUZw005532@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4 
In-Reply-To: Your message of "Tue, 27 Jan 2004 23:28:07 GMT."
	<Pine.LNX.4.58.0401272326020.25787@ucontrol.mobiledns.com> 
References: <1075236841.15950.10.camel@rocket.innercite.com>
	<Pine.LNX.4.58.0401272326020.25787@ucontrol.mobiledns.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 27 Jan 2004 23:39:30 -0500
To: Steven James <pyro@linuxlabs.com>
Cc: Phil Nadeau <phil@innercite.com>, user-mode-linux-devel@lists.sourceforge.net

pyro@linuxlabs.com said:
> I ran into that as well, but didn't have time to do much about it. As
> a further datapoint, if I disable all net support and pass it init=/
> bin/bash, I get the bash prompt (ubd filesystems do get checked/
> mounted) but then it goes into the idle loop and stays there. 

Hmmm.

If you could get a stack trace from the last call to schedule, that would be
handy.  You could automate it with
	comm <n>
	bt
	c
	end

with breakpoint <n> attached to schedule().

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
