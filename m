Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiGWS-0000TZ-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 09:15:40 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AiGWS-00046r-B4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 09:15:40 -0800
Subject: Re: [uml-devel] uml-patch-2.6.1-1: VFS: Cannot open root device
	"ubd0" or unknown-block(0, 0)
Message-ID: <20040118.090450.-9063.1.mcmechanjw@juno.com>
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
Date: Sun, 18 Jan 2004 09:04:47 -0800
To: mingo@elte.hu, user-mode-linux-devel@lists.sourceforge.net

Did you notice your line
> /dev/ubd/disc0: unknown partition table
you did not include the command line
I guess from the report about
> VFS: Cannot open root device "ubd0" or unknown-block(0,0)
so you may have "root=ubd0" but with 2.6 and the new root 
naming method see init/do_mounts.c:try_name() you would
appear to need for devfs "root=/dev/ubd/disc0/disc" or 
"root=/dev/ubd/disc0" or "root=6200" it looks like you
might have devfs turned on but it is not set in your config?
I may be out of date however, I still need to build 2.6.1-1um

Enjoy,

James McMechan

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
