Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDRJq-0005fI-Kh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 10:03:30 -0700
Received: from ns.lbox.cz ([62.129.50.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDRJq-0008OM-51 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 10:03:30 -0700
Received: from mail.cubenet.cz (mail.cubenet.cz [62.129.60.162])
	by ns.lbox.cz (8.11.6/8.11.6) with ESMTP id i3DH3Rs02769
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Apr 2004 19:03:27 +0200
Received: from linuxbox.linuxbox.cz ([10.76.66.10])
	by mail.cubenet.cz (8.11.6/8.11.6) with ESMTP id i3DH3O905694
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Apr 2004 19:03:24 +0200
Received: from linuxbox.linuxbox.cz (localhost.localdomain [127.0.0.1])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i3DH1442031078
	for <user-mode-linux-devel@lists.sourceforge.net.OUTNOCOPY>;
	Tue, 13 Apr 2004 19:01:04 +0200
Received: (from mail@localhost)
	by linuxbox.linuxbox.cz (8.12.8/8.12.8/Submit) id i3DH14wd031073
	for user-mode-linux-devel@lists.sourceforge.net.OUTNOCOPY;
	Tue, 13 Apr 2004 19:01:04 +0200
Received: from [10.76.66.13] (develbox.linuxbox.cz [10.76.66.13])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i3DH1042031060
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Apr 2004 19:01:00 +0200
From: Nikola Ciprich <extmaillist@linuxbox.cz>
Content-Type: text/plain
Message-Id: <1081875793.19343.90.camel@develbox>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] openswan @ missing symbols strstr & memset
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
Date: Tue, 13 Apr 2004 19:03:14 +0200
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>

Hello, I was trying to get openswan working under UML, module compiles
fine, but trying to load it fails with complaint about unresolved symbol
memset and strstr
I've found that those symbols are exported in i386 ksyms, but not in uml
ksyms, so I've created little patch (enclosed), and everythink seems to
work well. I'd like to ask, if my solution is 'clean' and if yes,
wouldn;t it be usefull to add all such missing symbols (for work wish
strings etc). if yes, i'd gladly create patch for inclusion
thanks
nik
applied patch:

diff -Naur linux-2.4.25/arch/um/kernel/ksyms.c
linux-2.4.25-uml-fixmissingsymbols/arch/um/kernel/ksyms.c
--- linux-2.4.25/arch/um/kernel/ksyms.c Tue Apr 13 08:35:36 2004
+++ linux-2.4.25-uml-fixmissingsymbols/arch/um/kernel/ksyms.c   Tue Apr
13 08:32:55 2004
@@ -23,6 +23,7 @@

 EXPORT_SYMBOL(stop);
 EXPORT_SYMBOL(strtok);
+EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(uml_physmem);
 EXPORT_SYMBOL(set_signals);
 EXPORT_SYMBOL(get_signals);
@@ -111,6 +112,14 @@
 EXPORT_SYMBOL(smp_num_cpus);

 #endif
+
+#undef memcpy
+#undef memset
+extern void * memset(void *,int,__kernel_size_t);
+extern void * memcpy(void *,const void *,__kernel_size_t);
+EXPORT_SYMBOL_NOVERS(memcpy);
+EXPORT_SYMBOL_NOVERS(memset);
+

 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
