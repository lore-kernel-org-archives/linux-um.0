Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvzvT-0002XM-0r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Feb 2005 07:26:47 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CvzvS-0000nY-Lj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Feb 2005 07:26:46 -0800
Message-ID: <41FF9FA7.3000500@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS3: prerelease of V8 (against 2.6.9) uploaded
References: <200501290036.51182.blaisorblade@yahoo.it>
	<41FEF317.3070505@easyco.com> <41FF261A.2070001@tuxrocks.com>
	<200502010848.30042.rob@landley.net>
In-Reply-To: <200502010848.30042.rob@landley.net>
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
Date: Tue, 01 Feb 2005 08:26:31 -0700
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Doug Dumitru <doug@easyco.com>, Blaisorblade <blaisorblade@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rob Landley wrote:
| If a kill -9 needs to be followed by a CONT signal to actually take
effect on
| a stopped process, why is this not a kernel bug?  (Kill -9 is supposed to
| _mean_ it.  I've always thought of it as the "with shotgun" option...)
|
| Rob

I believe there were PTRACE changes in 2.6.9 that caused this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109877438509709&w=2

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/5+naI0dwg4A47wRApyhAJwKVrAZiH8bcxwGlx/6GSSyPdNr7gCglcfo
i0d67JyivfwJSiZv+yk7Wp8=
=W8eb
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
