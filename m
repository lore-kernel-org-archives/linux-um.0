Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aescf-0006U8-8B for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 01:08:05 -0800
Received: from [81.193.166.163] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aesce-0000Tp-Po for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 01:08:05 -0800
Received: from vgertech.com (puma [10.0.2.15])
	by puma-vgertech.no-ip.com (Postfix) with ESMTP id 46E459A899C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  9 Jan 2004 09:09:55 +0000 (WET)
Message-ID: <3FFE6FE3.8090303@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled glibc
	problem
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
Date: Fri, 09 Jan 2004 09:09:55 +0000
To: user-mode-linux-devel@lists.sourceforge.net


Hi!

I've been trying for days and made lots of tests and it seems that the
2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled glibc.

I've made some tests that you can check here:
http://sourceforge.net/mailarchive/message.php?msg_id=6897520

This setup without tls+nptl (glibc compiled with
--enable-addons=linuxthreads) works fine with UML.

Sooner or later everybody will have 2.6 and the new glibc :-)

Any tips?

Regards,
Nuno Silva








-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
