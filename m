Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvzMh-0000Ic-TC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Feb 2005 06:50:51 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CvzMg-0003wB-24
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Feb 2005 06:50:51 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SKAS3: prerelease of V8 (against 2.6.9) uploaded
References: <200501290036.51182.blaisorblade@yahoo.it>
	<41FEF317.3070505@easyco.com> <41FF261A.2070001@tuxrocks.com>
In-Reply-To: <41FF261A.2070001@tuxrocks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502010848.30042.rob@landley.net>
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
Date: Tue, 1 Feb 2005 08:48:29 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Frank Sorenson <frank@tuxrocks.com>, Doug Dumitru <doug@easyco.com>, Blaisorblade <blaisorblade@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Tuesday 01 February 2005 01:47 am, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Doug Dumitru wrote:
> <snip>
>
> | With 2.6.9 skas3 v8 a plain kill does nothing.  With a kill -9, 3 of the
> | four thread die, but one remains and the only way to get rid of it is
> | with a server reboot.
> |
> | Not sure what is going on here, but I have not been able to get anything
> | past 2.6.7 to work while killing virtual rudely.
>
> Will they die if you send a "kill -CONT" followed by the "kill -9"?
>
> Frank

If a kill -9 needs to be followed by a CONT signal to actually take effect on 
a stopped process, why is this not a kernel bug?  (Kill -9 is supposed to 
_mean_ it.  I've always thought of it as the "with shotgun" option...)

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
