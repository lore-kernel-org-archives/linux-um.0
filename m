Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBwpp-00083O-B2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 07:18:21 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBwpo-0001nK-Mp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 07:18:20 -0700
Message-Id: <200404091456.i39EuKsf001797@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Simple db with separable io layer for humfs metadata.
In-Reply-To: Your message of "Fri, 09 Apr 2004 11:37:16 +0200."
	<200404091137.16728.sikkh@wp.pl> 
References: <200404091137.16728.sikkh@wp.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 09 Apr 2004 10:56:20 -0400
To: Piotr Neuman <sikkh@wp.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net

sikkh@wp.pl said:
> TDB: http://sourceforge.net/projects/tdb/ (it's used in samba project)
> 
> Need only reimplement 2 pretty simple functions:
> static int tdb_write(TDB_CONTEXT *tdb, tdb_off off, void *buf, tdb_len len)
> static int tdb_read(TDB_CONTEXT *tdb,tdb_off off,void *buf,tdb_len len,int cv)

> QDBM: http://qdbm.sourceforge.net/
> 
> In this case need to reimplement 4 functions (also simple):
> static int dpwrite(int fd, const void *buf, int size);
> static int dpseekwrite(int fd, int off, const void *buf, int size);
> static int dpread(int fd, void *buf, int size);
> static int dpseekread(int fd, int off, void *buf, int size);

That's exactly the sort of thing I was looking for.

The reason I want to do IO on behalf of any DB that gets linked into UML is
that I have a long-term goal of UML never blocking for any reason, except in
its own idle loop.  This mostly includes waiting for disk IO, i.e. for normal
IO, swapping or faulting in pages, populating mmap areas, etc.  So, I especially
want no blocking IO.  I want UML to be able to schedule other things while
it's waiting for IO.

So, when it comes to databases, I want to be able to do AIO on their behalf,
do other things while the IO is happening, and let them know when it has 
finished.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
