Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJdEq-0001JL-NY for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 11:59:56 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BJdEq-0007QR-4C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 11:59:56 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Still can't get an 2.6.6-rcX UML
References: <20040430183116.24011.qmail@praize.com>
In-Reply-To: <20040430183116.24011.qmail@praize.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200404302058.21912.blaisorblade_spam@yahoo.it>
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
Date: Fri, 30 Apr 2004 20:58:21 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:31, venerd=EC 30 aprile 2004, gboutwel ha scritto:
> Blaisorblade wrote:

> > The problem is that:
> >
> > a) I think that file should include the "kernelspace" headers...
> >
> > however the kludges needed to do it are very fragile when Kbuild
>
> changes a
>
> > bit (this problem has repeatedly showed up against Linux 2.6).
>
> Ok.  If it where including kernelspace headers I don't think
> this would be a problem.

Yes, what I mean is that the proper fix is probably to make it use the kern=
el=20
headers as it did before. Would you post the output of the failing make=20
command with the V=3D1 option added, to see the actual build command?

> As I understand it SID installs as it's 'de facto' headers not
> 2.6, but 2.5.999-test7. See:
> http://packages.debian.org/unstable/devel/linux-kernel-headers

> And it would seem that this area (in kernel headers) has recently
> changed (when compared to 2.5) or up to this point UML builds
> have been going against kernel provided headers instead of the
> 2.5 headers debian's shipping.

I think the 2nd thing holds, and that my suggestions is a workaround that=20
should work (I hope)...

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.=20
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
