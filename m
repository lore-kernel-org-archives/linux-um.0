Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2sv0-0004gt-CM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 07:50:30 -0700
Received: from pcp242763pcs.howard01.md.comcast.net ([68.55.81.27]
	helo=mail.freeside.dnsalias.org)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C2suz-0000xY-QC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Sep 2004 07:50:30 -0700
From: Carl Holtje <lists@freeside.dnsalias.org>
Message-ID: <Pine.LNX.4.58.0409021039040.26986@fire.freeside.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Processes & ptrace
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
Date: Thu, 2 Sep 2004 10:50:22 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

All-

I'm looking to port user mode linux (UML) to the ARM platform. To this
end, I've acquired an iPAQ running the 0.7.2 version of the Familiar linux
distro (http://familiar.handhelds.org/), running the
2.4.19-rmk6-pxa1-hh30 kernel.

According to the UML porting page
(http://user-mode-linux.sourceforge.net/arch-port.html),
the first step is to ensure system call numbers are changeable by ptrace,
and they provide small C program to compile and test with. The iPAQ
"fails" this test as child processes have different pids than their
parents.

This seems rather contrary, however, to other observations about the
system. For example, a listing from top shows processes and their
associated pid and ppid fields -- many processes report proper parents
(ppid matches reasonable pids). I would certainly hope Familiar is not
monkeying with things to make it appear this way...

Admitidly, this sounds like a question for the Familiar folks, but I'm
wondering if this is a kernel issue, and if it's since been fixed in more
recent kernel versions. (Familiar hasn't been updated in quite some time)

I'm looking to use the 2.6 kernel for both host and guests, especially
with 2.6.9-rc1-mm1 containing UML 'natively'. I've looked through the
kernel changelogs for any helpful nuggets to this end, but have come home
empty handed.

Thanks in advance for any insight!

Carl



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
