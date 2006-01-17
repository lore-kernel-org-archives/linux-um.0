Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyfId-0004OU-Oi for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:06:15 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyfIc-0001V6-7F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:06:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601170126.12774.blaisorblade@yahoo.it>
Subject: [uml-devel] slip_init and slirp_init using 12K of stack
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
Date: Tue, 17 Jan 2006 01:26:12 +0100
To: user-mode-linux-devel@lists.sourceforge.net

I ran by accident scripts/checkstack.pl and found that slip_init and 
slirp_init are two big offenders.

They are since of such lines:

        *spri = ((struct slip_data)
                { .name         = { '\0' },
                  .addr         = NULL,
                  .gate_addr    = init->gate_addr,
                  .slave        = -1,
                  .slip         = SLIP_PROTO_INIT,
                  .dev          = dev });

This is compiled (as it seems from the assembly, and as I read from a 
discussion on LKML on how badly GCC optimizes that) compiled as "set this up 
on the stack, memcpy it on the stack, and memcpy it on the final area".

struct slip_data (and the same for slirp_data) contains slip_proto, which is 
6K wide (has two large buffers). Having it twice on the stack gives 12k, 
which explains this output:

$ objdump -d
/home/paolo/Admin/kernel/6/VCS/um-linux-2.6.15-build/vmlinux| ./scripts/checkstack.pl 
i386|head -20

0xa021e0a6 _IO_vfwprintf:                               37512
0xa0020d62 slirp_init:                                  12880
0xa0020e8a slirp_init:                                  12880
0xa0020258 slip_init:                                   12112
0xa0020351 slip_init:                                   12112
...
0xa000515c make_umid_setup:                             4144
0xa002bc16 make_tempfile:                               4128
0xa002bd29 make_tempfile:                               4128

(I remember these to store a PATH_MAX char array on the stack). But 
make_umid_setup just disappeared (the rewritten umid abstraction doesn't use 
significant stack space).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
