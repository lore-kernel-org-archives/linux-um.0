Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlqMz-0007r7-NM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jan 2004 06:08:41 -0800
Received: from shell.blacknet.de ([80.254.131.106])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AlqMz-0004Hq-CP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jan 2004 06:08:41 -0800
From: Goetz Bock <bock@blacknet.de>
Subject: Re: [uml-devel] O_DIRECT (was: Swapping directly to host swap area?)
Message-ID: <20040128140122.GM17709@shell.blacknet.de>
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow>
	<200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
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
Date: Wed, 28 Jan 2004 15:01:22 +0100
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>


On Tue, Jan 27 '04 at 23:39, Jeff Dike wrote:
> > In the current setup, the host kernel sees this as a normal
> > write to an open file, caching it in the process and so not truly
> > freeing up the ram for a bit. 
> 
> This is, and this could be done by setting O_DIRECT on UML swap
> devices.  That way, writes go directly (and asynchronously) to the
> device without landing in the cache.
Please bare with me, if this seams a stupid qestion, but my C skills are
pritty lacking :-(

But could we get this as an option for all ubd devices?

(I'm using Logical Volumes as base for ubd devices, and have no swap on
 my hosts)
-- 
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /                     (c) 2003 as GNU FDL 1.1
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
