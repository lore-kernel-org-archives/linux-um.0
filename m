Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxqkQ-0007mQ-Ux for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Feb 2005 10:03:02 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CxqkQ-0008SK-88
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Feb 2005 10:03:02 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc3
References: <200502051051.46242.rob@landley.net>
	<420509D1.2080401@tuxrocks.com>
In-Reply-To: <420509D1.2080401@tuxrocks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502061200.33755.rob@landley.net>
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
Date: Sun, 6 Feb 2005 12:00:33 -0500
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

On Saturday 05 February 2005 01:00 pm, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Rob Landley wrote:
> | As of yesterday afternoon, the UML build still breaks in
> | sys_call_table.c,
...
> This patch for sys_call_table.c was merged into the main tree in this
> changeset:
> http://linux.bkbits.net:8080/linux-2.5/cset@1.2080?nav=index.html|ChangeSet
>@-2d
>
> The patch fixes both the sys_call_table and the pud_alloc breakage, and
> as of 2.6.11-rc3-bk2, the main tree compiles again for UML.

Verified.  2.6.11-rc3-bk2 does indeed build, and the result is chugging 
through my big compile script.  It seems to be working fine, although ye olde 
display glitch is still there:

binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.rd
binutils-2.14/ld/testsuite/lde/ld-/ld-sld-spd-spa-sparsparcparc/arc/trc/tlc/tls/tlsstlssulssunssunbsunbiunbinnbin6bin64in64.n64.s64.s4.s.ss
binubinutinutinutilutilstils-ils-2ls-2.s-2.1-2.142.14/.14/l14/ld4/ld//ld/tld/ted/tes/testtestsestsustsuitsuitsuiteuite/ite/lte/lde/ld-/ld-sld-spd-spa-sparsparcparc/tlssunbin64.sd
binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.td

But that's a purely cosmetic bug.

Thanks,

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
