Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Dynamic remount with variable COW stacking/merging
	needed, support  for snapshot repilication
Message-ID: <20040119035924.GE16181@alcor.net>
References: <20040118.002101.-9063.0.mcmechanjw@juno.com>
	<200401181517.52700.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401181517.52700.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jan 2004 19:59:24 -0800
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sun, Jan 18, 2004 at 05:13:57PM +0100, BlaisorBlade wrote:

> Alle 09:20, domenica 18 gennaio 2004, James W McMechan ha scritto:
> > Oh yes as a side note 2.6.0 and 2.4.25pre
> > have the fix for Oops on the host kernel
> > when reading /dev/shm with hostfs so if
> > that was bothering you the 2.6 or next
> > 2.4 kernel should help.
> 
> Yes, I saw it. Thanks!

Ooh, good.  I stopped using hostfs-on-tmpfs for a number of things due to
this bug, having sent the oops to linux-kernel and having received no
response.  I'm glad it's fixed.

-- 
 - mdz


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
