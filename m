Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1UNlQ7-00020m-B6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Apr 2013 14:45:43 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UNlQ5-0006iR-ED
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Apr 2013 14:45:43 +0000
Message-ID: <515D9208.2090004@nod.at>
Date: Thu, 04 Apr 2013 16:45:28 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <515D7179.1070002@openwrt.org> <5783794.b5gPVMPLlO@bender>
	<2521.1363798017@warthog.procyon.org.uk>
	<5149F353.1080505@openwrt.org>
	<27081.1365084578@warthog.procyon.org.uk>
In-Reply-To: <27081.1365084578@warthog.procyon.org.uk>
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
Subject: Re: [uml-devel] [PATCH] UM: fix make headers_install after UAPI
	header installation
To: David Howells <dhowells@redhat.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Am 04.04.2013 16:09, schrieb David Howells:
> Florian Fainelli <florian@openwrt.org> wrote:
>
>> David, am I completely irrelevant here or do you think this should indeed need
>> fixing?
>
> I think headers installation for UM is pointless, but that's just my opinion.

Same here. :)

Florian, does it break something for you?

Thanks,
//richard

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

