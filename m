Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmQOR-0000Jh-Tf for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 22:08:51 -0700
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BmQOR-0001qs-I4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 22:08:51 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta9.adelphia.net
	(InterMail vM.6.01.03.02 201-2131-111-104-20040324) with ESMTP
	id <20040719050845.VQZQ2023.mta9.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Jul 2004 01:08:45 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1BmQOL-0000vd-TA for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 22:08:45 -0700
Resent-Message-ID: <20040719050845.GE4090@mizar.alcor.net>
Resent-To: user-mode-linux-devel@lists.sourceforge.net
Reply-To: Allen Chan <alydar@users.sourceforge.net>, 260111@bugs.debian.org
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.260111.B260111.109021086314941@bugs.debian.org>
From: Allen Chan <alydar@users.sourceforge.net>
References: <200407181816.39870.alydar@users.sourceforge.net>
In-Reply-To: <200407181816.39870.alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407190021.09363.alydar@users.sourceforge.net>
Subject: [uml-devel] Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0"
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
Date: Mon, 19 Jul 2004 00:20:59 -0400
To: 260111@bugs.debian.org
Cc: nic@plumtree.co.nz

Confirming results from Nicolas Lee, the same 2.4.26-2um-1 guest 
kernel that failed earlier with the 2.6.6-1-k7 host kernel with the 
skas3 patch now works if the output from the command line is piped to 
"tee".

This guest kernel also appears to work if on the command line, the 
stdout is redirected to a file, or if it is piped to anything that 
does not require additional user interaction (i.e., piping to "cat" 
works, but piping to "more" caused some other, probably unrelated, 
problems).


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
