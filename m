Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX9kO-0001Zg-7D
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:48:08 -0800
Received: from godel.catalyst.net.nz ([202.49.159.12] helo=mail2.catalyst.net.nz)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AX9kN-0003iB-EQ
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:48:07 -0800
Message-ID: <3FE258A5.9010809@catalyst.net.nz>
From: Srdjan <srdjan@catalyst.net.nz>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Bug#224431: user-mode-linux: Hangs
References: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz> <20031219002949.GX18100@alcor.net> <20031219014756.GC4945@ccure.user-mode-linux.org>
In-Reply-To: <20031219014756.GC4945@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 19 Dec 2003 14:47:17 +1300
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431-forwarded@bugs.debian.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Well I'm not an expert in the field, so this is what I can come up with without further help:


GNU gdb 6.0-debian
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...(no debugging symbols found)...
0xa01502b1 in ?? ()
/tmp/gdb_init-WPLjKv:2: Error in sourced command file:
No symbol table is loaded.  Use the "file" command.
(gdb) Quit
(gdb) bt
#0  0xa01502b1 in ?? ()
Error accessing memory address 0xa01f3f50: No such process.


Jeff Dike wrote:
| On Thu, Dec 18, 2003 at 04:29:49PM -0800, Matt Zimmerman wrote:
| 
|>Apparently, tt mode is broken.  I use skas, which is working fine in
|>2.4.22-7um-1, but I can reproduce your failure with mode=tt.
| 
| 
| Hmmm, I can't.  It seems fine here.
| 
| Can you run it with 'debug' and get a stack trace from the hang?
| 
| 				Jeff
| 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/4lilX4ZD19jq88YRAgdkAJ97f65d3PLQJyerVx4NulzLeMAcoACfaq4T
B8otHB0tb+Zazhwnugw6s+o=
=3Fu7
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
