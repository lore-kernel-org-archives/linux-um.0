Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUAba-0004Li-7Z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 13:11:14 -0800
Received: from alchar.org ([66.92.236.138] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUAbT-0007Im-3X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 13:11:14 -0800
From: Kris Van Hees <aedil@alchar.org>
Message-ID: <20041116211102.GA340@alchar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Problem booting UML 2.4.26 compiled with gcc 3.3.4
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
Date: Tue, 16 Nov 2004 16:11:02 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Has anyone else experienced trouble with running a UML kernel 2.4.26 that was
compiled with GCC 3.3.4?  My instances ran perfectly fine (compiled) with
GCC 2.94 but when I upgraded my GCC and recompiled everything, suddenly they
started giving me trouble, ranging from tracing thread crashes to kernel mode
panics.

	Kris
-- 
Never underestimate a Mage with:
 - the Intelligence to cast Magic Missile,
 - the Constitution to survive the first hit, and
 - the Dexterity to run fast enough to avoid being hit a second time.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
