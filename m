Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJbGg-0006Uy-LI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:42 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BJbGg-0006UD-1O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-user] Re: [uml-devel] patch for 2.6.6-rc1
References: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
	<Pine.LNX.4.58.0404220806000.7782@boston.corp.fedex.com>
	<40877E45.7070608@fastwebnet.it>
In-Reply-To: <40877E45.7070608@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404301701.41470.blaisorblade_spam@yahoo.it>
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
Date: Fri, 30 Apr 2004 17:01:41 +0200
Content-Transfer-Encoding: quoted-printable
To: Primero <primero@fastwebnet.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Alle 10:11, gioved=EC 22 aprile 2004, Primero ha scritto:
> Jeff Chua wrote:
> >On Thu, 22 Apr 2004, roland wrote:
> >>uml-patch-2.6.4-1.bz2 doesn`t apply to 2.6.6-rc1/2 (hunks failed)
> >>
> >>>You must apply uml-patch-2.6.4-1.bz2 (or the attached uml-patch-2.6.6-=
0)
> >
> >Have you tried uml-patch-2.6.6-0 instead of uml-patch-2.6.4-1 ?
>
> Hi all, i'm new on the ML and on UML... I've got some problems of
> perfomance of my 2.6.3 guest kernel on a 2.6.5 host kernel on Gentoo.
> Reading as much as i can i think that could be a problem because i've
> not a SKAS3 patched host kernel ... so, where can i find a 2.6.5 SKAS
> patch or , much better , the 2.6.6 SKAS patch that is called above?
Well, we do not have a 2.6.6 stable kernel (there are pre-releases though),=
 so=20
you should use the 2.6.3 skas patch from here (which works even against 2.6=
.4=20
and 2.6.5 perfectly). Read the instructions please!

http://www.user-mode-linux.org/~blaisorblade/

This is the URL for the exact patch file:

http://www.user-mode-linux.org/~blaisorblade/patches/host-skas3-2.6.3-v1.pa=
tch

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
