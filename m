Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antoine@nagafix.co.uk>) id 1Rxlq7-0005At-HO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2012 20:52:35 +0000
Received: from mamba.nagafix.co.uk ([194.145.196.68] helo=mail.nagafix.co.uk)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rxlq3-0000is-Br for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2012 20:52:35 +0000
Received: (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTPSA id 3E3D96710
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Feb 2012 20:52:25 +0000 (GMT)
Message-ID: <4F3C1B06.7080506@nagafix.co.uk>
Date: Thu, 16 Feb 2012 03:52:22 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] X11 vfb forward ported to 3.2
To: user-mode-linux-devel@lists.sourceforge.net

Whilst I was looking at all the docs and patches that I have for the
wiki/uml website, I found the old x11-fb patch from Gerd Knorr's and
forward ported it to 3.2
Got as far as the point where it builds and shows a window when you
start the kernel with:
./vmlinux x11=800x600
As reported at the time of the original patch, all I get is a black
window... I'll try to see if I can figure out why it's not updating.
Here it is if you want to try it / comment / help:
http://uml.devloop.org.uk/vfb-3.2.patch

Cheers
Antoine

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

