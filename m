Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfPgA-0001pi-5r for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Jan 2004 12:25:54 -0800
Received: from [217.73.129.129] (helo=linuxhacker.ru
	ident=[TXXwA8P/WSwCNGqKobMx6XFgPkEo6clw])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AfPg5-0003Y5-T4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Jan 2004 12:25:50 -0800
Message-Id: <200401102025.i0AKPXeA004382@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com>
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
Date: Sat, 10 Jan 2004 22:25:33 +0200
To: nuno.silva@vgertech.com, user-mode-linux-devel@lists.sourceforge.net

Hello!

Nuno Silva <nuno.silva@vgertech.com> wrote:

NS> I've been trying for days and made lots of tests and it seems that the
NS> 2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled glibc.

Hm. I guess you are running some sort of old uml code.
The fix was oneliner and included long ago. See the patch below.
Apply it and then recompile.

I use 2.6.1 + glibc 2.3.2-101 from Fedora Core 1,
I hope this is new enough? ;)

Bye,
    Oleg

--- linux-2.4.20.orig/arch/um/link.ld.in	2003-10-25 00:35:59.000000000 +0400
+++ linux-2.4.20/arch/um/link.ld.in	2003-10-25 00:36:02.000000000 +0400
@@ -6,7 +6,6 @@
 {
   . = START() + SIZEOF_HEADERS;
 
-  . = ALIGN(4096);
   __binary_start = .;
 ifdef(`MODE_TT', `
   .thread_private : {


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
