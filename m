Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8SVG-0003uG-UK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 15:18:42 -0800
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B8SVG-0004o0-LV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 15:18:42 -0800
Message-ID: <20040330231834.3595.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
Subject: [uml-devel] Re: [PATCH] patch for linux-2.6.5-rc2
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
Date: 30 Mar 2004 23:18:34 -0000
To: user-mode-linux-devel@lists.sourceforge.net

> Works for me using stock 2.6.5-rc2 kernel with reiser4.



Vanilla 2.6.5-rc2:



bzcat uml-patch-2.6.4-1.bz2 | patch -p1

cat host+Uml-skas3-2.6.3-v1.patch | patch -p1

cat uml-patch-2.6.5-rc2 | patch -p0 (your patch you posted)



I'm able to comple an SKAS enabled host without problems.  But
the UML build fails.  Errors saying CONFIG_* not defined over
and over and over again.



:(











-----------------------------------------------

Get your FREE Christian Email Account at Praize

http://www.praize.com/email/ 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
