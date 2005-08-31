Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAXcb-0008Cs-KR	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 11:47:41 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EAXcZ-0005zy-3L
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 11:47:41 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EAXas-0004GF-J5	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 20:45:54 +0200
Received: from desk.marajade.sandelman.ca ([205.150.200.247])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Aug 2005 20:45:54 +0200
Received: from mcr by desk.marajade.sandelman.ca with local (Gmexim 0.1
	(Debian))        id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Aug 2005 20:45:54 +0200
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Message-ID: <v04q96ndy4.fsf@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Subject: [uml-devel] guest process core dump panics kernel
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
Date: Wed, 31 Aug 2005 14:44:51 -0400
To: user-mode-linux-devel@lists.sourceforge.net

--=-=-=


This is with a host:    Linux marajade.sandelman.ottawa.on.ca 2.6.12.3 #7 Thu Aug 25 10:44:07 EDT 2005 i686 GNU/Linux
        (no skas patch, I think)

guest is: 

east:/testing/pluto/basic-pluto-01# uname -a
Linux east 2.6.12.3 #2 Tue Aug 30 23:12:26 EDT 2005 i686 unknown

My process (pluto) now links with SWIG generated TCL wrappers, and it crashes
due to a bug that I haven't found yet. It takes the UML down too:

east:/testing/pluto/basic-pluto-01# Kernel panic - not syncing: Kernel mode fault at addr 0x4, ip 0xa0033dd9
 
EIP: 0073:[<a0033dd9>] CPU: 0 Not tainted ESP: 007b:a1e538b4 EFLAGS: 00010202
    Not tainted
EAX: 00000000 EBX: a1d70c98 ECX: 00000007 EDX: a1d70d08
ESI: a1d70c00 EDI: a1d70c98 EBP: a1e538bc DS: 007b ES: 007b
a1e533b8:  [<a00366c4>] show_regs+0x214/0x220
a1e533e8:  [<a001e50c>] panic_exit+0x2c/0x50
a1e533f8:  [<a004d02d>] notifier_call_chain+0x2d/0x50
a1e53418:  [<a003abd2>] panic+0x72/0x120
a1e53438:  [<a001d8b2>] segv+0x242/0x280
a1e53528:  [<a001dc7e>] segv_handler+0x13e/0x1a0
a1e53568:  [<a0021797>] sig_handler_common_tt+0xb7/0x150
a1e535c8:  [<a0031452>] sig_handler+0x22/0x40
a1e535d8:  [<a01affa8>] __restore+0x0/0x8
a1e538c0:  [<a00a9833>] elf_dump_thread_status+0x83/0xe0
a1e538f0:  [<a00a9a5e>] elf_core_dump+0x1ce/0xe30
a1e53a30:  [<a0088fc0>] do_coredump+0x200/0x240
a1e53ae0:  [<a004b257>] get_signal_to_deliver+0x297/0x400
a1e53b80:  [<a001ae76>] kern_do_signal+0x36/0x1c0
a1e53c80:  [<a001b037>] do_signal+0x37/0x40
a1e53ca0:  [<a0018fb8>] interrupt_end+0x38/0x50
a1e53cb0:  [<a00217d5>] sig_handler_common_tt+0xf5/0x150
a1e53d10:  [<a0031452>] sig_handler+0x22/0x40
a1e53d20:  [<a01affa8>] __restore+0x0/0x8

 deactivate_all_fds failed, errno = 9

-- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iQCVAwUAQxX6pYqHRg3pndX9AQH/WAP+OsUzi1Smjjm8HfccrpIzhgM5QqwzgqcP
nC7mZKV2WggJQX5W6rjnouKi9AX+bigJFbAQrmYZqIIEgFhUfu3h/xGmgWSWh29h
nNOgwT0aYiq1nhUVRiX3Hwg6XOI5Un9VA8kzvFhLLea251JubU1iC7e1bMkua0CU
935iWTdHjJ8=
=f9t1
-----END PGP SIGNATURE-----
--=-=-=--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
