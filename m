Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtZXX-0003Lb-Gq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 14:52:03 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtZXV-0008AQ-Ln for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 14:52:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252351.15875.blaisorblade@yahoo.it>
Subject: [uml-devel] 2.6.9-bs6 released
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
Date: Tue, 25 Jan 2005 23:51:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Ok, this is a little but important upgrade on top of 2.6.9-bb4. I hope I can 
soon release a patch for 2.6.10, but these days I've got to pass some exams 
at University. I hope I can work on this nonetheless.

Changes from -bb4 to -bs5:
* restored the MAGIC_SYSRQ config option lost in 2.6.9 vanilla.
* fixed a problem of which probably Paul Warren suffered... UML stopped early 
at boot on a few system... what Bodo Stroesser fixed was a problem when using 
the 2.6 host headers and running on 2.4

Changes from -bs5 to -bs6:
* Added the two fixes posted by Jeff Dike about the Christopher Aker 
problems... the patches are "uml-fix-stack-corruption.patch" (from the ML) 
and "uml-no-defer.patch" (from Jeff Dike's tree).

For the second one we are not yet sure it is the best possible fix ever, but 
it should work well.

In case you have problems, try unapplying it and report the result in both 
situations, together with your .config and host / guest datas, command line, 
output and so on.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
