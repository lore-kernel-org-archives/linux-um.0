Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai0Mu-0001Az-VM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 16:00:44 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai0Mu-0003l4-KP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 16:00:44 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Ai0MW-00018e-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Jan 2004 01:00:20 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <buci8f$m43$1@sea.gmane.org>
References: <Pine.GSO.4.58.0401172244290.19712@altair.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.58.0401172244290.19712@altair.dur.ac.uk>
Subject: [uml-devel] Re: cannot compile 2.6.1 uml-kernel, NPTL?
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
Date: Sun, 18 Jan 2004 00:58:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> It is however worth starting again from a clean kernel tree to make sure
> it is not old .o files causing the problems.

Shouldn't "make clean" or even "make mrproper" remove all old .o files?
I did both, it didn't help.

I now recompiled my glibc without NPTL and i can compile the UML-kernel 
again without errors.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
