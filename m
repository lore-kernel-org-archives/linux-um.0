Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfYuQ-00011g-0m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 00:26:18 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfYuP-00010M-If
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 00:26:18 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511242140.27019.blaisorblade@yahoo.it>
In-Reply-To: <200511242140.27019.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511250226.05842.rob@landley.net>
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
Date: Fri, 25 Nov 2005 02:26:05 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 24 November 2005 14:40, Blaisorblade wrote:
> However, I just found out, see shmctl(2), that IPC_RMID implements the
> refcount "garbage collection" algorithm, so apparently it *could* be used.
>
> The question is if we want it, and considering the new features being added
> to shmfs, the answer is probably either "no" or "we accept patches if
> somebody else is willing to maintain them" (adding yet another code path
> doesn't make me that happy - see the effort needed to make TT and SKAS3,
> and now SKAS0 and SKAS3, keep working).

Hmmm...  (Eyes to-do list...)

> > Or is this just a "systems that don't mount /tmpfs on /tmp are
> > screwed, it's another prerequisite for running UML".
>
> First, UML works anyway.
>
> Set properly one of TMPDIR / TMP / TEMP (don't remember exact priorities,
> but IIRC TMPDIR has most priority) to point to /dev/shm. Actually, we could
> even make it the default (but must cater for older systems).
>
> It's used for POSIX shmem, so it's as standard on >=2.4 Linuxes as SysV
> shmem.

Expecting /dev/shm to be tmpfs seems more reliable than expecting /tmp to be.  
(After all, its' original name was shmfs...)

I just added
  [ -d /dev/shm ] && export TMPDIR=/dev/shm
to my build script, and it seems to help.

Thanks,

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
