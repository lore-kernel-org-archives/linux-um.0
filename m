Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALx7q-0001NR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 17 Nov 2003 20:06:02 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALx7q-0005SI-9H
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 17 Nov 2003 20:06:02 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031118040600.GP9377@dijkstra.csh.rit.edu>
References: <E1ALez7-0007q5-Of@frankenstein> <20031117161447.GL9377@dijkstra.csh.rit.edu> <3FB97636.6030107@spaz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB97636.6030107@spaz.org>
Subject: [uml-devel] Re: Bug#220679: user-mode-linux: Fails to Mount Root Filesystem on Reboot
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 17 Nov 2003 23:06:00 -0500
To: Daniel Burton <dan@spaz.org>
Cc: 220679@bugs.debian.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 17, 2003 at 05:30:30PM -0800, Daniel Burton wrote:

> Matt Zimmerman wrote:
> 
> >So you are saying that specifying ubd0= explicitly does _not_, in fact, fix
> >your problem?  Your previous message seems to have said that it did.
> 
> All previous command lines I tried with ubd0=root_fs did allow it to 
> reboot.  For some reason, this command line didn't work.  I have no idea 
> why.

In that case, are you sure no other process was locking the file?

-- 
 - mdz


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
