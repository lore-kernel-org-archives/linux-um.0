Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfNu9-0001Ch-QG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Nov 2005 12:41:17 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EfNu3-0005uM-Sg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Nov 2005 12:41:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
In-Reply-To: <200511240611.02613.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242140.27019.blaisorblade@yahoo.it>
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
Date: Thu, 24 Nov 2005 21:40:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Thursday 24 November 2005 13:11, Rob Landley wrote:
> So apparently, one reason for the pathological behavior of UML (pegging the
> hard drive, which I mentioned earlier) is that by default Ubuntu doesn't
> mount /tmpfs on /tmp.  This means it's part of /root, which is ext3, and
> every touched page gets scheduled for writeout after a few seconds.  (The
> optimization not to do that for deleted files was apparently taken out of
> 2.6.)

> There is a tmpfs mount, it's /dev/shm.

> And apparently, even if tmpfs isn't 
> exposed as a separate filesystem, system V shared memory will still use it.

Ah,ok... more or less it's true.

> So my question is, could system v shared memory be used in place of the
> tmpfs mount?  (Can it be mapped in the right location and inherited across
> fork()?)
IIRC you can share a SysV shmem area across arbitrary processes - anybody 
calls ftok on a file, gets its handle and can open the shmem area.

I mostly wonder about automatic cleanup.

One (mis) feature of SysV IPC is persistance till reboot (i.e. no auto-cleanup 
if the process exits).

In fact, we make processes sleep on pipes rather than use SysV semaphore 
exactly for this reason (I wanted to use futexes, but never found the time).

However, I just found out, see shmctl(2), that IPC_RMID implements the 
refcount "garbage collection" algorithm, so apparently it *could* be used.

The question is if we want it, and considering the new features being added to 
shmfs, the answer is probably either "no" or "we accept patches if somebody 
else is willing to maintain them" (adding yet another code path doesn't make 
me that happy - see the effort needed to make TT and SKAS3, and now SKAS0 and 
SKAS3, keep working).

> Or is this just a "systems that don't mount /tmpfs on /tmp are 
> screwed, it's another prerequisite for running UML".
First, UML works anyway.

Set properly one of TMPDIR / TMP / TEMP (don't remember exact priorities, but 
IIRC TMPDIR has most priority) to point to /dev/shm. Actually, we could even 
make it the default (but must cater for older systems).

It's used for POSIX shmem, so it's as standard on >=2.4 Linuxes as SysV shmem.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
