Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJopA-0004vL-SO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 01:26:44 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJop9-0002V6-61
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 01:26:44 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504080146.19437.rob@landley.net>
	<200504080859.33807.blaisorblade@yahoo.it>
In-Reply-To: <200504080859.33807.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504080323.58472.rob@landley.net>
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
Date: Fri, 8 Apr 2005 03:23:58 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

On Friday 08 April 2005 02:59 am, Blaisorblade wrote:
> > P.S.  I terms of mentioning my obligatory "really disgusting solution to
> > an otherwise seemingly impossible problem", I'd like to point to the
> > existence of "/proc/self/fd/0".
>
> I was thinking to it too... but it wouldn't work... ouch, it would! Ok, sed
> is not reading from stdin but from a file...
>
> > But in comparison, the temp file doesn't really look all that bad... :)
>
> Hmm, instead I prefer this rather than the tmp file. However it's not that
> important, after all.

Does the linux kernel build require /proc to be mounted?  It's a bit on the 
brittle side for me to be happy with.  The temp file is ugly, but robust...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
