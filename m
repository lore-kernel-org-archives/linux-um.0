Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtVTo-0004BM-Sw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 10:31:56 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CtVTo-0006Kr-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 10:31:56 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501250516.39648.rob@landley.net>
	<200501251240.35872.blaisorblade@yahoo.it>
In-Reply-To: <200501251240.35872.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501251230.04080.rob@landley.net>
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
Date: Tue, 25 Jan 2005 12:30:03 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 January 2005 06:40 am, Blaisorblade wrote:

> > Host is swapping, client configured without even support for swap.  (If I
> > can get the darn client vmlinux down to 1 megabyte, I'd be thrilled.
> > Didn't somebody once make the entire block layer configurable out once?
> > With hostfs, I don't need it...)
>
> Do you trust hostfs so much? You don't need user IDs on your FS, I guess.

Once I get /dev on ramfs managed by udev?  Not really, no.  I need the 
permissions to be right, but just about everything else should belong to 
root.  (Yeah, there are a couple fun tricks where files change their 
ownership to some variant of "nobody" to do chroot jails and stuff, but they 
do that at runtime...) 

I've probably missed one or two instances, but I expect I can work around 
'em...

> I'm not at all happy with this, but I don't want someone using hostfs over
> its possibilities. NFS is much better, anyway.

NFS gives me hives (a stateless fileserver: okay, spot the contradiction in 
terms here), although I must admit I haven't tried the new TCP/IP based 
version (V4?) yet because it wasn't finished last time I tried.

> And somebody says it's also 
> faster (and since hostfs does limited caching, it makes sense - hostfs must
> avoid having any inode cache, since it closes the host fd only when the
> inode is evicted from the cache; I don't think it's possible to cache data
> without an inode to link to, so it's clear it's slow).

Since the host is cacheing the data for us, not having a redundant cache 
sounds like a good idea to me.  Admittedly, it's more syscalls, but less 
memory consumption...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
