Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX46w-0006mv-HB
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 11:47:02 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AX46v-0004GS-OY
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 11:47:01 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-patch-2.4.22-7 without CONFIG_MODE_TT failed
References: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com> <20031218192158.GB3388@ccure.user-mode-linux.org>
In-Reply-To: <20031218192158.GB3388@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312182050.55543.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 20:50:55 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:21, gioved=EC 18 dicembre 2003, Jeff Dike ha scritto:
> On Thu, Dec 18, 2003 at 03:24:06PM +0800, Jeff Chua wrote:
> > Can't compile without CONFIG_MODE_TT. 2.4.22-5 has no problem.
>
> Fixed, thanks.

Would you either post the fix or release -8? Or maybe it's on CVS(but you p=
ost=20
a release for each CVS commit, right?)

In general:
Maybe before than on the site you should announce the release here providin=
g=20
the file as a link, get the silly compile errors and release on the site th=
e=20
patched version. Since -6 to -7 hostaudio needed that silly fix for=20
modules... it's so unpleasant.

Or just build or use a compilation test-suite...

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
