Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQH53-00071f-N6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 19:17:33 -0800
Received: from alyz.com ([66.220.1.229])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CQH52-0004e7-Rk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 19:17:33 -0800
From: Allen Chan <alydar@users.sourceforge.net>
Subject: Re: [uml-devel] 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
	<200411051421.47632.alydar@users.sourceforge.net>
In-Reply-To: <200411051421.47632.alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200411052217.42754.alydar@users.sourceforge.net>
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
Date: Fri, 5 Nov 2004 22:17:42 -0500
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>

OK.  The problem was due to user error in not setting the=20
configuration option CONFIG_FD_CHAN properly.  When this option is=20
set to "Y", everything appears to work fine again.

Just in case anyone else runs into this, here's what happened.  In the=20
UML Incremental Patches site, the no-chans patch had dealt with this=20
possible problem by removing the CONFIG_FD_CHAN configuration option=20
from the config file.  However, the bb1 patch does not contain the=20
no-chans patch, so it requires that the CONFIG_FD_CHAN option be put=20
back.  For some reason, CONFIG_FD_CHAN defaulted to "N" when prompted=20
for on the screen as a new configuration option while doing a "make=20
oldconfig ARCH=3Dum" using an existing config file.

On Friday 05 November 2004 02:21 pm, Allen Chan wrote:
> I just compiled a  2.6.9 + uml-2.6.9-bb1.patch.bz2 guest kernel,
> but it hangs on my system immediately after:
>    =20
>    =A0    Initializing stdio console driver


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_idU88&alloc_id=12065&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
