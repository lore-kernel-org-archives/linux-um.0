Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QVuS2-0000DY-DH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 23:52:18 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QVuS0-0005Uv-K2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 23:52:18 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 13 Jun 2011 01:45:27 +0200
References: <201106121314.39884.florian@openwrt.org>
In-Reply-To: <201106121314.39884.florian@openwrt.org>
MIME-Version: 1.0
Message-Id: <201106130145.27424.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 1/2] um: disable funit-at-a-time for gcc <
	4.3
To: Florian Fainelli <florian@openwrt.org>
Cc: nico@openwrt.org, user-mode-linux-devel@lists.sourceforge.net

Am Sonntag 12 Juni 2011, 13:14:39 schrieb Florian Fainelli:
> From: Nicolas Thill <nico@openwrt.org>
> 
> Building UML with gcc < 4.3 with -funit-at-a-time for i386 causes startup
> crashes, disabling funit-at-a-time works around it.

Can you show me such a crash?
How can I reproduce the issue?

UML works fine on my RHEL5/i386 test box.
gcc 4.1.2 20080704 (Red Hat 4.1.2-46)

Thanks,
//richard

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

