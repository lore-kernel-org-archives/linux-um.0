Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiuTp-0002Yo-8D for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:55:37 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AiuTo-00062l-VM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:55:36 -0800
Subject: Re: [uml-devel] more on COW (long)
Message-ID: <20040120.034639.-421335.5.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
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
Date: Tue, 20 Jan 2004 03:44:36 -0800
To: mdz@debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net

> Why do you need loop devices?  Doing COW in the UML kernel can deal
with ubd
> block devices instead. This means chewing up two ubd devices for each
COW
> device, though, and I think is the opposite direction of where Jeff
wants to
> go.

To mount the COWed file systems on the host using a LVM plugin
Yes inside the UML it uses up ubd devices instead of loop devices
currently only 8 are configurable, 16 possible with editing :(
but once the ubd driver is cleaned up it should be possible to
eventually have more ubd devices, my earlier patch was tested
with 400 ubd devices mounted at once, but by that point the
problems have already been solved.

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
