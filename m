Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yRnd-000052-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 01:00:01 -0700
Received: from smtp1.wanadoo.fr ([193.252.22.23] helo=mwinf0803.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yRnc-00033H-Pt
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 01:00:00 -0700
Received: from doggy.fute.lan (AMontsouris-108-1-3-70.w193-251.abo.wanadoo.fr [193.251.39.70])
	by mwinf0803.wanadoo.fr (SMTP Server) with ESMTP id 749BD18000BF
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 09:59:28 +0200 (CEST)
Received: from snide by doggy.fute.lan with local (Exim 3.35 #1 (Debian))
	id 19yRn5-0000Fv-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 09:59:27 +0200
From: Steve Schnepp <snide@free.fr>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
Message-ID: <20030914075927.GA977@fute.lan>
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <200309140233.h8E2X5e4007952@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309140233.h8E2X5e4007952@ccure.karaya.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 14 Sep 2003 09:59:27 +0200
To: UML Devel ML <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Sep 13, 2003 at 10:33:05PM -0400, Jeff Dike wrote:
> OK, what's so horrible about logging in?

Having to run some kind of 'logging in' daemon inside.
[ getty / sshd / telnetd / ... ]

	Steve

-- 
GPG public key available from http://snide.free.fr/gpg/snide-free.fr.asc
   Or by email to "snide at free.fr" with "send key pub" as subject
   Fingerprint: 8378 141B 2999 0A35 82D0   6D01 678F 0992 1FEA 4E51


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
