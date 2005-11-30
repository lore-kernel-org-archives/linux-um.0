Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhJTQ-0003vb-Vy for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 20:21:40 -0800
Received: from cod.sandelman.ca ([192.139.46.139] helo=lists.sandelman.ca)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1EhJTP-0003c5-FV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 20:21:40 -0800
Received: from sandelman.ottawa.on.ca (desk.marajade.sandelman.ca
	[205.150.200.247])
	by lists.sandelman.ca (8.11.6p3/8.11.6) with ESMTP id jAU4LLd04221
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified
	OK) for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Nov 2005 23:21:28 -0500 (EST)
Received: from sandelman.ottawa.on.ca (unknown [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id EE3353AD9C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Nov 2005 23:20:50 -0500 (EST)
From: "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
Message-ID: <12276.1133324450@sandelman.ottawa.on.ca>
Subject: [uml-devel] 2.6.15-rc2
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
Date: Tue, 29 Nov 2005 23:20:50 -0500
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Running a kernel which is not 2.6.15-rc2 (but a couple of merges back,
looking for a place where it works), I get:


Initializing software serial port version 1
Failed to open 'root_fs', errno = 2
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1228KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
Stub registers -
        0 - bffff000
        1 - 1000
        2 - 3
        3 - 11
        4 - 3
        5 - 0
        6 - bffff000
        7 - 7b
        8 - 7b
        9 - 0
        10 - 0
        11 - ffffffff
        12 - bfffe092
        13 - 73
        14 - 10246
        15 - bffff7fc
        16 - 7b
Kernel panic - not syncing: copy_context_skas0 : failed to wait for SIGUSR1/SIGTRAP, pid = 5136, n = 5136, errno = 0, status = 0xb7f

If I try with "mode=tt", (vs skas0) it boots, but on shutdown, I get:

EIP: 0073:[<40101e18>] CPU: 0 Not tainted ESP: 007b:bf8cec8c EFLAGS: 00000246
    Not tainted
EAX: ffffffda EBX: 40189880 ECX: ffffffff EDX: 00000000
ESI: bf8ced38 EDI: 00000000 EBP: bf8cec98 DS: 007b ES: 007b
a09ff800:  [<a00395bf>] show_regs+0x1cf/0x1e0
a09ff828:  [<a001d25c>] panic_exit+0x2c/0x50
a09ff838:  [<a00506cd>] notifier_call_chain+0x2d/0x50
a09ff858:  [<a003d922>] panic+0x72/0x110
a09ff874:  [<a0022d1e>] wait_stub_done+0xfe/0x180
a09ff8f4:  [<a0023792>] copy_context_skas0+0x1c2/0x270
a09ff9d4:  [<a0022aac>] init_new_context_skas+0x11c/0x1b0
a09ffa08:  [<a003bf97>] copy_mm+0x367/0x3a0
a09ffa50:  [<a003c969>] copy_process+0x499/0xe60
a09ffb40:  [<a003d39e>] do_fork+0x6e/0x1ca
a09ffbac:  [<a001a33b>] sys_fork+0x8b/0xb0
a09ffbe0:  [<a0024512>] handle_syscall+0x112/0x140
a09ffc5c:  [<a0022ed1>] handle_trap+0x31/0x140
a09ffc84:  [<a002357a>] userspace+0x1da/0x230
a09ffce0:  [<a0023f35>] new_thread_handler+0xe5/0x120
a09ffd20:  [<a01cb468>] __restore+0x0/0x8


- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBQ40ooYCLcPvd0N1lAQKgQAgAm4Zqe5GwOORmKwklwJ1j6VyAxxdDikYg
d10leRKAy+wDi1/TMqhrGgyZ3DUy4O0kr1rbK7n6iMUeo8CrH1WCscNGXc5WbUnC
eLLv9SP/qDkn3ghe0/RXq8YHB+LqciDFSp+yMD27YNCND0Dn3N1yHYMN6u4CJXX6
zNgUKljzDQzeQIlxPN4z3uBsJLcwK+VUyOS51ti4KDcbhkGBKSozCFhxqwze2yTc
1I4CjH2oXXK5b8kJ5ohecz4ZAcGJ8SlbpujxoPNCvIMhFVeoRpHuNkf60y/R0iTL
jY65J3c47noU8gecD19Vs5eI+XDfO6o0vmgKDu3NaCXb2oacdLRXcQ==
=qQzM
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
