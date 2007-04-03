Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYn2x-0006nK-FV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 10:43:59 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HYn2u-0005kF-Ca
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 10:43:55 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 3 Apr 2007 19:43:14 +0200
References: <1712880100@web.de> <20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
In-Reply-To: <4610D937.20002@nagafix.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704031943.15001.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC] UML kernel & rootfs bundle with every kernel
	release ?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, devzero@web.de, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On luned=EC 2 aprile 2007, Antoine Martin wrote:
> Jeff Dike wrote:
> > On Sun, Apr 01, 2007 at 08:58:45PM +0100, Antoine Martin wrote:
> >> I reckon that one critical thing which could drastically increase the
> >> user base would be to have a working virtual framebuffer implementatio=
n.
> >
> > Why?  I've never understood what a framebuffer gives you that you
> > don't have now.
>
> Just like the network auto-configuration via dhcp,
Hmm... for that to be completely plug-and-play you need to make sure a dhcp=
=20
server on the host exists.

Vmware runs a separate DHCP server exactly for this, even if we should avoi=
d=20
that as much as possible.

> it would allow users=20
> to download images+kernel and run them like appliances without
> understanding anything about X or UML, just click and run.

> We are all capable of setting up Xvfb here, but most users are not,
> which is why they download ready-made images.

What about installing and pre-configuring Xnest on the image? With a suitab=
le=20
script calling xhost on the host, it just works.

This project did it:
http://umlbuilder.sourceforge.net/

although it stopped working for me ages ago (probably for some UML bug). I =

built a Mandrake image (that I now lost) with Xnest configured. With a scri=
pt=20
on the host which passes the host IP and that calls xhost, it should work=20
easily. And btw, we need a standard startup script anyway.

> It would also make it a lot easier to focus on writing a management UI,
> hell if there isn't one shortly after, I'll do one myself!

Why not one management UI running from the host, a-la vmware? Possibly, wit=
h=20
as much code as possible in scripting languages, for better transparency.

> Think of a UML browser image (running IE via wine in a limited image
> with just X + wine + IE - I would much prefer that to having wine+IE
> installed locally), testing framebuffer apps like gtk-fb/cairo-fb
> without risking your dev environment, etc...
>
> Antoine



--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

