Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dhowells@redhat.com>) id 1UNkrW-0007mX-Fp
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Apr 2013 14:09:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UNkrV-0005LC-8g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Apr 2013 14:09:58 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <515D7179.1070002@openwrt.org>
References: <515D7179.1070002@openwrt.org> <5783794.b5gPVMPLlO@bender>
	<2521.1363798017@warthog.procyon.org.uk>
	<5149F353.1080505@openwrt.org>
Date: Thu, 04 Apr 2013 15:09:38 +0100
Message-ID: <27081.1365084578@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] UM: fix make headers_install after UAPI
	header installation
To: Florian Fainelli <florian@openwrt.org>
Cc: dhowells@redhat.com, richard@nod.at, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Florian Fainelli <florian@openwrt.org> wrote:

> David, am I completely irrelevant here or do you think this should indeed need
> fixing?

I think headers installation for UM is pointless, but that's just my opinion.

David

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

