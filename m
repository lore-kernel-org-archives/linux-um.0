Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lanas@securenet.net>) id 1LPEmv-0004he-Pu
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 11:28:57 +0000
Received: from ms.securenet.net ([205.236.147.20])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LPEmm-0003OQ-QJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 11:28:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by ms.securenet.net (Postfix) with ESMTP id 783A3B8EA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Jan 2009 06:28:23 -0500 (EST)
Received: from ms.securenet.net ([127.0.0.1])
	by localhost (ms.securenet.net [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id 2jBkeUjTZlHP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Jan 2009 06:28:18 -0500 (EST)
Received: from mistral.stie (mtl-pppoe-adsl630.securenet.net [66.38.238.121])
	by ms.securenet.net (Postfix) with ESMTP id 37C98B8B0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Jan 2009 06:28:18 -0500 (EST)
Date: Tue, 20 Jan 2009 06:29:33 -0500
From: lanas <lanas@securenet.net>
Message-ID: <20090120062933.68f10690@mistral.stie>
In-Reply-To: <497561E8.9070902@hathawaymix.org>
References: <49754AB5.3000701@hathawaymix.org>
	<20090120045959.GA18187@c2.user-mode-linux.org>
	<497561E8.9070902@hathawaymix.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] UML: spurious interrupt freezes guest
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

On Mon, 19 Jan 2009 22:32:24 -0700,
Shane Hathaway <shane@hathawaymix.org> wrote :

> The best way I found to trigger the spurious interrupt was to try to
> "apt-get install" many packages at once.  The download would succeed,
> but the guest would freeze partway through the install.

That makes me think, recently I did an 'apt-get dist-upgrade' on about
10 UMLs at the same time and many of them segfaulted.  UMLs are 2.6.26
and host is Fedora 8 32 bits with 1 GB RAM.  UMLS have their memory set
at 128 MB.  I figured I was pushing a bit, so I did not took notes and
ended up rebooting the host to get a clean slate.

Al

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
