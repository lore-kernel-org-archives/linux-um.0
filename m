Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiONL-0000VH-7F for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 19:47:51 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EiONJ-0005Si-LS
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 19:47:51 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.15-rc2
References: <12276.1133324450@sandelman.ottawa.on.ca>
In-Reply-To: <12276.1133324450@sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200512030447.47095.blaisorblade@yahoo.it>
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
Date: Sat, 3 Dec 2005 04:47:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Wednesday 30 November 2005 05:20, Michael Richardson wrote:
> Running a kernel which is not 2.6.15-rc2 (but a couple of merges back,
> looking for a place where it works), I get:

> If I try with "mode=tt", (vs skas0) it boots, but on shutdown, I get:

I got it too, and actually I think it's triggerable by playing with proc 
(something like ps with the "l" flag should do, but never tested). I've even 
diagnosed and sent a report to Jeff, we just need to fix it up.

It was introduced in the sysrq-t patch - some macros return 0xdeadbeef when 
SKAS mode is compile-time disabled, and have only a SKAS implementation 
(which is broken for TT mode but is used there too).

Btw, it was not in the first Allan's version that bug, it was introduced 
later.

> EIP: 0073:[<40101e18>] CPU: 0 Not tainted ESP: 007b:bf8cec8c EFLAGS:
> 00000246 Not tainted
> EAX: ffffffda EBX: 40189880 ECX: ffffffff EDX: 00000000
> ESI: bf8ced38 EDI: 00000000 EBP: bf8cec98 DS: 007b ES: 007b
> a09ff800:  [<a00395bf>] show_regs+0x1cf/0x1e0
> a09ff828:  [<a001d25c>] panic_exit+0x2c/0x50
> a09ff838:  [<a00506cd>] notifier_call_chain+0x2d/0x50
> a09ff858:  [<a003d922>] panic+0x72/0x110
> a09ff874:  [<a0022d1e>] wait_stub_done+0xfe/0x180
> a09ff8f4:  [<a0023792>] copy_context_skas0+0x1c2/0x270
> a09ff9d4:  [<a0022aac>] init_new_context_skas+0x11c/0x1b0
> a09ffa08:  [<a003bf97>] copy_mm+0x367/0x3a0
> a09ffa50:  [<a003c969>] copy_process+0x499/0xe60
> a09ffb40:  [<a003d39e>] do_fork+0x6e/0x1ca
> a09ffbac:  [<a001a33b>] sys_fork+0x8b/0xb0
> a09ffbe0:  [<a0024512>] handle_syscall+0x112/0x140
> a09ffc5c:  [<a0022ed1>] handle_trap+0x31/0x140
> a09ffc84:  [<a002357a>] userspace+0x1da/0x230
> a09ffce0:  [<a0023f35>] new_thread_handler+0xe5/0x120
> a09ffd20:  [<a01cb468>] __restore+0x0/0x8

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
