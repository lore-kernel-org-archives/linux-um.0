Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrOPs-0003DY-04 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 14:35:08 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CrOPn-0006u7-9n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 14:35:07 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20f75b0f.bf845356.819dd00@mail-msgstore01.qut.edu.au>
In-Reply-To: <20f75b0f.bf845356.819dd00@mail-msgstore01.qut.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501192347.07906.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] problems with hostfs and large directories
	- start of diagnosys
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
Date: Wed, 19 Jan 2005 23:47:07 +0100
To: Mark Huth <mc.huth@qut.edu.au>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sunday 16 January 2005 11:57, Mark Huth wrote:
> >> Hi,
> >>
> >> I am encountering a problem when I access the host filesystem
> >> via hostfs and the directory has a lot of entries.  For
> >> example when I type in 'ls /mnt/host/usr/lib' uml just freezes
> >> and I have to ctrl-c to get back the prompt.  An strace shows
> >> the following repeating indefinately:
> >>
> >> getdents64(3, /* 170 entries */, 4096)  = 4080
> >>
> >> I am using FC3 and kernel 2.6.10 on both the host and uml
> >> (with the latest skas patch applied to the host).  I have
> >> disabled NPTL.  Has anyone else experienced this problem?
> >
> >I remember someone else talking about it (search "mp3" in the
>
> ML archive
>
> >message bodies), but we never got to actually debugging it,

> and I've never

> >been able to reproduce it...
> >
> >Thanks for this info, however I'll maybe ask you more info...
>
> for instance
>
> >your host setup / distro / glibc (the problem may be related
>
> to a glibc
>
> >bug)...

> Well after trying my hand at kernel debugging, I managed to
> narrow down where the problem is but I'm afraid I can't offer
> a suitable solution.  In the read_dir() function in
> hostfs_user.c the line: *pos = telldir(dir) was always
> returning 0 if the directory had a lot of entries. 
Hmm, what's up with seekdir()? Can you watch errno during the whole function 
(and use the perror program to decode the values) to see where the problem 
starts?
> So in my 
> case if telldir returned 0 I just gave *pos a nudge and
> everyone (including me) was happy.
What do you mean by "a nudge"? *pos++?
> Not the proper solution 
> but good enough for me for the time being.
Well, at least this sheds *some* light... not still clear what's happening, 
but something more to work on... And if you can tell us more, we'll be very 
glad to accept your help and grateful.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
