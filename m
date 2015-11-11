Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1Zwdfc-0000qq-MV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 22:15:12 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zwdfb-0004ta-4n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 22:15:12 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 105A01D7C0B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Nov 2015 22:49:22 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 11 Nov 2015 22:49:21 +0100
From: stian@nixia.no
In-Reply-To: <5643B5A0.9080507@kot-begemot.co.uk>
References: "\"<1447079597-17816-1-git-send-email-aivanov@brocade.com>"
	<5640B5B5.7050907@kot-begemot.co.uk>"
	<1447274788.48401.3.camel@m3y3r.de>
	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
	<5643B5A0.9080507@kot-begemot.co.uk>
Message-ID: <f92188ee79c1a708a84a9bc64f8a5f02@nixia.no>
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
Subject: Re: [uml-devel] [PATCH v2] EPOLL Interrupt Controller V2.0
To: user-mode-linux-devel@lists.sourceforge.net

> I will probably add some "manual" debug code to check if the nested
> invocation happens with the debug options off.

Might be timing dependent and/or issue with nested blocking/unblocking 
of signals.
Or debug printing when it should not.

Just my two cents

Stian Skjelstad


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

