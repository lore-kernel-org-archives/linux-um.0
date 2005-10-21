Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET1Z0-0004or-EC	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 11:24:22 -0700
Received: from moutng.kundenserver.de ([212.227.126.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ET1Yy-00068H-G7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 11:24:22 -0700
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1ET1Yq-0006VT-00	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 20:24:12 +0200
Received: from [84.58.154.32] (helo=gate.lan.gerd-stolpmann.de)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1ET1Yq-0002Ur-00	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 20:24:12 +0200
Received: from flakew.lan.gerd-stolpmann.de (flakew.lan.gerd-stolpmann.de
	[192.168.0.32])
	by gate.lan.gerd-stolpmann.de (Postfix) with ESMTP id 1D374C0AD
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Oct 2005 20:24:12 +0200 (CEST)
From: Gerd Stolpmann <info@gerd-stolpmann.de>
Content-Type: text/plain
Message-Id: <1129919051.27787.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Strange behaviour of hwrng
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 21 Oct 2005 20:24:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi list,

I recently tested the hwrng driver. In principal, it works, but it
sometimes eats up all host CPU time. In particular, I can see that the
UML system does a (blocking) read on /dev/hwrng, and that the host
system loops while reading from /dev/random which almost always returns
-EAGAIN. (Found that out with strace, in the hope the output is
correct.)

Nevertheless rngd seems to work, because when killing with SIGUSR1 it
shows some reasonable statistics.

My test setup is as follows:

- Host system: 2.6.12.6 with SKAS3 v8.2 patch
- UML system: 2.6.14-rc5, in SKAS3 mode.
  Using rngd from Debian Sarge.
  TLS is disabled.

Let me know if you need more information.

Gerd
-- 
------------------------------------------------------------
Gerd Stolpmann * Viktoriastr. 45 * 64293 Darmstadt * Germany 
gerd@gerd-stolpmann.de          http://www.gerd-stolpmann.de
Telefon: 06151/153855                  Telefax: 06151/997714
------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
