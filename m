Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SeY4T-0004xd-4j for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2012 20:52:13 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SeY4R-0002Bm-R3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2012 20:52:13 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SeY4B-0007DL-CN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2012 22:51:55 +0200
Received: from ip-176-198-232-179.unitymediagroup.de ([176.198.232.179])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jun 2012 22:51:55 +0200
Received: from osi2897 by ip-176-198-232-179.unitymediagroup.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Jun 2012 22:51:55 +0200
From: Osi2897 <osi2897@i2pmail.org>
Date: Tue, 12 Jun 2012 20:51:43 +0000 (UTC)
Message-ID: <loom.20120612T224653-479@post.gmane.org>
References: <loom.20120421T191253-852@post.gmane.org>
	<CAFLxGvybL7jTMsxD3f7p25Z-8aL9cOtJr-wi1aoO82Ykm98Ong@mail.gmail.com>
	<loom.20120422T221621-489@post.gmane.org>
Mime-Version: 1.0
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
Subject: Re: [uml-devel]
	=?utf-8?q?3=2E3=2E2=3A_conflicting_types_for_sys=5Fni?=
	=?utf-8?q?=5Fsyscall?=
To: user-mode-linux-devel@lists.sourceforge.net

Just for the records: 
Here is the solution for the problem (working with gcc 4.7):
http://comments.gmane.org/gmane.linux.kernel/1304942



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

