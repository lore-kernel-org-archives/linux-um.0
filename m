Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtaGs-00063H-Ad for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 15:38:54 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtaGo-00046B-MA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 15:38:54 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501260038.13619.blaisorblade@yahoo.it>
Subject: [uml-devel] Making sure 2.6.11-rc2-bk* works
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
Date: Wed, 26 Jan 2005 00:38:13 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff, now we need actively to make sure everything we think is crucial is 
merged in 2.6.11 - release is approaching (after -rc2 only a handful of 
patches is being merged, and the announce says "Make sure I have 
everything"), so you should make sure to send Andrew anything needed on top 
of 2.6.11-rc2-bk3 (I say the -bk tree on purpose, because that's what becomes 
the real released tree) to make it compile.

Please make sure to tag the patches as "for merge before 2.6.11", otherwise 
we'll be in the 2.6.10 situation (20 patches to merge for 2.6.10, including 
the Bodo's fixes, merged just after 2.6.10).

First of all making sure that things compile... also please try to be really 
conservative, a little error anywhere can hurt stability...

Let's avoid this, PLEASE. I'm asking for this even because trying to maintain 
the -bb tree and to do some kind of Quality Assurance (i.e. especially 
answering to the various important discussions, which I do even to discover 
bugs not recognized by who saw them) is making impossible for me to do actual 
work... my development speed is slowing down too much.
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
