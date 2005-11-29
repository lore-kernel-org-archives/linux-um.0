Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhBKB-0007QQ-W7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 11:39:36 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EhBK5-0007j9-EL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 11:39:32 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511271907.45529.rob@landley.net>
	<200511291708.04068.blaisorblade@yahoo.it>
In-Reply-To: <200511291708.04068.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291338.54361.rob@landley.net>
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
Date: Tue, 29 Nov 2005 13:38:54 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Tuesday 29 November 2005 10:08, Blaisorblade wrote:
> On Monday 28 November 2005 02:07, Rob Landley wrote:
> > On Sunday 27 November 2005 12:31, Nix wrote:
> >
> > Did you catch Linus's long rant about how MAP_PRIVATE is deeply stupid
> > and that Linux will never really implement it?
>
> What's that?

Looking it up, it turns out it was MAP_COPY he was against:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.0/0826.html

So I was wrong there.

> > And you can fsync and do stuff like journaling within a file.  (Except
> > with mmap it's msync.)
> >
> > No, just use the madvise(NO_SYNC).
>
> Which doesn't exist.

Takes some of the fun out of it, yes.  But as a recommendation in response to 
a similar "change everything" proposal, it seems like a more sane direction 
to me.

> > Then tmpfs becomes completely
> > irrelevant because any arbitrary file backed mapping can be treated as
> > memory.  (Not pinned, but still treated as shared memory.)
> >
> > I vaguely remember some discussion about this on linux-kernel, some time
> > ago. I wonder how it came out?  (2.6.15-rc2 mman.h doesn't show
> > anything...)
>
> What I remember is MADV_TRUNCATE / MADV_FREE / and so on by Badary
> Pulavarty - the equivalent of MADV_DONTNEED with additional truncation of
> the tmpfs pages you have mmaped.
>
> Which is used for UML memory hotunplug patch from Jeff's. IIRC it's in -mm,
> but won't be in 2.6.15 at this point.

This is a vague recollection from 3-5 years ago. :)

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
