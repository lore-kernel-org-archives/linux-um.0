Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8pZj-0005pe-JA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Mar 2004 15:56:51 -0800
Received: from pond72.drizzle.com ([216.162.218.72] helo=cac.seattle.wa.us)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B8pZj-0001a5-Bh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Mar 2004 15:56:51 -0800
Received: from cac.seattle.wa.us (localhost.localdomain [127.0.0.1])
	by cac.seattle.wa.us (8.12.10/8.12.10) with ESMTP id i2VNuQxK025623
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Mar 2004 15:56:26 -0800
Received: from localhost (cac@localhost)
	by cac.seattle.wa.us (8.12.10/8.12.10/Submit) with ESMTP id
	i2VNuQ1e025619 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Mar 2004 15:56:26 -0800
From: "Charles A. Clinton" <cac@cac.seattle.wa.us>
Message-ID: <Pine.LNX.4.58.0403311549380.25444@cac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Segfault on UML load
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
Date: Wed, 31 Mar 2004 15:56:26 -0800 (PST)
To: user-mode-linux-devel@lists.sourceforge.net

When I build a UML kernel on my Fedora Core 1 machine, it segfaults when 
it tries to load. It looks to me like changes in binutils to support 
exec-shield have added a STACK program header at 0x00000000, causing the 
image to appear to be 2.5G in size.

Is this a:
    1) known and solved
    2) an open issue that I need to work on a fix for
    3) nobody cares
kind of problem?

(My guess is that adding some commands to arch/um/ld.link.in to disappear 
or move the STACK program header is the right way to fix it)

-- Charles


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
