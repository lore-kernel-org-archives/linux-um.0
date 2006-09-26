Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GS9FX-0007U7-QX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 02:29:11 -0700
Received: from wohnheim.fh-wedel.de ([213.39.233.138])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GS9FW-0001dI-9b
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Sep 2006 02:29:11 -0700
Date: Tue, 26 Sep 2006 11:28:41 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Message-ID: <20060926092841.GA14085@wohnheim.fh-wedel.de>
References: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
	<20060925185852.GR6412@waste.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060925185852.GR6412@waste.org>
Subject: Re: [uml-devel] [PATCH 6/8] UML - Add checkstack support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, 25 September 2006 13:58:52 -0500, Matt Mackall wrote:
> On Mon, Sep 25, 2006 at 02:34:41PM -0400, Jeff Dike wrote:
> > Make checkstack work for UML.  We need to pass the underlying architect=
ure
> > name, rather than "um" to checkstack.pl.
> >=20
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
>=20
> Acked-by: Matt Mackall <mpm@selenic.com>
Acked-by: Joern Engel <joern@wohnheim.fh-wedel.de>

J=F6rn

--=20
Homo Sapiens is a goal, not a description.
-- unknown

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
