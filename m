Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BotL8-0005RH-7s for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 17:27:38 -0700
Received: from dsl027-162-124.atl1.dsl.speakeasy.net ([216.27.162.124]
	helo=kevlar.burdell.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BotL7-0005R9-Op
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 17:27:38 -0700
Received: from kevlar.burdell.org (localhost [127.0.0.1])
	by kevlar.burdell.org (8.12.10/8.12.10) with ESMTP id i6Q0RO3p011484
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 25 Jul 2004 20:27:24 -0400 (EDT)
	(envelope-from sonny@kevlar.burdell.org)
Received: (from sonny@localhost)
	by kevlar.burdell.org (8.12.10/8.12.10/Submit) id i6Q0ROCG011483
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jul 2004 20:27:24 -0400 (EDT) (envelope-from sonny)
From: Sonny Rao <sonny@burdell.org>
Message-ID: <20040726002724.GA11374@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Kallsyms on UML
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
Date: Sun, 25 Jul 2004 20:27:24 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Hi, I'm fairly new to UML, and I've begun using it for development of some
kernel patches, and I am really impressed w/ UML!  

I had one question, I noticed that on stack traces I'm not getting
symbols even though I had CONFIG_KALLSYMS enabled.  I looked into it a
bit more and it appears that the kernel build system is running
scripts/kallsyms but not getting any symbols in the output in
.tmp_kallsyms[12].S  But If I run the "linux" binary through kallsyms
instead of vmlinux, I do get back what seems like a proper symbol
table.  Is it that simple to make it work?

Also, I changed arch/um/kernel/sysrq.c to call print_symbol() in the
show_trace function, and I seemed to get decent backtraces, but I'm
not sure if they're 100% accurate.

Thanks,

Sonny


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
