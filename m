Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C0atS-0007Kw-9N for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Aug 2004 00:11:26 -0700
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C0atQ-0001sK-Nx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Aug 2004 00:11:26 -0700
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] uml-patch-2.6.7-2
Message-ID: <20040827041056.A3753@almesberger.net>
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>;
	from jdike@addtoit.com on Wed, Aug 18, 2004 at 11:00:59PM -0400
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
Date: Fri, 27 Aug 2004 04:10:56 -0300
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> hostfs and humfs are still somewhat dodgy on 2.6.

Opening files for writing even if we only want to read them causes
a number of problems: first, if I fire up a UML system that shares
root with the host, and I'm root, it will fail to load things like
bash, because it can't open it for writing. This trivial patch
works around that:

--- linux-2.6.7/fs/hostfs/host_fs.c.orig	Fri Aug 27 03:55:48 2004
+++ linux-2.6.7/fs/hostfs/host_fs.c	Fri Aug 27 03:56:17 2004
@@ -175,7 +175,7 @@
 	if(err == -EISDIR)
 		goto out;
 
-	if(err == -EACCES)
+	if(err == -EACCES || err == -ETXTBSY)
 		err = host_open_file(path, 1, 0, &hf->fh);
 
 	if(err)
 
Unfortunately, the problem also happens in the opposite direction.
E.g. if the UML kernel has opened an executable for writing, that
executable is no longer executable on the host. Open file caching
makes this even worse. In fact, it may be a bad idea to cache a
file open for writing at all, if an execute bit gets set, or if it
is already set.

A possible, but IMHO not very nice, work-around would be to run as
a user who isn't allowed to write to anything the host might want
to execute.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
