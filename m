Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dhowells@redhat.com>) id 1UIMAY-0008Tw-HZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Mar 2013 16:47:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UIMAX-0007wa-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Mar 2013 16:47:18 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5783794.b5gPVMPLlO@bender>
References: <5783794.b5gPVMPLlO@bender>
Date: Wed, 20 Mar 2013 16:46:57 +0000
Message-ID: <2521.1363798017@warthog.procyon.org.uk>
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

> Commit 10b63956 (UAPI: Plumb the UAPI Kbuilds into the user
> header installation and checking) breaks UML make headers_install with
> the following:

Ummm...  Why would you do that?  Surely UML doesn't have its own userspace,
but rather borrows from the host arch?

David

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

