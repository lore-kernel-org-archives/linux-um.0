Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AilJG-0002JE-Ca for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 18:08:06 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AilJG-0006eo-2H for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 18:08:06 -0800
Received: from mizar.alcor.net ([68.64.159.24]) by mta11.adelphia.net
	(InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with ESMTP
	id <20040120020757.ECQJ11898.mta11.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Jan 2004 21:07:57 -0500
Received: from mdz by mizar.alcor.net with local (Exim 4.30)
	id 1AilJ5-0000Pq-F9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 18:07:55 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Re: more on COW (long)
Message-ID: <20040120020755.GF16181@alcor.net>
References: <20040119.155346.-522689.0.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119.155346.-522689.0.mcmechanjw@juno.com>
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
Date: Mon, 19 Jan 2004 18:07:55 -0800
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jan 19, 2004 at 03:53:43PM -0800, James W McMechan wrote:

> The setup in that case would be to use losetup to make devices using
> one for each COW and backing file so you can only have 1/2 of the
> available loops used for COW files and the other 1/2 as the backing
> files i.e. 4 COW files with 4 backing files from 8 loop back devices
> the usual default, as of Feb 2002 you can now have up to 256 loop
> devices. But I think that a hard limit of 128 COW files per system is
> too small, and if the max_loop is left at the default of 8... 4 COW files
> per system would be a great pain, (yes, if they all use the exact same
> backing file you could get 255 or 7)

Why do you need loop devices?  Doing COW in the UML kernel can deal with ubd
block devices instead. This means chewing up two ubd devices for each COW
device, though, and I think is the opposite direction of where Jeff wants to
go.

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
