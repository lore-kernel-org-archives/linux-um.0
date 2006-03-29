Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOQjU-0007tx-RX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 18:48:28 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FOQjT-0005QI-5E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 18:48:29 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060320210659.GB6474@ccure.user-mode-linux.org>
	<200603290040.01268.blaisorblade@yahoo.it>
	<20060329004144.GB24121@ccure.user-mode-linux.org>
In-Reply-To: <20060329004144.GB24121@ccure.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200603290447.36238.blaisorblade@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IVfKE0x8GFdKZSH"
Subject: [uml-devel] Re: SMP skas requirements
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
Date: Wed, 29 Mar 2006 04:47:35 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_IVfKE0x8GFdKZSH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm CC:ing this to uml-devel, finally.

On Wednesday 29 March 2006 02:41, Jeff Dike wrote:

> On Wed, Mar 29, 2006 at 12:40:00AM +0200, Blaisorblade wrote:
> > Since you've now split out delete-hostfs, why don't you merge the new
> > hostfs, possibly labeling it as "EXPERIMENTAL"?

> My two main gripes right now are
> =A0=A0=A0=A0=A0=A0=A0=A0there are three filesystems (or one framework and=
 two
> filesystems) in one directory

That's not a big problem, but is one which we'll solve after having users.

> =A0=A0=A0=A0=A0=A0=A0=A0it depends on filehandle, which has aspects that =
neither of us likes

We're working on this too slowly.

Give me bugreports by users and filehandle in mainline and I'll probably fi=
x=20
it. Right now, I want to do but I'm worried about other stuff (I should go=
=20
now back working on remap_file_pages). Probably I'll be able to work on bot=
h,=20
since I can't work on that more than a certain amount of time.

> > With the refcount, likely you don't need to move it off-list, but that
> > could maybe be useful to avoid looping on unused fd; however, this
> > requires taking the spinlock when reinserting the element on the list.

> I think you're agreeing with me, but I'm missing why we want to move
> things on and off the list.

I just said "we could do that so when do do reclaim we don't iterate on fds=
=20
which are held somewhere", but IMHO the other side has better reasons to be=
=20
preferred (i.e. possibly skipping taking the lock when reputting it on list=
).

> > Note: testing that a fd has refcount 0 must be done atomically with
> > freeing it; i.e. even with an atomic_t refcount, it must be incremented
> > only while you have a lock on the list;=20

> > and while freeing it,=20

I'd have to say "while closing it". But we don't close fd's when they reach=
=20
refcount 0, so in that case we can probably avoid taking the lock.

Instead, when closing an fd, we must still take the lock, move it off-list,=
=20
drop the lock and close the fd.

> > you must=20
> > use
> > atomic_dec_and_lock() so you get a lock on the list if the refcount goes
> > to 0 (atomic_dec_and_lock() is equivalent to taking the lock, doing dec
> > and test, and releasing it, but is faster).

> Yes, this looks reasonable.

I've been especially careful because after studying Operating Systems=20
(previous semester) I noticed a bug in the description of your ubd_sequence=
=20
patch (against 2.6.14-rc1-mm1, sent as attachment in a mail); I don't recal=
l=20
the details, including names, but I remember the bug. I've described it=20
below, but now I've discovered that it doesn't apply given the nature of th=
e=20
wait_queue's in Linux. I've not had the courage to press Del...

However, while looking at this, I think I've found all sort of race conditi=
ons=20
and locking problems in the ubd driver.

Saving what I see in a patch, I'll look well at this later, but however I=20
think I've seen tons of problems.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
I decided not to describe it at that time because you dropped that=20
implementation, but I'm doing it now below (maybe because I'm silly).

There were two atomic_t (started_req and completed_req) which were seq.=20
counts, and one wait_list - one task would hang onto a wait list until=20
completed_req reached start_req and it was waken up.

Well, there was a bug since there's no semaphore in the design - task A, wh=
ich=20
submits requests, could check that started_req > completed_req (they're=20
atomic but reading the couple of them is not atomic - for it getting=20
started_req < completed_req was perfectly possible), then task B could=20
increment completed_req and send the wakeup to nobody, then task A could go=
=20
to sleep to be never waken up.

***
In Linux, however, wait_event() puts the task on the wait queue, so that it=
=20
can catch wakeups, tests the condition, and calls schedule(); since it's on=
=20
the wait_queue before testing the condition, I assume that wakeups done whi=
le=20
it's still running after testing the condition are caught.
***

Actually, depending on the details, since task A submits all requests and i=
s=20
sleeping, started_req could never increase again, and it would never be=20
awakened; otherwise it would be waken up later if somehow there were other=
=20
started and completed requests causing another wake-up.

You need, indeed, the check on the condition and the sleep to be atomic, i.=
e.=20
to protect them with a semaphore; actually in Linux they use a spinlock whi=
ch=20
they manage to drop, when they are on the queue, have decided to go to slee=
p=20
but haven't yet gone to.
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_IVfKE0x8GFdKZSH
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ubd-sequence"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ubd-sequence"

# It is important that I/O requests be submitted to the host in the
# order that they are received by the driver, especially since the
# driver can sleep.  This patch adds two atomic counters, one for
# requests started and one for requests submitted to the host.  A new
# request can proceed when started (after being incremented) is one
# more than submitted.  submitted is incremented after all pieces of
# the request have been sent to the host.
# When a request is proceeding out of order, it will sleep on a wait
# queue until its number comes up.
#
# Interaction between this wait_queue and the emergency allocation
# semaphore - a request will only try to allocate data when it is
# its turn to go.  The wait_queue is finished before the semaphore is
# acquired, so there can't be a deadlock between one process holding
# the allocation semaphore and sleeping because it's out of order and
# one proceeding in order and sleeping on the allocation semaphore.
#
# This currently doesn't correctly handle the bitmap, which must be
# written after the data has been finished.  These must be sequenced
# in the same way as the data.
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:34.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:53.000000000 -0400
@@ -1297,6 +1297,10 @@
 	return(err);
 }
 
+static atomic_t started = ATOMIC_INIT(0);
+static atomic_t submitted = ATOMIC_INIT(0);
+DECLARE_WAIT_QUEUE_HEAD(sequence_queue);
+
 void do_io(struct io_thread_req *req, struct request *r, unsigned long *bitmap)
 {
         struct ubd_aio *aio;
@@ -1304,14 +1308,18 @@
         char *buf;
         void *bitmap_buf = NULL;
         unsigned long len, sector;
-        int nsectors, start, end, bit, err;
+        int nsectors, start, end, bit, err, want;
         __u64 off;
 
-        if(req->bitmap_start != -1){
-		bitmap_io = alloc_bitmap_io();
+	want = atomic_add_return(1, &started);
+	wait_event(sequence_queue, want - 1 == atomic_read(&submitted));
 
+        if(req->bitmap_start != -1){
                 /* Round up to the nearest word */
                 int round = sizeof(unsigned long);
+
+		bitmap_io = alloc_bitmap_io();
+
                 len = (req->bitmap_end - req->bitmap_start +
                        round * 8 - 1) / (round * 8);
                 len *= round;
@@ -1378,4 +1386,7 @@
 
                 start = end;
         } while(start < nsectors);
+
+	atomic_inc(&submitted);
+	wake_up(&sequence_queue);
 }

--Boundary-00=_IVfKE0x8GFdKZSH--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
