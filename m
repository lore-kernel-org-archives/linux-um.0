Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXPpt-0000wZ-JU
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 10:58:53 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AXPpt-0000zY-23
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 10:58:53 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [UML combo patch] 2.6.0 host-skas kernel & UML kernel patch
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181304250.3617@earth>
In-Reply-To: <Pine.LNX.4.58.0312181304250.3617@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312191959.27377.blaisorblade_spam@yahoo.it>
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
Date: Fri, 19 Dec 2003 19:59:27 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 13:15, gioved=EC 18 dicembre 2003, Ingo Molnar ha scritto:
> for the lazy, i've distilled a combo patch that can be applied to a
> vanilla 2.6.0 kernel:
>
> 	redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A1
>
> and will compile both as a working 2.6.0 UML kernel and as a working
> host-skas 2.6.0 kernel. Older UML kernels should work on this host-kernel
> too.
>
> WARNING: this is an experimental patch, UML kernels compiled with this
> patch wont work in skas mode on older host-skas patched kernels.

Does this warning refers to any of the other patches you posted? To which o=
ne=20
especially? Is this related to the removal of MM_COPY_SEGMENTS ?

Also, if there is any incompatibility, it should be named skas4. But since =

Jeff Dike's will release skas4, even improving skas3 by breaking=20
compatibility is not useful. And if it is accepted, it should at least be=20
released also for 2.4(the guest 2.4/2.6 choice must be unrelated to the hos=
t=20
choice).

Bye, and thanks for your work here!
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
