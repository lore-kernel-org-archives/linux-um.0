Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnP8-0004SV-5v for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:42:58 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DDnOn-0002lD-1L for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:42:57 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] uml help __alloc_pages: 0-order
	allocation failed (gfp=0xf0/0)
References: <000d01c52b22$8ab2c020$0201a8c0@lualele>
	<200503172049.39200.blaisorblade@yahoo.it>
	<20050320222507.B15902@sphinx.mythic-beasts.com>
In-Reply-To: <20050320222507.B15902@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221841.55755.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 18:41:55 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Paul Warren <pdw@ex-parrot.com>, Chris Wedgwood <cw@f00f.org>, itamar <itamar@ispbrasil.com.br>

On Sunday 20 March 2005 23:25, Paul Warren wrote:
> [ trimmed cc to just -devel list]
>
> On Thu, Mar 17, 2005 at 08:49:38PM +0100, Blaisorblade wrote:
> > Paul Warren said that there is a leak in 2.4 UML related to hostfs
> > stuff.. and I already saw this message from some 2.4 recent UMLs. I hope
> > Paul Warren can explain what he saw and help us...
> >
> > In case we have confirmation it's hostfs-related, we only need to go back
> > to the stable 2.4.24-1um hostfs code (i.e. pre-humfs), as I already do in
> > the 2.4-bs tree.
>
> OK, our setup is that we have a load of distribution mirrors that are
> NFS mounted onto the host server.  The guests then mount these using
> hostfs.  We first noticed that a nightly updatedb was causing the amount
> of memory that could be malloced to decrease.  We found that doing a
> "find" across the entire hostfs mount also did the trick.
>
> I've attached the script and program that we used to meause the maximum
> amount of memory that can be malloced.  We then ran:
>
>  while : ; do ./maxalloc ; updatedb ; done
>
> ... and watched the memory leak away.

> Please let me know if you want some more info.
In priority order:
1) Try it on 2.6 and/or 2.4.27-bs (either bs1 or bs2-pre6, whichever you 
prefer and gives you less problems).
2) Try finding the item in /proc/meminfo (and if it's from Slab, 
inside /proc/slabinfo) which is increasing in the memory leak...
> Paul

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
