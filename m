Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYsZb-00078Z-13
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 11:52:07 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AYsZa-0004Dn-F6
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 11:52:06 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML on Alpha
References: <20031220052032.GC1152@erdos.home> <20031220173249.GC10692@ccure.user-mode-linux.org> <20031222041951.GB1023@erdos.home>
In-Reply-To: <20031222041951.GB1023@erdos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312232055.21950.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Dec 2003 20:55:21 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 05:19, luned=EC 22 dicembre 2003, Cameron Patrick ha scritto:

> Okay.  It doesn't seem to be there in 2.4.x, but I'll have a look at 2.6
> some time and see if that makes this problem disappear.
>
> | > cross-compile UML.  Unfortunately that would mean some way of getting
> | > rid of mk_sc/mk_thread/mk_kern/etc, and I'm not sure what the best
> | > approach to doing that would be :-/
> |
> | There was a bit of work in that direction a while back.  What I think
> | would be a good way to go is to have a arch_headers rule in the Makefil=
e,
> | which would execute on the target, and generate the headers.  They would
> | land in a single directory, which you would then copy over to the build
> | box. The build there would use those headers, or generate them itself if
> | they weren't present.

Sorry, I'm giving a look here and it seems that the problem is just for=20
mk_ptregs and mk_sc(since the others include the building kernel includes) =

and that they need only the target headers; this could maybe be accomplishe=
d=20
just by copying them; and since what we *actually* need seems to be just as=
m/=20
headers, this can be accomplished simply by having a kernel tree with the a=
sm=20
symlink going to asm-<target arch>(that is much more available than the=20
target machine itself, right?). So, specifying an include path for those=20
files could be just fine, couldn't it? However, if we use your separate rul=
e=20
idea, within that we could use either just the headers or the host machine;=
=20
so some problems go away(i.e. the kernel tree must match the target machine=
's=20
one for the interested decls).

Note: mk_sc includes <signal.h>, which could be a problem. But it seems als=
o=20
that we can get away by just including asm/sigcontext.h.

Bye
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
