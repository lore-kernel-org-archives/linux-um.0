Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqCc-0003UN-Hp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:03:18 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqCb-0000Q2-Uy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:03:18 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i4HM3G727759
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 00:03:16 +0200
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] 2.4.23(24?)-2 TT mode hangs on request_module
In-Reply-To: <Pine.LNX.4.44.0405172331390.27355-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405172341220.27603-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 18 May 2004 00:03:16 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 May 2004, Henrik Nordstrom wrote:

> Just rebuilt with uml-patch-2.4.26-1 and the problem remains

Here is another simpler way to reproduce the same problem not involving
iptables:

1. Compile UML 2.4.26-1 with module support

2. Boot in TT mode (not SKAS)

3. ifconfig xyzzy (or any other non-existing device)

If there is any other out there using 2.4.26-1 in TT mode (not SKAS) can 
you please try if the above hangs your umls as well, or if there is 
something peculiar with my setup triggering this but I do not think there 
is anything special with my UML tree which can trigger this kind of 
problem.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
