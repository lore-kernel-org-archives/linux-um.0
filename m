Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYnCl-00082X-3K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 10:54:03 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYnCj-0000bk-GK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 10:54:03 -0700
Message-ID: <461294B0.5010303@nagafix.co.uk>
Date: Tue, 03 Apr 2007 18:53:52 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <1712880100@web.de> <20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
	<200704031943.15001.blaisorblade@yahoo.it>
In-Reply-To: <200704031943.15001.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, devzero@web.de, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On luned=EC 2 aprile 2007, Antoine Martin wrote:
>> Jeff Dike wrote:
>>> On Sun, Apr 01, 2007 at 08:58:45PM +0100, Antoine Martin wrote:
>>>> I reckon that one critical thing which could drastically increase the
>>>> user base would be to have a working virtual framebuffer implementatio=
n.
>>> Why?  I've never understood what a framebuffer gives you that you
>>> don't have now.
>> Just like the network auto-configuration via dhcp,
> Hmm... for that to be completely plug-and-play you need to make sure a dh=
cp=20
> server on the host exists.
>=20
> Vmware runs a separate DHCP server exactly for this, even if we should av=
oid=20
> that as much as possible.
It is trivial to write a shell script that takes care of setting up the=20
interface and checks for the presence of a dhcp server. (the dhcpd.conf=20
can be generated easily)

The problem lies with the configuration options, I have got a bunch of=20
shell scripts to take care of that, but it is quite hard to make them=20
suitable for global consumption by the average user:
* even with just tap networking, I use 4 different ways of hooking them=20
up the outside world
* firewalling and mac address filtering
* bridging issues and ebtables
* tmpfs and memory issues
* selinux and chrooting issues...
etc...

[snip]
> although it stopped working for me ages ago (probably for some UML bug). =
I=20
> built a Mandrake image (that I now lost) with Xnest configured. With a sc=
ript=20
> on the host which passes the host IP and that calls xhost, it should work=
=20
> easily. And btw, we need a standard startup script anyway.
It would work, but it's not a pretty solution, it requires=20
customizations to the guest and it would not be intuitive to new users.
I would much prefer the ability to just run any distro (even framebuffer=20
based ones) without modifications using the virtual framebuffer.

>> It would also make it a lot easier to focus on writing a management UI,
>> hell if there isn't one shortly after, I'll do one myself!
>=20
> Why not one management UI running from the host, a-la vmware?
Yes ,that was what I had in mind.
> Possibly, with=20
> as much code as possible in scripting languages, for better transparency.
Definitely, (see above)

The management tools I have written export the guests' settings to the=20
filesystem in the form of a shell script file, all the utility scripts=20
just read those settings and do their stuff. (all in simple shell)
Antoine


>> Think of a UML browser image (running IE via wine in a limited image
>> with just X + wine + IE - I would much prefer that to having wine+IE
>> installed locally), testing framebuffer apps like gtk-fb/cairo-fb
>> without risking your dev environment, etc...
>>
>> Antoine
>=20
>=20
>=20


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

