Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dkqzp-0002Mx-Lm	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 15:13:29 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1Dkqzn-0006rZ-UK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 15:13:29 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1Dkqzk-00042I-On
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 15:13:27 -0700
From: Paul Warren <pdw@ex-parrot.com>
Subject: Re: [uml-devel] Entropy on boot
Message-ID: <20050621231322.A10809@sphinx.mythic-beasts.com>
References: <20050620202549.A6907@sphinx.mythic-beasts.com>
	<20050620211638.GB10675@ccure.user-mode-linux.org>
	<20050621195047.B14716@sphinx.mythic-beasts.com>
	<20050621210236.GA30220@ccure.user-mode-linux.org>
	<KtYwDh/N3TrS.sWA8tvTfm+hGkj7X7pkSEw@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KtYwDh/N3TrS.sWA8tvTfm+hGkj7X7pkSEw@sphinx.mythic-beasts.com>;
	from chris@ex-parrot.com on Tue, Jun 21, 2005 at 10:19:08PM +0100
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
Date: Tue, 21 Jun 2005 23:13:22 +0100
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jun 21, 2005 at 10:19:08PM +0100, Chris Lightfoot wrote:
> On Tue, Jun 21, 2005 at 05:02:36PM -0400, Jeff Dike wrote:
> > That would never make it anywhere near mainline, so you would have a
> > choice of dumping that into every UML pool you build or fixing your
> > filesystems to use the rngtools.
> 
> Yeah -- it comes down to how often you build new
> distributions vs how often you build new kernels. Oh, and
> whether you anticipate tech support load from people who
> disable the hwrng userland tools and then discover that
> their virtual machine hangs on boot.

Quite - supporting kernel patches is much easier than O/S changes.  This
is why we now enforce cad = halt by disabling reboot functionality in
the kernel, rather than maintaining a change to /etc/inittab.

I admit that a proper pass-through drive for /dev/random might be a
nicer solution, but for us, hwrng is not.

Paul



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
