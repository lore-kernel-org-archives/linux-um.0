Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxUF5-00022I-O0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 10:01:11 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CxUF0-0004qg-MP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 10:01:11 -0800
Message-ID: <420509D1.2080401@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc3
References: <200502051051.46242.rob@landley.net>
In-Reply-To: <200502051051.46242.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 05 Feb 2005 11:00:49 -0700
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rob Landley wrote:
| As of yesterday afternoon, the UML build still breaks in
sys_call_table.c,
| here's the patch I submitted earlier (which got me past the break when I
| tried it).  Last week, this produced what seemed like a working UML.
|
| Now there's a second break in mm/memory.c: the move to four level page
| tables conflicts with a stub in our headers.  Not quite sure how to
fix that.
| Jeff?
|
| (Yeah, I know Andrew's tree works.  But wouldn't it be nice if the
kernel.org
| tree to worked too, before 2.6.11 release.)

This patch for sys_call_table.c was merged into the main tree in this
changeset:
http://linux.bkbits.net:8080/linux-2.5/cset@1.2080?nav=index.html|ChangeSet@-2d

The patch fixes both the sys_call_table and the pud_alloc breakage, and
as of 2.6.11-rc3-bk2, the main tree compiles again for UML.

Andrew's tree, however, (at least 2.6.11-rc3-mm1) requires the patch I
sent out yesterday in the message titled "Fix compilation of UML after
the stack-randomization patches."

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBQlRaI0dwg4A47wRAjJ8AJ9CKD/aXaz1TS9QfOO11vcsv+57BACg1CdJ
GR0ukCKAabFtJs5rVsPItGg=
=h/on
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
