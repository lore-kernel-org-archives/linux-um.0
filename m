Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9pIC-000725-V2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 10:55:24 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9pIB-0002rv-9q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 10:55:24 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
	<200503101341.37346.rob@landley.net>
In-Reply-To: <200503101341.37346.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111954.33414.blaisorblade@yahoo.it>
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
Date: Fri, 11 Mar 2005 19:54:33 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org

On Thursday 10 March 2005 19:41, Rob Landley wrote:
> On Wednesday 09 March 2005 09:15 pm, Jeff Dike wrote:
> > This implements a hardware random number generator for UML which attaches
> > itself to the host's /dev/random.
>
> Direct use of /dev/random always makes me nervous.  I've had a recurring
> problem with /dev/random blocking,
The fd is set in non-blocking mode on opening, so when there is no data UML 
will not block but get -EAGAIN (which is then handled by waiting and 
retrying).
> and generally configure as much as 
> possible to use /dev/urandom instead.  It's really easy for a normal user
> to drain the /dev/random entropy pool on a server (at least one that
> doesn't have a sound card you can tell it to read white noise from).

> cat  /dev/random > /dev/null

> I like /dev/urandom because it'll feed you as much entropy as it's got,
Yes, and entropy will gradually degrade...
> but 
> won't block, and will presumably round-robin insert real entropy in the
> streams that multiple users get from /dev/urandom.  (I realize this may not
> be the best place to get gpg keys from.)

> Admittedly if UML used /dev/urandom instead of /dev/random, it wouldn't
> know how much "real" randomness it was getting and how much synthetic
> randomness, but this makes predicting the numbers it's producing easier

> how?
Don't ask us..., we just recycle the others knowledge... however in short when 
you say that "randomness" (or entropy) is not the maximum, you mean that 
there is some redundancy, i.e. some law to ease predicting subsequent 
numbers. For instance some character is more frequent than another... And 
this is also the same kind of things that is exploited during compression... 
the more compressed are your data, the less entropy they have before 
compression (I'm not an expert of Shannon information entropy theories, 
however, but this is what I grasped).
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
