Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d9S8f-0007xW-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 08:10:57 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9S8b-0006Rr-Dm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 08:10:57 +0000
Received: from [88.198.220.131] (helo=sslproxy02.your-server.de)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1d9S8V-0006ij-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:10:47 +0200
Received: from [192.168.0.30] (helo=webmail01.your-server.de)
	by sslproxy02.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.84_2)
	(envelope-from <thomas@m3y3r.de>) id 1d9S8U-0004bo-Rz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 10:10:46 +0200
Date: Sat, 13 May 2017 10:10:46 +0200
Message-ID: <20170513101046.Horde.P7MZvg1O0xNi0CnTODsXRIH@webmail.your-server.de>
From: Thomas Meyer <thomas@m3y3r.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] userfaultfd for UML userspace processes
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
To: user-mode-linux-devel@lists.sourceforge.net


Hi,

after looking into using userfaultfd for the userspace UML process  
page fault handling, I come to the conclusion that userfaultfd  
*cannot* be used for above goal as it only operates on mmaped memory  
areas.
Am I missing something? What do you think about it?

with kind regards
thomas




------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

