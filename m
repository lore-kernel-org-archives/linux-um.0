Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ANcCL-0000YR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 22 Nov 2003 10:09:33 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ANcCJ-0006iK-JI
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 22 Nov 2003 10:09:31 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
References: <200311201915.29188.blaisorblade_spam@yahoo.it> <200311202037.14480.blaisorblade_spam@yahoo.it> <200311210222.hAL2Mt4L004145@ccure.user-mode-linux.org>
In-Reply-To: <200311210222.hAL2Mt4L004145@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311221912.44945.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 22 Nov 2003 19:12:44 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 03:22, venerd=EC 21 novembre 2003, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > I think hostfs reads files just as any normal process on the host,
> > right? Or  it does anything special or at least unusual?
>
> Nothing unusual, just normal file IO.
>
> > Could the unusual thing be the context switching of SKAS? I'll test if
> > it happens within TT mode.
>
> I doubt there's any difference.
Hmmm... maybe the VM code handling this does some VM assumption... false wi=
th=20
SKAS. And then, I saw that mm/shmem.c, to create shared memory, creates an =

"unlinked file under tmpfs"(quote from a function description I read there)=
.=20
And maybe, there are even other operations which could, then, be relevant=20
here.

Does UML uses shared memory? Or maybe just threading could be the issue?
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
