Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByqhU-0002N2-TS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 04:39:52 -0700
Received: from mail.stral.net ([61.14.141.91] helo=ns1.stral.net ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1ByqhP-0002h8-1n
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 04:39:52 -0700
Reply-To: <ralston@stral.net>
From: "Michael Ralston" <ralston@stral.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1093091667.5430.4.camel@vinay.gsecone.com>
Message-ID: <E1ByqhP-0002h8-1n@sc8-sf-mx1.sourceforge.net>
Subject: [uml-devel] Status of SKAS + TLS/NPTL
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
Date: Sun, 22 Aug 2004 21:39:10 +1000
To: user-mode-linux-devel@lists.sourceforge.net

Just a quick question...

Wondering what the status of running a SKAS host with a user mode linux
guest with a 2.6.x kernel and Thread-Local-Storage in Libc6...

Does this still crash? If so what needs to be done to get this working?

Michael Ralston
Stral.net

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.735 / Virus Database: 489 - Release Date: 6/08/2004
 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
