Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoSRp-0000f4-7m
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 11:12:29 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AoSRo-0005Aw-Q0
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 11:12:28 -0800
From: Matt Ayres <matta@tektonic.net>
Content-Type: text/plain
Message-Id: <1075921947.7569.7.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Hang on boot with 2.6.*
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 04 Feb 2004 14:12:27 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm still fairly new to UML so perhaps this is a known issue and there
is a simple workaround.

I've tried 2.6.1-1um, 2.6.0-1um, 2.6.0-test9-1um, Ingo's A7 combo patch,
and Blaisorblade's v8 patches for 2.6.0.  On every single one whenever I
try to boot it just hangs when it should be starting init (aka. After
"Mounted devfs on /dev").

So it's obvious it's probably not a kernel problem and is user error on
my part.  I noticed with problem with 2.4.23-1um with the RTC/high mhz
bug, however I disabled RTC in the kernel configs and still had this
problem, not to mention the older kernels did not have this problem.
 
Has anyone had this problem and can offer a tip on what I am possibly
doing wrong? Host is 2.4.24.

Thanks,
Matt



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
