Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMYrU-0006Zc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 19 Nov 2003 12:23:40 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AMYrT-0001Mv-UH
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 19 Nov 2003 12:23:40 -0800
Received: from esperi.org.uk (1000@amaterasu.srvr.nix [192.168.14.14])
	by mail.esperi.org.uk (8.12.10/8.12.10) with ESMTP id hAJKNVth001479
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 19 Nov 2003 20:23:31 GMT
From: Nix <nix@esperi.org.uk>
Message-ID: <877k1w85vh.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] skas3-related crash of the week
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
Date: Wed, 19 Nov 2003 20:23:30 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Using unmodified 2.4.22-6. sshed in through the firewall on the UML
instance, with tty logging enabled: typing exit on the last sshed-in
console froze the box yielded this on the console before UML died:

Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9

Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9

Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9

Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Kernel mode fault at addr 0x4, ip 0x400e64ce
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
Kernel panic: Segfault with no mm
In idle task - not syncing
 <0>Kernel panic: Segfault with no mm
In idle task - not syncing

EBADF is a rather odd error to get from ptrace(): I wonder if this has
the same root cause as the EMFILE error I got a couple of weeks ago? It
looks like the error came from proc_mm_get_mm(), so something like
running out of fhs might explain it. Whatever it is, it's pretty
persistent: it looks like it panic-kills every process in turn until
it runs out.

As before, post-crash the box isn't remotely close to running out of
fhs:

1437    208     8192


(Now that the instance has crashed, I have an excuse to rebuild it with
debugging turned on, so the next report like this should have
backtraces.)

-- 
`Me, I want exploding spaceships and pulverized worlds and clashes of
 billion-year-old empires *and* competently written sentences.'
                                                    --- Matt Austern


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
