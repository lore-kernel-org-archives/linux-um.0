Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYu7T-00088P-7x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:35:43 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CYu7S-0001AJ-2b for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:35:42 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Auto-updating Jeff Dike tree
References: <200410081635.i98GZgr02277@trolli.pdb.fsc.net>
	<200410132008.59231.blaisorblade_spam@yahoo.it>
	<41AB9E02.9050400@tuxrocks.com>
In-Reply-To: <41AB9E02.9050400@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411292338.45801.blaisorblade_spam@yahoo.it>
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
Date: Mon, 29 Nov 2004 23:38:45 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Frank Sorenson <frank@tuxrocks.com>, bodo.stroesser@fujitsu-siemens.com

On Monday 29 November 2004 23:09, Frank Sorenson wrote:
> BlaisorBlade wrote:
> > I use the attached script (questionable as much as you want, i.e. it kind
> > of works here, no guarantee, not even "I think it works") to download the
> > patches. It parses the patches.html in a very rough Way. I mean
> > "DownloadAllPatches".
> >
> > Also, the generated series file must be edited: it appends the new patch
> > list, so if you use it as-is it has duplicate patches and won't work.
>
> BlaisorBlade,
>
> I've modified your DownloadAllPatches script a bit, and thought you
> might want the changes as well.  This version doesn't require editing
> for whatever versions are on the page (now auto-detects), rewrites the
> series file, and is quieter.

Thanks a lot for this... 

A note: appending rather than rewriting was done for the need of saving the 
old content of series. It was not reliable at all, however, and maybe it 
would be better to just copy somewhere else the old content, so it's probably 
better as you did.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
