Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvrpV-0008WU-Q0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 22:48:05 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CvrpU-00072q-Dp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 22:48:05 -0800
Message-ID: <41FF261A.2070001@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS3: prerelease of V8 (against 2.6.9) uploaded
References: <200501290036.51182.blaisorblade@yahoo.it>
	<41FEF317.3070505@easyco.com>
In-Reply-To: <41FEF317.3070505@easyco.com>
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
Date: Mon, 31 Jan 2005 23:47:54 -0700
To: Doug Dumitru <doug@easyco.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Doug Dumitru wrote:
<snip>
| With 2.6.9 skas3 v8 a plain kill does nothing.  With a kill -9, 3 of the
| four thread die, but one remains and the only way to get rid of it is
| with a server reboot.
|
| Not sure what is going on here, but I have not been able to get anything
| past 2.6.7 to work while killing virtual rudely.

Will they die if you send a "kill -CONT" followed by the "kill -9"?

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/yYaaI0dwg4A47wRAqayAJ9SG2inXL5ts32AaHp4wFmThEBxvwCdG/zP
IlYmpS0xqBIG9HoS+MgAkUk=
=4jiQ
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
