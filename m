Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXSHe-0008Td-FG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 18:21:34 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HXSHb-0000mB-KD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 18:21:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 31 Mar 2007 03:21:17 +0200
References: <20070330205938.984247529@mini.kroah.org>
	<20070330210412.GH29450@kroah.com>
In-Reply-To: <20070330210412.GH29450@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703310321.18453.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 06/37] UML - Fix static linking
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Justin Forbes <jmforbes@linuxtx.org>, Greg KH <gregkh@suse.de>, JC.LAFOUCRIERE@cea.fr, linux-kernel@vger.kernel.org, Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@linux-foundation.org, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org, alan@lxorguk.ukuu.org.uk

On venerd=EC 30 marzo 2007, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

I have one objection, the fix has a typo! This is the additional fix=20
(note '.note' instead of 'note'):

--- linux-2.6.git.orig/include/asm-um/common.lds.S
+++ linux-2.6.git/include/asm-um/common.lds.S
@@ -15,7 +15,7 @@
   PROVIDE (_unprotected_end =3D .);

   . =3D ALIGN(4096);
-  .note : { *(note.*) }
+  .note : { *(.note.*) }
   __start___ex_table =3D .;
   __ex_table : { *(__ex_table) }
   __stop___ex_table =3D .;

With this, the fix should be merged - I just re-hit this bug and rechecked =

everything, now it's ok.

> ------------------
> From: Jeff Dike <jdike@addtoit.com>
>
> During a static link, ld has started putting a .note section in the
> .uml.setup.init section.  This has the result that the UML setups
> begin with 32 bytes of garbage and UML crashes immediately on boot.
>
> This patch creates a specific .note section for ld to drop this stuff
> into.
>
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> ---
>  include/asm-um/common.lds.S |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/include/asm-um/common.lds.S
> +++ b/include/asm-um/common.lds.S
> @@ -15,6 +15,7 @@
>    PROVIDE (_unprotected_end =3D .);
>
>    . =3D ALIGN(4096);
> +  .note : { *(note.*) }
>    __start___ex_table =3D .;
>    __ex_table : { *(__ex_table) }
>    __stop___ex_table =3D .;



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

