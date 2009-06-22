Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mjcoss@alcatel-lucent.com>) id 1MIjL0-00013o-Dv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jun 2009 13:13:30 +0000
Received: from ihemail4.lucent.com ([135.245.0.39])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MIjKz-0003CY-42
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jun 2009 13:13:30 +0000
Received: from umail.lucent.com (h135-3-40-61.lucent.com [135.3.40.61])
	by ihemail4.lucent.com (8.13.8/IER-o) with ESMTP id n5MCwuLm006411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Jun 2009 07:58:56 -0500 (CDT)
Received: from [172.31.133.231] (win285233wks.be.alcatel-lucent.com
	[172.31.133.231])
	by umail.lucent.com (8.13.8/TPES) with ESMTP id n5MCws3Q013683
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Jun 2009 07:58:55 -0500 (CDT)
From: Michael J Coss <mjcoss@alcatel-lucent.com>
Date: Mon, 22 Jun 2009 14:58:14 +0200
Message-Id: <1245675494.5551.10.camel@mjcoss-c2.research.bell-labs.com>
Mime-Version: 1.0
Subject: [uml-devel] Before I go to far down this road
Reply-To: mjcoss@alcatel-lucent.com
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

I'm looking at doing some work on DRM modules in the latest (2.6.30-rcX)
kernel.  I would like to UML to assist in debugging.  I've gotten UML to
compile, and "boot" the linux-2.6.30-rc8 kernel.  I can log in, and run
commands, etc.  It does however appear to be a bit unstable, So here's
my question.  To debug a DRM module, I would assume that I need to
extend the emulation to include a virtual graphics card. I'm interested
in trying to track down basic stability issue: memory leaks, locking
issues, etc in the DRM code.  

Bottom line is, is this doable?  And I guess more importantly, is it
more work than it's worth?

Thanks in advance for any insights.



------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

