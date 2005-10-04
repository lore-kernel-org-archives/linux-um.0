Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMjb6-0004QQ-Bu	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:00:32 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMjb6-0006rd-2X
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:00:32 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by wumpus.mythic-beasts.com with esmtp (Exim 4.44)
	id 1EMjaz-0005qZ-1u	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 11:00:25 +0100
Received: from chris by sphinx.mythic-beasts.com with local (Exim 4.51)
	id 1EMjay-0001Su-VE	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 11:00:24 +0100
From: Chris Lightfoot <chris@ex-parrot.com>
Message-ID: <HDubM/jULNDp.FiIUPkbI/sUT/mvVu1/2/A@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Resent-To: user-mode-linux-devel@lists.sourceforge.net
Resent-Message-Id: <E1EMjay-0001Su-VE@sphinx.mythic-beasts.com>
Subject: [uml-devel] ubd and write barriers
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
Date: Tue, 4 Oct 2005 10:31:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net

The current ubd implementation doesn't support write
barriers (blk_queue_ordered etc.), and the reccomendation
is to use synchronous IO to ensure data integrity. In
principle, adding barrier request support ought to get
around this problem, allowing writes without O_SYNC with
occasional calls to fdatasync on the underlying data (the
motivation for write barrier support was safety of
journalling filesystems on disks with write caches, an
analogous problem).

ext3 and reiserfs support the write barrier stuff if
mounted with appropriate options (barrier=1 and
barrier=flush respectively).

Implementing this ought to give performance somewhere
between ubdXs and ubdX, but with adequate guarantees of
data integrity for use with modern filesystems. That said,
I haven't measured this yet.

A patch for this is pretty simple (see below). Has there
been discussion of this before? I couldn't find any in the
list archives....

--- ubd_kern.c.orig     2005-10-04 10:17:50.000000000 +0100
+++ ubd_kern.c  2005-10-04 10:22:59.000000000 +0100
@@ -68,6 +68,7 @@
        unsigned long long cow_offset;
        unsigned long bitmap_words[2];
        int error;
+        int barrier;
 };
 
 extern int open_ubd_file(char *file, struct openflags *openflags,
@@ -825,6 +826,8 @@
                unregister_blkdev(MAJOR_NR, "ubd");
                return -1;
        }
+
+        blk_queue_ordered(ubd_queue, QUEUE_ORDERED_TAG);
 
        if (fake_major != MAJOR_NR) {
                char name[sizeof("ubd_nnn\0")];
@@ -1003,6 +1006,8 @@
        io_req->buffer = req->buffer;
        io_req->sectorsize = 1 << 9;
 
+        io_req->barrier = blk_barrier_rq(req);
+
        if(dev->cow.file != NULL)
                cowify_req(io_req, dev->cow.bitmap, dev->cow.bitmap_offset,
                           dev->cow.bitmap_len);
@@ -1334,6 +1339,8 @@
                start = end;
        } while(start < nsectors);
 
+        if (req->barrier) fdatasync(req->fds[bit]); /* XXX also sync before this write? */
+
        req->error = update_bitmap(req);
 }
 


-- 
``Is there no beginning to your talents?''
  (Clive Anderson, to Jeffrey Archer)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
