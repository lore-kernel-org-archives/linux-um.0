Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJnMn-0000VH-5o for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:53:21 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DJnMm-00069B-HC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:53:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504080059.44620.rob@landley.net>
	<200504080146.19437.rob@landley.net>
In-Reply-To: <200504080146.19437.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504080859.33807.blaisorblade@yahoo.it>
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
Date: Fri, 8 Apr 2005 08:59:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Ian McDonald <imcdnzl@gmail.com>

On Friday 08 April 2005 07:46, Rob Landley wrote:
> On Friday 08 April 2005 12:59 am, Rob Landley wrote:
> > If you can get the sed "r" command to read from a pipe, by my guest.  (I
> > mentioned originally that there was probably a cleaner way to do it, but
> > I wasn't seeing it at the time...)
>
> P.S.  I terms of mentioning my obligatory "really disgusting solution to an
> otherwise seemingly impossible problem", I'd like to point to the existence
> of "/proc/self/fd/0".
I was thinking to it too... but it wouldn't work... ouch, it would! Ok, sed is 
not reading from stdin but from a file...
> But in comparison, the temp file doesn't really look all that bad... :)
Hmm, instead I prefer this rather than the tmp file. However it's not that 
important, after all.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
