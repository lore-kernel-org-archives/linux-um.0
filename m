Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5Smw-0000pF-1y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 09:00:34 -0800
Received: from web25105.mail.ukl.yahoo.com ([217.12.10.53])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B5Smv-0004Fz-Gf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 09:00:33 -0800
Message-ID: <20040322170011.8039.qmail@web25105.mail.ukl.yahoo.com>
From: =?iso-8859-1?q?maria=20maria?= <for_spam2004@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] 802.11 emulation under UML
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
Date: Mon, 22 Mar 2004 18:00:11 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

Hi!
I want to make a module based off the net daemon that
has wireless extensions.
The first thing I need to do is to make an uml
wireless daemon that simulates 802.11 protocol
(CSMA/CA: to send RTS, CTS, ACK for each packet, to
run a backoff algorithm 
to realize collision avoidance, etc...).
I would like to know where in the uml switch code is
the best place to do that.
I'm really looking for some help with uml switch
because it is pretty undocumented... I think I need to
add some set from inside uml, but I really don't know
how to do...I'm pretty new to linux.....
Can someone help me?
Thank you in advance!

Maria


______________________________________________________________________
Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati, l'antivirus, il filtro Anti-spam
http://it.yahoo.com/mail_it/foot/?http://it.mail.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
