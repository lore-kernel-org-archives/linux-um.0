Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ0eD-0004Ry-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 17:15:17 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ0eC-0006Eh-RH
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 17:15:17 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hAA12B119109
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 9 Nov 2003 20:02:11 -0500
Message-Id: <200311100123.hAA1N2xD012758@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Child exit when booting uml 2.4.20 on 2.6.0-test4 host 
In-Reply-To: Your message of "Sun, 14 Sep 2003 19:46:05 +0200."
             <200309141946.05977.blaisorblade_spam@yahoo.it> 
References: <3F59DC82.7070900@bezeqint.net> <200309081647.h88Glrjh030128@ccure.karaya.com> <Pine.GSO.4.53.0309122100390.4368@altair.dur.ac.uk>  <200309141946.05977.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Sun, 09 Nov 2003 20:23:02 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> About 2.6, there is a little patch to implement in the uml_utilities,
> since  insmod tun doesn't work any more with the new
> module-init-tools. That must  change to modprobe tun. That is, replace
> "insmod" by "modprobe"(including  quotes!) all over uml_net/ethertap.c
> and uml_net/tuntap.c. 

Yup, fixed.  There were only three of them, though.

> If you have little  time, I can post this
> together with a patch to the spec file which is again  out of
> date(some files are not listed).

Send me a patch to the spec file, please.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
