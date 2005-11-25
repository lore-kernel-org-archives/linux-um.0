Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efk2I-0003Vn-3H for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 12:19:10 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Efk2H-0003xT-Gi
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 12:19:10 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251003.42328.rob@landley.net>
	<87k6ewikte.fsf@amaterasu.srvr.nix>
In-Reply-To: <87k6ewikte.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251418.43866.rob@landley.net>
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
Date: Fri, 25 Nov 2005 14:18:43 -0600
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Friday 25 November 2005 13:33, Nix wrote:
> On Fri, 25 Nov 2005, Rob Landley uttered the following:
> > A) mlock would be a bad thing.  Not only is it a trivial DOS waiting to
> > happen but I like the UML physmem being swapped out under memory
> > pressure.  I just don't want uselessly writing it to disk over and over
> > in the absence of any memory pressure whatosever to consume all I/O
> > bandwidth to no purpose, which is the effect when it's not on tmpfs.
>
> Maybe this is a stupid question, but... why do *any* systems other than
> extremely memory-constrained ones not mount tmpfs on /tmp? It seems to
> me to have numerous advantages and no disadvantages.

Actually, I consider the fact the OOM killer doesn't delete files out of tmpfs 
mounts to be a potential disadvantage in this context.

Using /tmp for anything has been kind of discouraged for a while, because 
throwing any insufficiently randomized filename in there is a security hole 
waiting to happen.  By the time tmpfs was widely available as something you 
might mount on /tmp, the use of /tmp had been largely replaced with things 
like the ~/.kde directory or /var/spool/appdir with ownership and permissions 
enforced.

Most of the remaining uses of /tmp are actually for things like named sockets 
(where tmpfs really doesn't help at all), or for tiny little files (like all 
the mcop crap) that on a different day would live under /var.  It's used for 
inter-process communications, not for temporary storage space.  Long ago 
things like vi would create temporary files in /tmp, but these days it uses .
${filename}.swp in the same directory as the file being edited.  (As a matter 
of fact, there's even a /var/tmp that konqueror recently started storing its 
cache in.  It used to be in ~/.kde.  So there isn't just _one_ tmp directory; 
if you try to tmpfs mount your /tmp than you need to do more than one.)

I suspect that the real reason nobody mounts tmpfs on /tmp is that nobody 
_bothers_.  Nobody in their right mind puts anything big under /tmp, the few 
remaining uses are largely IPC between different users on the same machine, 
and even X11 has mostly moved away from that.  Things like postfix and cups 
use subdirectories under /var/spool that aren't world readable.

Keep in mind that tmpfs used to be shmfs, and what it's good at is providing 
shared memory.  What UML really _wants_ is shared memory, which has 
traditionally been available through /dev/shm.  Insisting that /tmp behave 
like /dev/shm because otherwise what you get doesn't behave like shared 
memory A) doesn't make make a whole lot of sense, B) doesn't match existing 
practice.

> In fact, even when you're memory-constrained, if you *have* diskspace that
> you could spend on /tmp, you can swap to it instead, and spend the space
> on virtual memory when you're not spending it on /tmp.

"can" doesn't mean "should".  Yes you can make a 10 gigabyte swap partition, 
but most people actively don't want one because if your system ever winds up 
using more than about twice as much swap space as it has physical memory, 
it's likely that the amount of swap thrashing you're doing is getting 
pathological.  Having a runaway app have to churn through 10 gigabytes of 
swap space before the OOM killer terminates it can turn 30 seconds of 
paralysis into 10 minutes.  Not an improvement.

Also, although it's pretty common to have 10 gigabytes of spare disk space on 
a modern laptop, it is _not_ common to have 10 gigabytes of spare swap space, 
and that's for a reason.  Extra space in your filesystem can be used for all 
sorts of things.  Extra swap space is normally wasted.

So having tmp just be a normal directory isn't really that bad of a choice.  
It normally manifests no downsides whatsoever.  And encouraging people to 
use /tmp is considered a security hole.

> So, er, why?

/dev/shm appears to be is the widely available tmpfs mount, because its 
purpose is to provide shared memory.  It is not and never has been the 
purpose of /tmp to provide shared memory.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
