Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnZo-0005I6-MA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:54:00 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DDnZn-0005SC-QI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:54:00 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.4 do_mmap_pgoff compile problem
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
	<cbec11ac05032020433867d95e@mail.gmail.com>
	<423E5806.2070501@rimuhosting.com>
In-Reply-To: <423E5806.2070501@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221850.10647.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 18:50:10 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Peter <peter.spamcatcher@rimuhosting.com>

On Monday 21 March 2005 06:13, Peter wrote:
> linux-2.4.27.tar.bz2 + uml-2.4.27-bs2-pre6.patch.bz2 patches with no
> error.

> But I get the error below compile.  It seems like the UML code 
> is passing in a mm as the first arg and the only definitions of
> `do_mmap_pgoff' I can find start with a file arg and have no mm.  I
> dropped the mm arg in the code, and it then compiles OK.  But segfaults
> immediately on use.  I'm not sure if that is caused by my code change or
> not.
No, your code change is correct... in fact is what I have in my local tree. 
The only problem I recall is with GCC 3.3.2 from Mandrake 10.0, which 
miscompiles any UML/2.4 (but not UML/2.6). I've never found out why.

> BTW: what is the current recommendation for a 'stable' 2.4 UML guest
> kernel?
Hmm, I *have* to release the -bs2 sooner or later... the hostfs support is 
surely better in -bs1, for the rest 2.4.27-um1 is slightly better
> Regards, Peter
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
